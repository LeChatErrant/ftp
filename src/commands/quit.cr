module Ftp
  private class Commands
    def self.quit(user, args)
      user.reply(221, "Goodbye.")
      user.quit
    end
  end
end
