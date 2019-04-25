require "../Commands.cr"

def help(user, args)
  str = String.build do |io|
    io << "The following commands are recongnized:\n"
    Commands::COMMANDS.each {|key, _| io << key << " "}
  end
  str = str.rstrip
  user.reply(214, str)
  user.reply(214, "Help OK.")
end