module Ftp
  private def unknown(user, args)
    user.reply(500, "Unknown command.")
  end
end
