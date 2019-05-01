def pasv(user, args)
  binded_port = Random.rand(65535 - 1023) + 1023
  user.data_server.try &.close
  user.data_server = TCPServer.new("0.0.0.0", binded_port, 1)
  user.is_activ = false
  user.logger.info "Entering passiv mode (port:#{binded_port}"
rescue
  user.reply(527, "PASV failed")
end