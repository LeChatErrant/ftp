require "json"
require "yaml"

module CrystalFTP

  class CrystalFTPJSON
    JSON.mapping(
      version: String,
      password: String,
      anonymous: String,
      default_port: Int32,
      default_root: String,
      )
  end

  class FromJSON
  property file_path : String
  getter config_json : CrystalFTPJSON

    def initialize(@file_path : String)
      if !File.exists?(@file_path)
        raise "File doesnt exist."
      end
      @config_json = CrystalFTPJSON.from_json(File.read(@file_path))
    end
  end

  class CrystalFTPYAML
    YAML.mapping(
      version: String,
      password: String,
      anonymous: String,
      default_port: Int32,
      default_root: String,
    )
  end

  class FromYAML
    property file_path : String
    getter config_yaml : CrystalFTPYAML

    def initialize(@file_path : String)
      if !File.exists?(@file_path)
        raise "File doesnt exist."
      end
      @config_yaml = CrystalFTPYAML.from_yaml(File.read(@file_path))
    end
  end
end
