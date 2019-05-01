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

    def initialize(@socket : TCPSocket, @root : String, @logger : Logger)
      @working_directory = root
    end

    # TODO: multiline response
    def reply(code : Int32, message : String)
      @logger.debug "Code [#{code}] : #{message}"
      socket << code << " " << message << "\r\n"
    end

    def quit
      socket.close()
    end

    def data_transfert(command : String, args : Array(String), code : Int32, message : String)
      if @is_activ
        activ_data_transfert(command, args, code, message)
      else
        passiv_data_transfert(command, args, code, message)
      end
    end

    private def passiv_data_transfert(command : String, args : Array(String), code : Int32, message : String)
      spawn do
        unless activ_socket = @data_socket
          reply(425, "Use PORT or PASV first")
          next
        end
      rescue e
      ensure
        @data_server.try &.close
        @data_server = nil
      end
    end

    private def activ_data_transfert(command : String, args : Array(String), code : Int32, message : String)
      spawn do
        unless activ_socket = @data_socket
          reply(425, "Use PORT or PASV first")
          next
        end
        activ_socket.connect(@activ_ip, @activ_port)
        reply(code, message)
        Process.run(command, args, output: activ_socket, error: activ_socket)
        reply(226, "Data transfert success")
      rescue e
        reply(425, "Data transfert failed. (#{e.message})")
      ensure
        @data_socket.try &.close
        @data_socket = nil
      end
    end

  end
end