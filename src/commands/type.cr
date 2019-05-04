module CrystalFTP
  private def type(user, args)
    if args.size != 1
      user.reply(500, "Unrecognized type command.")
    elsif args[0] == "I"
      user.reply(200, "Switching to Binary Mode.")
    elsif args[0] == "A"
      user.reply(200, "Switching to ASCII Mode.")
    else
      user.reply(500, "Unrecognized type command.")
    end
  end
end
