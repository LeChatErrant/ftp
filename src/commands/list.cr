module Ftp
  private class Commands
    def self.list(user, args)
      process_args = ["-la"]
      process_args << (args.size > 0 ? File.expand_path(args[0], user.working_directory) : user.working_directory)
      user.logger.info "Data transfert started : ls #{process_args}"
      user.data_transfert("ls", process_args, 150, "Here come the listing.")
    end
  end
end
