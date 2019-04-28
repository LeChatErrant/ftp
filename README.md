# CrystalFTP
[![Build Status](https://travis-ci.org/LeChatErrant/crystalFTP.svg?branch=master)](https://travis-ci.org/LeChatErrant/crystalFTP)
[![star this repo](http://githubbadges.com/star.svg?user=LeChatErrant&repo=crystalFTP&style=default)](https://github.com/LeChatErrant/crystalFTP)
[![fork this repo](http://githubbadges.com/fork.svg?user=LeChatErrant&repo=crystalFTP&style=default)](https://github.com/LeChatErrant/crystalFTP/fork)
[![GitHub Issues](https://img.shields.io/github/issues/LeChatErrant/crystalFTP.svg)](https://github.com/LeChatErrant/crystalFTP/issues)
[![GitHub contributors](https://img.shields.io/github/contributors/LeChatErrant/crystalFTP.svg)](https://GitHub.com/LeChatErrant/crystalFTP/graphs/contributors/)
![Contributions welcome](https://img.shields.io/badge/contributions-welcome-green.svg)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
> lightweight rfc95 FTP server written in crystal lang

### Note from the creator

Hello guys! ;)

This little baby is still under development. My goal is to make a shard of it once totally finished.

Actually, it's my first project written in Crystal : feel free to contribute, or to send tips ! I'm doing it only to train myself.

And don't hesitate to give a star if you like it, of course!

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  CrystalFTP:
    github: LeChatErrant/CrystalFTP
```

2. Run `shards install`

## Usage

```crystal
require "CrystalFTP"

server = CrystalFTP::FTPServer.new(8000, "/home)
server.start
sleep

```

## Run example

You can find an example of utilisation at the root of the repository

To try it, simply run `crystal build example.cr --release`

Then you can execute it with `./example port root_directory`

This will run a FTP server, listening on the specified port and mounted on 'root_directory"

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
- [x] Documentation
- [ ] Specs
- [ ] ACTIV mode
- [ ] PASSIV mode
- [ ] Basic data transferts (LIST, RETR, STOR)
- [ ] Other RFC95 compliant commands
- [x] Making a shard of it

## Contributing

1. Fork it (<https://github.com/LeChatErrant/CrystalFTP/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [LeChatErrant](https://github.com/LeChatErrant) - creator and maintainer
