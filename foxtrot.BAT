:: Make sure to change the username and password wherver necessary
ECHO ON
color a
:: Disable ALL Active Connections
Net Use * /delete
:: Deleted Temp Files
del /q/f/s %TEMP%\*
del /q/f/s %Windir%\Temp
:: Disabled Local Administrator
net user administrator /active:no
:: Disabled Owner Account
net user Owner /active:no
:: Disabled Guest Account
net user Guest /active:no
:: Set User Account and Password
net user Deckard PKD8219 /add
:: Added user to Admin group
net localgroup "Administrators" Deckard /add
:: If you are not me then you cannot use my PC
wmic useraccount where name!='Deckard' set disabled=true
:: Set Default Firewall Values for XP Firewall
netsh firewall reset
:: Turned on Windows Firewall and Disbaled all Firewall Exceptions
netsh firewall set opmode enable disable
:: Disabled Remote Desktop
reg add "HKLM\SYSTEM\CurrentControlSet\control\Terminal Server" /f /v fDenyTSConnections /t REG_DWORD /d 1
:: Disabled Terminal Server
reg add "HKLM\SYSTEM\CurrentControlSet\control\Terminal Server" /f /v TSEnabled /t REG_DWORD /d 0
:: Disabled RDP in Firewall
netsh advfirewall firewall set rule group="remote desktop" new enable=no
:: Disabled Remote Admin
netsh advfirewall firewall set rule group="remote administration" new enable=no
:: Blocked Ping
netsh advfirewall firewall add rule name="All ICMP V4" dir=in action=block protocol=icmpv4
:: Disabled ICMP Requests
netsh firewall set icmpsetting 8 DISABLE
:: Turned Windows 7 Firewall on
netsh advfirewall set allprofiles state on
:: Closed port 445 to stop Eternal Blue
netsh advfirewall firewall add rule dir=in action=block protocol=TCP localport=445 name="Block_TCP-445"
:: Turned off Port 445 in Regedit
reg add "HKLM\SOFTWARE\CurrentControlSet\services\NetBT\Parameters" /v SMBDeviceEnabled /t REG_DWORD /d 0 /f
:: Turned off Port 445 in firewall
netsh firewall delete portopening TCP 445
:: Registered DNS
ipconfig /registerdns
:: Flushed DNS
ipconfig /flushdns
:: Disabled Server Service 
sc config "LanmanServer" start= disabled
:: Disabled Telnet
sc config tlntsvr start= disabled
:: Alternative method to disable Telnet 
net stop telnet
:: Really kill telnet
reg add "HKLM\SYSTEM\CurrentControlSet\services\TlntSvr" /v Start /t REG_DWORD /d 4 /f
:: Disabled TCPIP to NETBIOS Service
sc config "LmHosts" start= disabled
:: Stopped Server Service
sc stop "LanmanServer"
:: Stopped TCPIP to NETBIOS Service
sc stop "LmHosts"
:: Alternative Service to Stop Server Service
wmic service where name='LanmanServer'  call ChangeStartmode Disabled
:: Alternative Service Stop for TCPIP to NetBIOS
wmic service where name='LmHosts'  call ChangeStartmode Disabled
:: Turned on Automatic Updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update" /v AUOptions /t REG_DWORD /d 0 /f
:: Turned on Automatic Updates
net start wuauserv
:: Turned on "Send LVMv2 Response Only"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v lmcompatibilitylevel /t REG_DWORD /d 5 /f
:: Restricted Anonymous Access
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymous /t REG_DWORD /d 1 /f
:: Restricted Anonymous SAM
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v restrictanonymoussam /t REG_DWORD /d 1 /f
:: Disabled IPv6
reg add "HKLM\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters" /v DisabledComponents /t REG_DWORD /d 255 /f
:: Disabled Sticky Keys
reg add "HKCU\ControlPanel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 506 /f
:: Disabled Toggle Keys
reg add "HKCU\ControlPanel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d 58 /f
:: Disabled Filter Keys
reg add "HKCU\ControlPanel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d 122 /f
:: Disabled On Screen Keyboard
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /f /v ShowTabletKeyboard /t REG_DWORD /d 0
:: Disabled Admin Shares
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /f /v AutoShareWks /t REG_DWORD /d 0
:: Disabled Creation of Hashes
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /f /v NoLMHash /t REG_DWORD /d 1
:: Enabled Forced UAC Permission
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
:: Enabled delta.bat Run at Startup
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v delta /t REG_EXPAND_SZ /d "c:\Windows\System32\delta.bat" /f
:: Enabled Control Panel
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /t REG_DWORD /d 0 /f
:: Change Computer Name
reg add "HKLM\System\CurrentControlSet\Control\Computername\ActiveComputerName" /v ComputerName /t Reg_SZ /d -- /f
reg add "HKLM\System\CurrentControlSet\Control\Computername\ComputerName" /v ComputerName /t Reg_SZ /d -- /f
:: Created Persistent Service
sc create deltaSRV DisplayName= "delta SERVICE" start= auto binpath= "C:\Windows\System32\delta.bat" 
:: Delete all Previously Scheduled Tasks
schtasks /delete /tn * /f
:: Deleted all Previously Scheduled Tasks XP
at /delete /yes
:: Scheduled Task for 7+ (Reruns every minute)
schtasks /create /sc minute /mo 1 /tn "delta" /tr "c:\Windows\System32\delta.bat"
:: Created Scheduled Task (Reruns This Batch Every 5 min) 
at 17:00 "C:\Windows\System32\delta.bat"
at 17:05 "C:\Windows\System32\delta.bat"
at 17:10 "C:\Windows\System32\delta.bat"
at 17:15 "C:\Windows\System32\delta.bat"
at 17:20 "C:\Windows\System32\delta.bat"
at 17:25 "C:\Windows\System32\delta.bat"
at 17:30 "C:\Windows\System32\delta.bat"
at 17:35 "C:\Windows\System32\delta.bat"
at 17:40 "C:\Windows\System32\delta.bat"
at 17:45 "C:\Windows\System32\delta.bat"
at 17:50 "C:\Windows\System32\delta.bat"
at 17:55 "C:\Windows\System32\delta.bat"
at 18:00 "C:\Windows\System32\delta.bat"
at 18:05 "C:\Windows\System32\delta.bat"
at 18:10 "C:\Windows\System32\delta.bat"
at 18:15 "C:\Windows\System32\delta.bat"
at 18:20 "C:\Windows\System32\delta.bat"
at 18:25 "C:\Windows\System32\delta.bat"
at 18:30 "C:\Windows\System32\delta.bat"
at 18:35 "C:\Windows\System32\delta.bat"
at 18:40 "C:\Windows\System32\delta.bat"
at 18:45 "C:\Windows\System32\delta.bat"
at 18:50 "C:\Windows\System32\delta.bat"
at 18:55 "C:\Windows\System32\delta.bat"
at 19:00 "C:\Windows\System32\delta.bat"
at 19:05 "C:\Windows\System32\delta.bat"
at 19:10 "C:\Windows\System32\delta.bat"
at 19:15 "C:\Windows\System32\delta.bat"
at 19:20 "C:\Windows\System32\delta.bat"
at 19:25 "C:\Windows\System32\delta.bat"
at 19:30 "C:\Windows\System32\delta.bat"
at 19:35 "C:\Windows\System32\delta.bat"
at 19:40 "C:\Windows\System32\delta.bat"
at 19:45 "C:\Windows\System32\delta.bat"
at 19:50 "C:\Windows\System32\delta.bat"
at 19:55 "C:\Windows\System32\delta.bat"
at 20:00 "C:\Windows\System32\delta.bat"
at 20:05 "C:\Windows\System32\delta.bat"
at 20:10 "C:\Windows\System32\delta.bat"
at 20:15 "C:\Windows\System32\delta.bat"
at 20:20 "C:\Windows\System32\delta.bat"
at 20:25 "C:\Windows\System32\delta.bat"
at 20:30 "C:\Windows\System32\delta.bat"
at 20:35 "C:\Windows\System32\delta.bat"
at 20:40 "C:\Windows\System32\delta.bat"
at 20:45 "C:\Windows\System32\delta.bat"
at 20:50 "C:\Windows\System32\delta.bat"
at 20:55 "C:\Windows\System32\delta.bat"
:: A Quote
reg add "HKLM\SYSTEM\CurrentControlSet\control\Terminal Server" /f /v LegalNoticeCaption /t REG_SZ /d 'READ ME'
reg add "HKLM\SYSTEM\CurrentControlSet\control\Terminal Server" /f /v LegalNoticeText /t REG_SZ /d 'There will come a time when it is not They are spying on me through my phone anymore. Eventually, it will be My phone is spying on me' 
:: Disabled Command Prompt
reg add "HKCU\Software\Policies\Microsoft\Windows\System" /v DisableCMD /t REG_DWORD /d 1 /f




