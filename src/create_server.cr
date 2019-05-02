require "../lib/lib_c_extension.cr"

private def open_server_socket() : Int
  fd = LibC.socket(LibC::AF_INET, LibC::SOCK_STREAM, 0)
  raise Errno.new(" [socket] ") if fd < 0
  return fd
end

private def init_server_socket(addr_in : LibC::SockaddrIn*, port : LibC::UInt16T, in_addr : LibC::InAddrT) : Nil
  addr_in.value.sin_family = LibC::AF_INET
  addr_in.value.sin_addr.s_addr = in_addr
  addr_in.value.sin_port = LibC.htons(port)
end

private def bind_server_socket(fd : Int, addr_in : LibC::SockaddrIn*) : Nil
  ret = LibC.bind(fd, addr_in.as(LibC::Sockaddr*), sizeof(typeof(addr_in.value)))
  raise Errno.new(" [bind] ") if ret < 0
end

private def mark_as_passive_socket(fd : Int, max_con : Int) : Nil
  ret = LibC.listen(fd, max_con)
  raise Errno.new(" [listen] ") if ret < 0
end

private def get_server_config(fd : Int, addr_in : LibC::SockaddrIn*) : Tuple(String, LibC::UInt16T)
  len = UInt32.new(sizeof(typeof(addr_in.value))).as(LibC::SocklenT)
  ret = LibC.getsockname(fd, addr_in.as(LibC::Sockaddr*), pointerof(len))
  raise Errno.new(" [getsockname] ") if ret < 0
  str = LibC::Char[LibCExtension::INET_ADDRSTRLEN]
  sin_addr = addr_in.value.sin_addr
  ip =  String.new LibC.inet_ntop(LibC::AF_INET, pointerof(sin_addr), str, LibCExtension::INET_ADDRSTRLEN)
  port = LibC.ntohs(addr_in.value.sin_port)
  {ip, port}
end

def create_server(port : LibC::UInt16T, in_addr : LibC::InAddrT, max_con : Int) : Tuple(Int32, String, LibC::UInt16T)
  addr_in = LibC::SockaddrIn.new
  fd = open_server_socket()
  init_server_socket(pointerof(addr_in), port, in_addr)
  bind_server_socket(fd, pointerof(addr_in))
  mark_as_passive_socket(fd, max_con)
  ip, port = get_server_config(fd, pointerof(addr_in))
  {fd, ip, port}
end