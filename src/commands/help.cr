def help(user, args)
  FTPServer.reply(user.socket, 214, "The following commands are recognized:\n"\
  "ABOR ACCT ALLO APPE CDUP CWD  DELE EPRT EPSV FEAT HELP LIST MDTM MKD\n"\
  "MODE NLST NOOP OPTS PASS PASV PORT PWD  QUIT REIN REST RETR RMD  RNFR\n"\
  "RNTO SITE SIZE SMNT STAT STOR STOU STRU SYST TYPE USER XCUP XCWD XMKD\n"\
  "XPWD XRMD")
  FTPServer.reply(user.socket, 214, "Help OK.")
end