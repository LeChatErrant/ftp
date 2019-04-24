def pasv(user, args)
  binded_port = Random.rand(65535 - 1023) + 1023
  puts binded_port
  user.server = TCPServer.new("0.0.0.0", binded_port, 1)
rescue
  FTPServer.reply(user.socket, 527, "PASV failed")
end