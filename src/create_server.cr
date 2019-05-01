require "../lib/lib_c_extension.cr"

def create_server(port : LibC::UInt16T, in_addr : LibC::InAddrT)
  fd = LibC.socket(LibC::AF_INET, LibC::SOCK_STREAM, 0)
  raise Errno.new(" [socket] ") if fd < 0

  addr_in = LibC::SockaddrIn.new
  puts addr_in
  addr_in.sin_family = LibC::AF_INET
  addr_in.sin_addr.s_addr = in_addr
  addr_in.sin_port = LibC.htons(port)

  raise Errno.new(" [bind] ") if LibC.bind(fd, pointerof(addr_in).as(LibC::Sockaddr*), sizeof(typeof(addr_in))) < 0

  return fd
end