require "socket"
require "./FTPServer.cr"

module Commands
  COMMANDS = {
    "quit" => ->quit(FTPServer::User, Array(String)),
    "noop" => ->noop(FTPServer::User, Array(String)),
    "help" => ->help(FTPServer::User, Array(String)),
    "user" => ->user(FTPServer::User, Array(String)),
    "pass" => ->pass(FTPServer::User, Array(String)),
    "type" => ->type(FTPServer::User, Array(String))
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