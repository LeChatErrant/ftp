require "./src/CrystalFTP.cr"

if ARGV.size != 2
    STDERR.puts "Usage:\n\t./crystalFTP port root"
    exit 84
end

include CrystalFTP

port, root = ARGV

puts FTPServer::VERSION
server = FTPServer.new(port: port.to_i, root: root)
server.start
sleep
