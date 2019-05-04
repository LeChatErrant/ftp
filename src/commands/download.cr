module Ftp
  private def download(user, args)
    return user.reply(550, "Permission denied.") if args.size < 1
    path = File.expand_path(args[0], user.working_directory)
    return user.reply(550, "Permission denied.") unless File.exists? path
    user.data_transfert("cat", [path], 150, "Opening data connection.")
  end
end
