require "file_utils"

module Ftp
  private def size(user, args)
    return user.reply(501, "Syntax error") if args.size != 1
    path = File.expand_path(args[0], user.working_directory)
    return user.reply(550, "No such file or directory") unless File.exists?(path)
    user.logger.warn "SIZE #{path}..."
    size = File.size(path)
    user.reply(213, "#{size}")
  rescue e
    user.logger.error e.message
    user.reply(550, "#{e.message}")
  end
end
