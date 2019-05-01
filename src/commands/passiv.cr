require "../create_server.cr"

def pasv(user, args)

  # # experiment with random port... not concluant
  # binded_port = Random.rand(65535 - 1023) + 1023
  # binded_port = 0
  # user.data_server.try &.close
  # user.data_server = TCPServer.new("0.0.0.0", binded_port, 1)

  addr_in = LibC::SockaddrIn.new

  fd = create_server(0, LibCExtension.htonl(LibCExtension::INADDR_ANY), pointerof(addr_in), 1)
  puts fd
  puts get_server_config(fd, pointerof(addr_in))

  # user.is_activ = false
  # user.logger.info "Entering passiv mode (port:#{binded_port}"
rescue e
  user.reply(527, "PASV failed : #{e.message}")
end