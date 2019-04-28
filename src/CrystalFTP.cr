require "socket"
require "./Commands.cr"
require "./User.cr"
require "./Config.cr"

# An FTP server , or File Transfert Protocol server, is a server used to store files and interact with it from a remote client, through a protocol edicted by the RFC95
#
# CrystalFTP is the module containing the `FTPServer` class, the main class for
#
# Example of utilisation
# ```
# include CrystalFTP
# server = FTPServer.new(8000, ".")
# server.start
# sleep
# ```
# This will launch a FTP server, listening for clients at port 8000, rooted in the current directory
module CrystalFTP

  # Example of utilisation
  # ```
  # include CrystalFTP
  # server = FTPServer.new(8000, ".")
  # server.start
  # sleep
  # ```
  # This will launch a FTP server, listening for clients at port 8000, rooted in the current directory
  class FTPServer

    # Port on which the server listen
    getter port

    # Path on which the server is mounted
    getter root

    include Config

    # Create a FTP server, configurate to listen to `port`, and mounted on `root`
    #
    # ```
    # my_ftp_server = CrystalFTP::FTPServer.new(port: 8000, root: "/home")
    # ```
    # NOTE : The returned FTP server is not listening for clients : it needs to be started, with `#start`
    # TODO : Add a configuration file, or any better to configure it than FTPServer::DEFAULT_PORT etc
    def initialize(@port : Int32 = FTPServer::DEFAULT_PORT, root : String = FTPServer::DEFAULT_ROOT )
      @server = TCPServer.new("0.0.0.0", port.to_i)
      @root = File.expand_path(root)
    end

    # Starting the FTP server, making clients able to connect and communicate with it
    #
    # NOTE: The exection is launched in a fiber, so the rest of your program is not blocked
    # ```
    # my_ftp_server.start
    # # From now, the server is accepting clients and handling them properly
    # sleep # Yield the execution
    def start
      spawn do
        puts "FTP server, rooted at #{@root}, now listening on port #{@port}..."
        loop &->accept_client
      end
    end

    private def accept_client()
      socket = @server.accept?
      return if socket.nil?
      handle_client(User.new(socket, @root))
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
