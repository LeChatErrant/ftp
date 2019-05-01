# def list(user, args)
#   return user.reply(425, "Use PORT or PASV first.") if user.server.nil?
#   process_args = ["-la"]
#   if args.size > 0
#     process_args << File.expand_path(args[0], user.working_directory)
#   else
#     process_args << user.working_directory
#   end
#   user.logger.info "Data transfert started : #{ls} #{process_args}"
#   spawn do
#     user.data_socket = user.server.try &.accept?
#     raise "An error occured" if user.data_socket.nil?
#     user.data_socket.try &.<<("FDP")
#     Process.run("ls", process_args)
#   end
# rescue
#   user.reply(425, "Data transfert failed.")
# end


def list(user, args)
  process_args = ["-la"]
  process_args << (args.size > 0 ?\
    File.expand_path(args[0], user.working_directory) :\
    user.working_directory)
  user.logger.info "Data transfert started : ls #{process_args}"
  user.is_activ ? user.activ_data_transfert : user.passiv_data_transfert
  Process.run("ls", process_args)
end