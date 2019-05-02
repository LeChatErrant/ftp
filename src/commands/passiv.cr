require "../create_server.cr"

private def send_passiv_config(user, ip, port)
  ip = ip.split(".")
  port = [port/256.as(Int), port%256]
  user.reply(227, "Entering passiv mode (#{ip[0]},#{ip[1]},#{ip[2]},#{ip[3]},#{port[0]},#{port[1]})")
end

def pasv(user, args)
  fd, ip, port = create_server(port: 0, in_addr: LibCExtension.htonl(LibCExtension::INADDR_ANY), max_con: 1)
  send_passiv_config(user, ip, port)
  user.data_server.try &.close
  user.data_server = TCPServer.new(fd: fd)
  user.is_activ = false
  user.logger.info "Entering passiv mode (#{ip}:#{port}"
rescue e
  user.reply(527, "PASV failed : #{e.message}")
end