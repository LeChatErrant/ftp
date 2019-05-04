require "file_utils"

module Ftp
  private def dele(user, args)
    return user.reply(550, "Failed to delete file.") if args.size != 1
    path = File.expand_path(args[0], user.working_directory)
    return user.reply(550, "Failed to delete file.") if !File.exists? path
    user.logger.warn "Deleting #{path}..."
    FileUtils.rm_r path
    user.logger.info "#{path} deleted"
    user.reply(250, "File successfully deleted.")
  rescue e
    user.logger.error e.message
    user.reply(550, "#{e.message}")
  end
end
