module User
  extend self

  class UserData
    getter root : String
    property socket : TCPSocket
    property server : TCPServer | Nil
    property data_socket : TCPSocket | Nil
    property working_directory : String
    property is_authentified = false
    property is_activ = false
    property username = nil.as(String | Nil)

    def initialize(@socket, @root)
      @working_directory = root
    end

    def reply(code, message)
      socket << code << " " << message << "\r\n"
    end

    def quit()
      socket.close()
    end

  end
end
