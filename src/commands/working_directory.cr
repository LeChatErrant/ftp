def pwd(user, args)
  user.reply(257, "\"#{user.working_directory}\"")
end

def cwd(user, args)
  return user.reply(550, "Failed to change directory.") if args.size != 1
  path = File.expand_path(args[0], user.working_directory)
  if !File.directory? path
    user.reply(550, "Failed to change directory.")
  else
    user.working_directory = path
    user.reply(250, "Directory successfully changed.")
  end
end

def cdup(user, args)
  cwd(user, [".."])
end