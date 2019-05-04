module Ftp
  private class Commands
    def self.noop(user, args)
      user.reply(200, "NOOP ok.")
    end
  end
end
