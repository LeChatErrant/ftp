require "./FTPServer"

if ARGV.size != 2
    STDERR.puts "Usage:\n\t./crystalFTP port root"
    exit 84
end

port, root = ARGV

server = FTPServer.new(port.to_i, root)
server.start
sleep