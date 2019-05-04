require "./src/Config.cr"

include CrystalFTP

begin
  test_var = FromYAML.new("test.yaml")
  puts test_var.config_yaml.default_port
rescue exception
  puts "Error"
  puts exception
end
