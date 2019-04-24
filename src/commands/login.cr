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
  elsif user.username == FTPServer::ANONYMOUS || args[0] == FTPServer::PASSWORD
    user.is_authentified = true
    FTPServer.reply(user.socket, 230, "Login successful.")
  else
    FTPServer.reply(user.socket, 530, "Login incorrect")
  end
end