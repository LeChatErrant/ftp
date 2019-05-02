module CrystalFTP
  private def noop(user, args)
    user.reply(200, "NOOP ok.")
  end
end