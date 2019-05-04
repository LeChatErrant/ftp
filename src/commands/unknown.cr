module Ftp
  private class Commands
    def self.unknown(user, args)
      user.reply(500, "Unknown command.")
    end
  end
end
