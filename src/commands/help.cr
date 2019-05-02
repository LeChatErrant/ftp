require "../Commands.cr"

module CrystalFTP
  private def help(user, args)
    str = String.build do |io|
      io << "The following commands are recongnized:\n"
      CrystalFTP::FTPServer::COMMANDS.each {|key, _| io << key << " "}
    end
    str = str.rstrip
    user.reply(214, str)
    user.reply(214, "Help OK.")
  end
end