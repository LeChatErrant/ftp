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