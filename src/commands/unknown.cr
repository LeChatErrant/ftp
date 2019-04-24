def unknown(user, args)
  FTPServer.reply(user.socket, 500, "Unknown command.")
end