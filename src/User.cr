module User
  class User
    getter root : String
    property socket : TCPSocket
    property data_socket : TCPSocket | Nil
    property working_directory : String
    property is_authentified = false
    property is_activ = false
    property username = nil.as(String | Nil)

    def initialize(@socket, @root)
      @working_directory = root
    end
  end
end
