require "logger"

module CrystalFTP

  private class User

    getter root : String
    getter logger : Logger
    property socket : TCPSocket
    property server : TCPServer | Nil
    property data_socket : TCPSocket | Nil
    property working_directory : String
    property is_authentified = false
    property is_activ = false
    property username = nil.as(String | Nil)

    def initialize(@socket, @root, @logger)
      @working_directory = root
    end

    def reply(code, message)
      @logger.debug "Code [#{code}] : #{message}"
      socket << code << " " << message << "\r\n"
    end

    def quit()
      socket.close()
    end

  end

end
