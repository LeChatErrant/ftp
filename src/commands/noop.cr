def noop(user, args)
  FTPServer.reply(user.socket, 200, "NOOP ok.")
end