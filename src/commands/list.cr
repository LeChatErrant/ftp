def list(user, args)
  return user.reply(425, "Use PORT or PASV first.") if user.server.nil?
  process_args = ["-la"]
  if args.size > 0
    process_args << File.expand_path(args[0], user.working_directory)
  else
    process_args << user.working_directory
  end
  spawn do
    user.data_socket = user.server.try &.accept?
    raise "An error occured" if user.data_socket.nil?
    user.data_socket.try &.<<("FDP")
    Process.run("ls", process_args)
    puts "Connected, and DT finished"
  end
rescue
  user.reply(425, "Data transfert failed.")
end