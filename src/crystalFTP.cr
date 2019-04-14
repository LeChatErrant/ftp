require "./FTPServer"

if ARGV.size != 2
    STDERR.puts "Usage"
    exit
end

port, root = ARGV

server = FTPServer.new(port.to_i, root)
server.start
sleep