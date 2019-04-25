# TODO: Write documentation for `CrystalFTP`

require "socket"
require "./Commands.cr"
require "./User.cr"
require "./Config.cr"

module CrystalFTP

  class FTPServer
    getter port
    getter root

    include Commands
    include Config

    def initialize(@port = FTPServer::DEFAULT_PORT, root = FTPServer::DEFAULT_ROOT)
      @server = TCPServer.new("0.0.0.0", port.to_i)
      @root = File.expand_path(root)
    end

    def start
      spawn do
        puts "FTP server, rooted at #{@root}, now listening on port #{@port}..."
        loop &->accept_client
      end
    end

    private def accept_client()
      socket = @server.accept?
      return if socket.nil?
      handle_client(User::UserData.new(socket, @root))
    end

    private def handle_client(user)
      spawn do
        puts "New user!"
        welcome user
        while !user.socket.closed? && (line = user.socket.gets)
          handle_request(user, line.rstrip)
        end
        puts "A user disconnected..."
      end
    end

    private def welcome(user)
      user.reply(220, "Welcome on crystalFTP server!")
    end

    private def parse_command(message)
      args = message.split(" ")
      command = args.shift
      puts "Command: #{command}, args: #{args}"
      {command, args}
    end

    private def is_authentified?(user, command)
      if !user.is_authentified && !ANONYM_COMMANDS.includes? command
        user.reply(530, "Please login with USER and PASS.")
        return false
      end
      true
    end

    private def handle_request(user, message)
      command, args = parse_command message
      return if !is_authentified? user, command
      callback = COMMANDS[command.downcase]?
      callback ||= COMMANDS["unknown"]
      callback.call(user, args)
    end

  end
end
