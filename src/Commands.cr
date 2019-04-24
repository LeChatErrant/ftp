require "socket"
require "./commands/**"
require "./User.cr"

module Commands

  ANONYM_COMMANDS = { "quit", "user", "pass" }

  COMMANDS = {
  "quit" => ->quit(User::UserData, Array(String)),
  "noop" => ->noop(User::UserData, Array(String)),
  "help" => ->help(User::UserData, Array(String)),
  "user" => ->user(User::UserData, Array(String)),
  "pass" => ->pass(User::UserData, Array(String)),
  "pwd" => ->pwd(User::UserData, Array(String)),
  "cwd" => ->cwd(User::UserData, Array(String)),
  "cdup" => ->cdup(User::UserData, Array(String)),
  "type" => ->type(User::UserData, Array(String)),
  "dele" => ->dele(User::UserData, Array(String)),
  "pasv" => ->pasv(User::UserData, Array(String)),
  "port" => ->port(User::UserData, Array(String)),
  "list" => ->list(User::UserData, Array(String)),
  "unknown" => ->unknown(User::UserData, Array(String))
  }

end