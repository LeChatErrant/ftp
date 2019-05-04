module CrystalFTP
  private def upload(user, args)
    return user.reply(550, "Permission denied.") if args.size < 1
    path = File.expand_path(args[0], user.working_directory)
    fd = File.open(path, "w")
    user.data_transfert("cat", [] of String, 150, "Opening data connection.", fd)
  rescue e
    user.reply(550, "Permission denied. (#{e.message})")
  end
end
