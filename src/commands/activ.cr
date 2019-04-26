private def parse_arg(arg)
  arg = arg.split(",")
  return {nil, nil} if arg.size != 6
  ip = "#{arg[0]},#{arg[1]},#{arg[2]},#{arg[3]}"
  port = arg[4].to_i * 256 + arg[5].to_i
  {ip, port}
end

def port(user, args)
  return user.reply(500, "Illegal PORT command.") if args.size != 1
  ip, port = parse_arg(args[0])
  return user.reply(500, "Illegal PORT command.") if !ip || !port
  user.reply(200, "PORT command successful (ip:#{ip}, port:#{port}). Consider using PASV.")
  #TODO: Connect here
end