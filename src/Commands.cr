require "socket"
require "./User.cr"

module Commands
  COMMANDS = {
  "quit" => ->quit(User::UserData, Array(String)),
  "noop" => ->noop(User::UserData, Array(String)),
  "help" => ->help(User::UserData, Array(String)),
  "user" => ->user(User::UserData, Array(String)),
  "pass" => ->pass(User::UserData, Array(String)),
  "pwd" => ->pwd(User::UserData, Array(String)),
  "cwd" => ->cwd(User::UserData, Array(String)),
  "cdup" => ->cdup(User::UserData, Array(String)),
  "type" => ->type(User::UserData, Array(String)),
  "dele" => ->dele(User::UserData, Array(String)),
  "pasv" => ->pasv(User::UserData, Array(String)),
  "port" => ->port(User::UserData, Array(String)),
  "list" => ->list(User::UserData, Array(String)),
  "unknown" => ->unknown(User::UserData, Array(String))
}

ANONYM_COMMANDS = { "quit", "user", "pass" }
end

# alias FTPCallback = Proc(TCPSocket, Array(String))

# quit = FTPCallback.new

def quit(user, args)
  FTPServer.reply(user.socket, 221, "Goodbye.")
  user.socket.close()
end

def noop(user, args)
  FTPServer.reply(user.socket, 200, "NOOP ok.")
end

def help(user, args)
  FTPServer.reply(user.socket, 214, "The following commands are recognized:\n"\
  "ABOR ACCT ALLO APPE CDUP CWD  DELE EPRT EPSV FEAT HELP LIST MDTM MKD\n"\
  "MODE NLST NOOP OPTS PASS PASV PORT PWD  QUIT REIN REST RETR RMD  RNFR\n"\
  "RNTO SITE SIZE SMNT STAT STOR STOU STRU SYST TYPE USER XCUP XCWD XMKD\n"\
  "XPWD XRMD")
  FTPServer.reply(user.socket, 214, "Help OK.")
end

def type(user, args)
  if args.size != 1
    FTPServer.reply(user.socket, 500, "Unrecognized type command.")
  elsif args[0] == "I"
    FTPServer.reply(user.socket, 200, "Switching to Binary Mode.")
  elsif args[0] == "A"
    FTPServer.reply(user.socket, 200, "Switching to ASCII Mode.")
  else
    FTPServer.reply(user.socket, 500, "Unrecognized type command.")
  end
end

def user(user user_session, args)
  if args.size != 1
    FTPServer.reply(user_session.socket, 530, "Permission denied.")
  elsif user_session.is_authentified
    FTPServer.reply(user_session.socket, 530, "Can't change user.")
  else
    FTPServer.reply(user_session.socket, 330, "Please specify the password.")
    user_session.username = args[0].downcase
  end
end

def pass(user, args)
  if user.is_authentified
    FTPServer.reply(user.socket, 230, "Already logged in.")
  elsif user.username.nil?
    FTPServer.reply(user.socket, 503, "Login with USER first.")
  elsif user.username == FTPServer.anonymous || args[0] == FTPServer.password
    user.is_authentified = true
    FTPServer.reply(user.socket, 230, "Login successful.")
  else
    FTPServer.reply(user.socket, 530, "Login incorrect")
  end
end

def pwd(user, args)
  FTPServer.reply(user.socket, 257, "\"#{user.working_directory}\"")
end

def unknown(user, args)
  FTPServer.reply(user.socket, 500, "Unknown command.")
end

def cwd(user, args)
  return FTPServer.reply(user.socket, 550, "Failed to change directory.") if args.size != 1
  path = File.expand_path(args[0], user.working_directory)
  if !File.directory? path
    FTPServer.reply(user.socket, 550, "Failed to change directory.")
  else
    user.working_directory = path
    FTPServer.reply(user.socket, 250, "Directory successfully changed.")
  end
end

def cdup(user, args)
  cwd(user, [".."])
end

def rm_r(path : String) : Nil
  if Dir.exists?(path) && !File.symlink?(path)
    Dir.each_child(path) do |entry|
      src = File.join(path, entry)
      rm_r(src)
    end
    Dir.rmdir(path)
  else
    File.delete(path)
  end
end

def dele(user, args)
  return FTPServer.reply(user.socket, 550, "Failed to delete file.") if args.size != 1
  path = File.expand_path(args[0], user.working_directory)
  return FTPServer.reply(user.socket, 550, "Failed to delete file.") if !File.exists? args[0]
  user.working_directory = File.expand_path("..", user.working_directory) if path == user.working_directory
  rm_r path
  FTPServer.reply(user.socket, 250, "File successfully deleted.")
rescue e
  puts e.message
  FTPServer.reply(user.socket, 550, "Failed to delete file.")
end

def port(user, args)
end

def pasv(user, args)
  binded_port = Random.rand(65535 - 1023) + 1023
  puts binded_port
  user.server = TCPServer.new("0.0.0.0", binded_port, 1)
rescue
  FTPServer.reply(user.socket, 527, "PASV failed")
end

def list(user, args)
  return FTPServer.reply(user.socket, 425, "Use PORT or PASV first.") if user.server.nil?
  process_args = ["-la"]
  if args.size > 0
    process_args << File.expand_path(args[0], user.working_directory)
  else
    process_args << user.working_directory
  end
  spawn do
    user.data_socket = user.server.try &.accept?
    raise "An error occured" if user.data_socket.nil?
    user.data_socket.try &.<<("FDP")
    Process.run("ls", process_args)
    puts "Connected, and DT finished"
  end
rescue
  FTPServer.reply(user.socket, 425, "Data transfert failed.")
end