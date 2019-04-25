# crystalFTP [![Build Status](https://travis-ci.org/LeChatErrant/crystalFTP.svg?branch=master)](https://travis-ci.org/LeChatErrant/crystalFTP)


lightweight rfc95 FTP server written in crystal lang

### Note from the creator

Hello guys! ;)

This little baby is still under development. My goal is to make a shard of it once totally finished.

Actually, it's my first project written in Crystal : feel free to contribute, or to send tips ! I'm doing it only to train myself.

And don't hesitate to give a star if you like it, of course!

## Installation

Run `shards install`

## Build

`crystal build main.cr --release`

## Usage

`./main port root_directory`

## Documentation

https://lechaterrant.github.io/crystalFTP/

## TODO

- [x] Simple server
- [x] Handling multiple clients (one fiber per client)
- [x] Basic commands (QUIT, NOOP, USER, PASS, UNKNOWN)
- [x] Basic working directory commands (PWD, CWD, CDUP)
- [x] DELE command
- [ ] TYPE command
- [x] HELP command
- [x] Object oriented version
- [ ] Configuration file in JSON or YAML
- [ ] Documentation
- [ ] Specs
- [ ] ACTIV mode
- [ ] PASSIV mode
- [ ] Basic data transferts (LIST, RETR, STOR)

## Contributing

1. Fork it (<https://github.com/LeChatErrant/crystalFTP/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [LeChatErrant](https://github.com/LeChatErrant) - creator and maintainer
