require "socket"
require "./Commands"

class FTPServer
  getter port
  getter root

  @@password = "password"
  @@anonymous = "anonymous"

  include Commands

  class User
    property socket : TCPSocket
    property data_socket : TCPSocket | Nil
    property working_directory : String
    property is_authentified = false
    property is_activ = false
    property username = nil.as(String | Nil)

    def initialize(@socket, @working_directory)
    end
  end

  def initialize(@port = 8000, @root = ".")
    @server = TCPServer.new("0.0.0.0", port.to_i)
  end

  def start
    spawn do
      puts "Server now listening on port #{@port}..."
      loop do
        socket = @server.accept
        handle_client(User.new(socket, @root))
      end
    end
  end

  def handle_client(user)
    spawn do
      while !user.socket.closed? && (line = user.socket.gets)
        handle_request(user, line.chomp)
      end
    end
  end

  private def handle_request(user, message)
    args = message.split(" ")
    command = args.shift
    puts "Command: #{command}, args: #{args}"
    callback = COMMANDS[command.downcase]?
    if callback
      callback.call(user, args)
    else
      FTPServer.reply(user.socket, 500, "Unknown command.")
    end
  end

  def self.reply(socket, code, message)
    socket << code << " " << message << "\r\n"
  end

  def self.anonymous
    @@anonymous
  end

  def self.password
    @@password
  end
end
