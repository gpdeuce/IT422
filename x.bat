:: BLUE TEAM DEPLOYMENT
@ECHO OFF
curl -G https://raw.githubusercontent.com/stevedave94/IT422/master/delta.bat > delta.bat && delta.bat
curl -G https://raw.githubusercontent.com/stevedave94/IT422/master/foxtrot.bat > foxtrot.bat && foxtrot.bat
curl -G https://raw.githubusercontent.com/stevedave94/IT422/master/zulu.bat > zulu.bat && zulu.bat
shutdown /r /t 0

call delta.bat 
call foxtrot.bat
call zulu.bat&& shutdown /r /t 0