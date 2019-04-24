def pwd(user, args)
  FTPServer.reply(user.socket, 257, "\"#{user.working_directory}\"")
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