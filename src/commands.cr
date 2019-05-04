require "socket"
require "./commands/**"
require "./user.cr"

class Ftp::FTPServer
  # :nodoc:
  # Commands which can be used without being logged
  ANONYM_COMMANDS = {"quit", "user", "pass", "help"}

  # :nodoc:
  # List of available commands, binded to their callbacks
  COMMANDS = {
    "quit"    => ->quit(User, Array(String)),
    "noop"    => ->noop(User, Array(String)),
    "help"    => ->help(User, Array(String)),
    "user"    => ->user(User, Array(String)),
    "pass"    => ->pass(User, Array(String)),
    "pwd"     => ->pwd(User, Array(String)),
    "cwd"     => ->cwd(User, Array(String)),
    "cdup"    => ->cdup(User, Array(String)),
    "type"    => ->type(User, Array(String)),
    "dele"    => ->dele(User, Array(String)),
    "size"    => ->size(User, Array(String)),
    "pasv"    => ->pasv(User, Array(String)),
    "port"    => ->port(User, Array(String)),
    "list"    => ->list(User, Array(String)),
    "retr"    => ->download(User, Array(String)),
    "stor"    => ->upload(User, Array(String)),
    "unknown" => ->unknown(User, Array(String)),
  }
end
