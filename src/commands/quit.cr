def quit(user, args)
  FTPServer.reply(user.socket, 221, "Goodbye.")
  user.socket.close()
end