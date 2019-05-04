require "../ftp.cr"

module Ftp
  private class Commands
    def self.user(user user_session, args)
      if args.size != 1
        user_session.reply(530, "Permission denied.")
      elsif user_session.is_authentified
        user_session.reply(530, "Can't change user.")
      else
        user_session.reply(330, "Please specify the password.")
        user_session.username = args[0].downcase
      end
    end

    def self.pass(user, args)
      if user.is_authentified
        user.reply(230, "Already logged in.")
      elsif user.username.nil?
        user.reply(503, "Login with USER first.")
      elsif user.username == Ftp::FTPServer::ANONYMOUS || args[0] == Ftp::FTPServer::PASSWORD
        user.is_authentified = true
        user.reply(230, "Login successful.")
      else
        user.reply(530, "Login incorrect")
      end
    end
  end
end
