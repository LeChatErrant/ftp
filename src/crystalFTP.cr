# TODO: Write documentation for `CrystalFTP`

require "socket"
require "./Commands"
require "./User"

module CrystalFTP
  VERSION = "0.1.0"

  class FTPServer
    getter port
    getter root

    @@password = "password"
    @@anonymous = "anonymous"

    include Commands

    def initialize(@port = 8000, root = '.')
      @server = TCPServer.new("0.0.0.0", port.to_i)
      @root = File.expand_path(root)
    end

    def start
      spawn do
        puts "FTP server, rooted at #{@root}, now listening on port #{@port}..."
        loop do
          socket = @server.accept?
          break if socket.nil?
          handle_client(User::UserData.new(socket, @root))
        end
      end
    end

    def handle_client(user)
      spawn do
        FTPServer.reply(user.socket, 220, "Welcome on crystalFTP server!")
        while !user.socket.closed? && (line = user.socket.gets)
          handle_request(user, line.rstrip)
        end
      end
    end

    private def handle_request(user, message)
      args = message.split(" ")
      command = args.shift
      puts "Command: #{command}, args: #{args}"
      if !user.is_authentified && !ANONYM_COMMANDS.includes? command
        FTPServer.reply(user.socket, 530, "Please login with USER and PASS.")
        return
      end
      callback = COMMANDS[command.downcase]?
      callback ||= COMMANDS["unknown"]
      callback.call(user, args)
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
end
