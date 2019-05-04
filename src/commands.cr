require "socket"
require "./commands/**"
require "./user.cr"

module Ftp
  class FTPServer

    # :nodoc:
    # Commands which can be used without being logged
    ANONYM_COMMANDS = {"quit", "user", "pass", "help"}

    # :nodoc:
    # List of available commands, binded to their callbacks
    COMMANDS = {
    "quit"    => ->Commands.quit(User, Array(String)),
    "noop"    => ->Commands.noop(User, Array(String)),
    "help"    => ->Commands.help(User, Array(String)),
    "user"    => ->Commands.user(User, Array(String)),
    "pass"    => ->Commands.pass(User, Array(String)),
    "pwd"     => ->Commands.pwd(User, Array(String)),
    "cwd"     => ->Commands.cwd(User, Array(String)),
    "cdup"    => ->Commands.cdup(User, Array(String)),
    "type"    => ->Commands.type(User, Array(String)),
    "dele"    => ->Commands.dele(User, Array(String)),
    "size"    => ->Commands.size(User, Array(String)),
    "pasv"    => ->Commands.pasv(User, Array(String)),
    "port"    => ->Commands.port(User, Array(String)),
    "list"    => ->Commands.list(User, Array(String)),
    "retr"    => ->Commands.download(User, Array(String)),
    "stor"    => ->Commands.upload(User, Array(String)),
    "unknown" => ->Commands.unknown(User, Array(String)),
    }
  end
end