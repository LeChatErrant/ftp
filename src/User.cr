require "logger"

module CrystalFTP

  private class User

    property username = nil.as(String | Nil)
    getter root : String
    getter logger : Logger
    property socket : TCPSocket
    property data_server : TCPServer | Nil
    property data_socket : TCPSocket | Nil
    property working_directory : String
    property is_authentified = false
    property is_activ = false
    property activ_port : Int32 = 0
    property activ_ip : String = ""

    def initialize(@socket, @root, @logger)
      @working_directory = root
    end

    # TODO: multiline response
    def reply(code, message)
      @logger.debug "Code [#{code}] : #{message}"
      socket << code << " " << message << "\r\n"
    end

    def quit
      socket.close()
    end

    def activ_data_transfert
      spawn do
        @data_server.try &.close
        @data_server = nil
      end
    end

    def passiv_data_transfert
      spawn do
        @data_socket.try &.close
        @data_socket = nil
      end
    end

  end

end
