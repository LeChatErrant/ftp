require "./src/CrystalFTP.cr"

if ARGV.size != 2
  STDERR.puts "Usage:\n\t./crystalFTP port root_directory"
  exit 84
end

include CrystalFTP

port, root = ARGV

puts "Using version #{FTPServer::VERSION}"

begin
  server = FTPServer.new(port: port.to_i, root: root)
  server.verbose_level = Logger::DEBUG
  server.start
rescue exception
  puts "Error: #{exception.message}"
end
sleep