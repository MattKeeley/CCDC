::#######################################################################
:: 
:: Matts master script. Designed to patch everything I can think of. 
:: Run as an administrator.
:: 
::#######################################################################
:: 
:: 
:: 
::#######################################################################
::
:: Change file associations to protect against common ransomware attacks
:: Note that if you legitimately use these extensions, like .bat, you will now need to execute them manually from cmd or powershell
:: Alternatively, you can right-click on them and hit 'Run as Administrator' but ensure it's a script you want to run :) 
::#######################################################################
::
ftype htafile="%SystemRoot%\system32\NOTEPAD.EXE" "%1"
ftype WSHFile="%SystemRoot%\system32\NOTEPAD.EXE" "%1"
ftype batfile="%SystemRoot%\system32\NOTEPAD.EXE" "%1"
::
::#######################################################################
::
:: Enable ASR rules in Win10 1709 ExploitGuard to mitigate Offic malspam
:: Blocks Office childprocs, Office proc injection, Office win32 api calls & executable content creation
:: Note these only work when Defender is your primary AV
:: Source: https://www.darkoperator.com/blog/2017/11/11/windows-defender-exploit-guard-asr-rules-for-office
::#######################################################################
::%programfiles%\"Windows Defender"\MpCmdRun.exe -RestoreDefaults
:: Block Office applications from creating child processes
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids D4F940AB-401B-4EFC-AADC-AD5F3C50688A -AttackSurfaceReductionRules_Actions Enabled
:: Block Office applications from injecting code into other processes
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 75668C1F-73B5-4CF0-BB93-3ECF5CB7CC84 -AttackSurfaceReductionRules_Actions enable
:: Block Win32 API calls from Office macro
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 92E97FA1-2EDF-4476-BDD6-9DD0B4DDDC7B -AttackSurfaceReductionRules_Actions enable
:: Block Office applications from creating executable content
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids '3B576869-A4EC-4529-8536-B80A7769E899' -AttackSurfaceReductionRules_Actions enable
:: Block execution of potentially obfuscated scripts
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids 5BEB7EFE-FD9A-4556-801D-275E5FFC04CC -AttackSurfaceReductionRules_Actions Enabled
:: Block executable content from email client and webmail
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids BE9BA2D9-53EA-4CDC-84E5-9B1EEEE46550 -AttackSurfaceReductionRules_Actions Enabled
:: Block JavaScript or VBScript from launching downloaded executable content
powershell.exe Add-MpPreference -AttackSurfaceReductionRules_Ids D3E037E1-3EB8-44C8-A917-57927947596D -AttackSurfaceReductionRules_Actions Enabled
::
::#######################################################################
:: Enable Cloud functionality of Windows Defender
::#######################################################################
powershell.exe Set-MpPreference -MAPSReporting Advanced
powershell.exe Set-MpPreference -SubmitSamplesConsent Always

::#######################################################################
::
:: Harden all version of MS Office itself against common malspam attacks
:: Disables Macros, enables ProtectedView
:: Source: https://decentsecurity.com/block-office-macros/
::#######################################################################
reg add "HKCU\Software\Policies\Microsoft\Office\12.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\12.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\14.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\14.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Outlook\Security" /v markinternalasunsafe /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Word\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Excel\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\PowerPoint\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\15.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Outlook\Security" /v markinternalasunsafe /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Word\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Excel\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\PowerPoint\Security" /v blockcontentexecutionfrominternet /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Word\Security" /v vbawarnings /t REG_DWORD /d 4 /f
reg add "HKCU\Software\Policies\Microsoft\Office\16.0\Publisher\Security" /v vbawarnings /t REG_DWORD /d 4 /f
::
::#######################################################################
::
:: Harden all version of MS Office itself against DDE malspam attacks
:: Disables Macros, enables ProtectedView
:: Source: https://gist.github.com/wdormann/732bb88d9b5dd5a66c9f1e1498f31a1b
::#######################################################################
::
reg add "HKCU\Software\Microsoft\Office\14.0\Word\Options" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\14.0\Word\Options\WordMail" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\15.0\Word\Options" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\15.0\Word\Options\WordMail" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
reg add "HKCU\Software\Microsoft\Office\16.0\Word\Options\WordMail" /v DontUpdateLinks /t REG_DWORD /d 00000001 /f
::#######################################################################
::
:: General OS hardening
:: Disables DNS multicast, smbv1, netbios, powershellv2
:: Enables UAC and sets to always notify
::#######################################################################
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /v EnableMulticast /t REG_DWORD /d 1 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v SMB1 /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 2 /f
net stop WinRM
wmic /interactive:off nicconfig where TcpipNetbiosOptions=1 call SetTcpipNetbios 2
powershell.exe Disable-WindowsOptionalFeature -Online -FeatureName smb1protocol
powershell.exe Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2
powershell.exe Disable-WindowsOptionalFeature -Online -FeatureName MicrosoftWindowsPowerShellV2Root
::
::#######################################################################
::
:: Harden lsass to help protect against credential dumping (mimikatz)
:: Configures lsass.exe as a protected process and disabled wdigest
:: Source: https://technet.microsoft.com/en-us/library/dn408187(v=ws.11).aspx
::#######################################################################
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\LSASS.exe" /v AuditLevel /t REG_DWORD /d 00000008 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v RunAsPPL /t REG_DWORD /d 00000001 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /v UseLogonCredential /t REG_DWORD /d 0 /f
::
::#######################################################################
::
:: Enable Windows Firewall and configure some advanced options
:: Block Win32 binaries from making netconns when they shouldn't
::#######################################################################
NetSh Advfirewall set allprofiles state on
Netsh.exe advfirewall firewall add rule name="Block Notepad.exe netconns" program="%systemroot%\system32\notepad.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh.exe advfirewall firewall add rule name="Block regsvr32.exe netconns" program="%systemroot%\system32\regsvr32.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh.exe advfirewall firewall add rule name="Block calc.exe netconns" program="%systemroot%\system32\calc.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh.exe advfirewall firewall add rule name="Block mshta.exe netconns" program="%systemroot%\system32\mshta.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh.exe advfirewall firewall add rule name="Block wscript.exe netconns" program="%systemroot%\system32\wscript.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh.exe advfirewall firewall add rule name="Block cscript.exe netconns" program="%systemroot%\system32\cscript.exe" protocol=tcp dir=out enable=yes action=block profile=any
Netsh.exe advfirewall firewall add rule name="Block runscripthelper.exe netconns" program="%systemroot%\system32\runscripthelper.exe" protocol=tcp dir=out enable=yes action=block profile=any
::
:: Enable Firewall Logging
netsh advfirewall set currentprofile logging filename %systemroot%\system32\LogFiles\Firewall\pfirewall.log
netsh advfirewall set currentprofile logging maxfilesize 4096
netsh advfirewall set currentprofile logging droppedconnections enable
::
:: Block all inbound connections on Public profile
netsh advfirewall set publicprofile firewallpolicy blockinboundalways,allowoutbound
:: Enable Windows Defender Network Protection
powershell.exe Set-MpPreference -EnableNetworkProtection Enabled

:: Microsoft Internet Explorer Cumulative Security Update (MS15-124) #####
::Impact: A remote, unauthenticated attacker could exploit these vulnerabilities to conduct cross-site scripting attacks, elevate their privileges, execute arbitrary code or cause a denial of service condition on the targeted system ###
powershell.exe New-Item -Name "FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX" -Path 'hklm:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\' -type Directory
powershell.exe New-ItemProperty -Path 'hklm:\SOFTWARE\WOW6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX\' -Name "iexplore.exe" -Value "00000001"
powershell.exe New-Item -Name "FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX" -Path 'hklm:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\' -type Directory
powershell.exe New-ItemProperty -Path 'hklm:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ENABLE_PRINT_INFO_DISCLOSURE_FIX\' -Name "iexplore.exe" -Value "00000001"
powershell.exe New-Item -Name "FEATURE_ALLOW_USER32_EXCEPTION_HANDLER_HARDENING" -Path 'hklm:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\' -type Directory
powershell.exe New-ItemProperty -Path 'hklm:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ALLOW_USER32_EXCEPTION_HANDLER_HARDENING\' -Name "iexplore.exe" -Value "00000001"
powershell.exe New-Item -Name "FEATURE_ALLOW_USER32_EXCEPTION_HANDLER_HARDENING" -Path 'hklm:\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Main\FeatureControl\' -type Directory
powershell.exe New-ItemProperty -Path 'hklm:\SOFTWARE\Wow6432Node\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_ALLOW_USER32_EXCEPTION_HANDLER_HARDENING\' -Name "iexplore.exe" -Value "00000001"
powershell.exe New-Item -Name "Virtualization" -Path 'hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\' -type Directory
:: Protecting guest virtual machines from CVE-2017-5715 (branch target injection) #####
#New-ItemProperty -Path 'hklm:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization' -Name "MinVmVersionForCpuBasedMitigations" -Value "1.0"

::	Enabled Cached Logon Credential   ##### 
:: Impact : Unauthorized users can gain access to this cached information, thereby obtaining sensitive logon information 
powershell.exe Set-ItemProperty -Path 'hklm:\Software\Microsoft\Windows Nt\CurrentVersion\Winlogon' -Name "CachedLogonsCount" -Value "0"

:: Windows Update For Credentials Protection and Management (Microsoft Security Advisory 2871997) #####
:: Impact : If this vulnerability is successfully exploited, attackers can steal credentials of the system
powershell.exe New-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\Session Manager\' -Name "CWDIllegalInDllSearch" -Value "00000001" -PropertyType "DWord"

:: Microsoft Windows Security Update Registry Key Configuration Missing (ADV180012) (Spectre/Meltdown Variant 4) #####
::Impact : An attacker who has successfully exploited this vulnerability may be able to read privileged data across trust boundaries. Vulnerable code patterns in the operating system (OS) or in applications could allow an attacker to exploit this vulnerability. In the case of Just-in-Time (JIT) compilers, such as JavaScript JIT employed by modern web browsers, it may be possible for an attacker to supply JavaScript that produces native code that could give rise to an instance of CVE-2018-3639#
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name "FeatureSettingsOverride" -Value "00000008"
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name "FeatureSettingsOverrideMask" -Value "00000003"

:: Allowed Null Session ####
:: Impact : Unauthorized users can establish a null session and obtain sensitive information, such as usernames and/or the share list, which could be used in further attacks against the host
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\LSA' -Name "RestrictAnonymous" -Value "00000001"
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\LSA' -Name "everyoneincludesanonymous" -Value "00000000"


powershell.exe Set-ItemProperty -Path 'hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer' -Name "ForceActiveDesktopOn" -Value "00000000"
powershell.exe Set-ItemProperty -Path 'hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer' -Name "NoActiveDesktopChanges" -Value "00000001"
powershell.exe Set-ItemProperty -Path 'hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer' -Name "NoActiveDesktop" -Value "00000001"
powershell.exe Set-ItemProperty -Path 'hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer' -Name "ShowSuperHidden" -Value "00000001"

:: Microsoft Windows Explorer AutoPlay Not Disabled #####
::Impact: Exploiting this vulnerability can cause malicious applications to be executed unintentionally at escalated privilege ###
powershell.exe New-ItemProperty -Path 'hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer' -Name "NoDriveTypeAutoRun" -Value "00000255" -PropertyType "DWord"
powershell.exe Set-ItemProperty -Path 'hkcu:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name "NoDriveTypeAutoRun" -Value "00000001"

:: Windows Registry Setting To Globally Prevent Socket Hijacking Missing #####
::Impact: If this registry setting is missing, in the absence of a SO_EXCLUSIVEADDRUSE check on a listening privileged socket, local unprivileged users can easily hijack the socket and intercept all data meant for the privileged process #####
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Services\AFD\Parameters' -Name "ForceActiveDesktopOn" -Value "00000001"

::Disable TLS 1.0#####
::Impact: An attacker can exploit cryptographic flaws to conduct man-in-the-middle type attacks or to decryption communications###
#Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Name "Enabled" -Value "00000000"
#Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client' -Name "DisabledByDefault" -Value "00000001"

:: Disable TLS 1.1
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server' -Name "DisabledByDefault" -Value "0" -Type DWord

::Disable SSL v3 #######
::Impact: SL 3.0 is an obsolete and insecure protocol.
::Encryption in SSL 3.0 uses either the RC4 stream cipher, or a block cipher in CBC mode.
::RC4 is known to have biases, and the block cipher in CBC mode is vulnerable to the POODLE attack.
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client' -Name "DisabledByDefault" -Value "00000001"
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server' -Name "Enabled" -Value "00000000"

:: Disable RC4 Protocols#####
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128' -Name "Enabled" -Value "00000000"
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128' -Name "Enabled" -Value "00000000"
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128' -Name "Enabled" -Value "00000000"
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168' -Name "Enabled" -Value "00000000"
powershell.exe Set-ItemProperty -Path 'hklm:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168/168' -Name "Enabled" -Value "00000000"

:: 	Microsoft Windows FragmentSmack Denial of Service Vulnerability (ADV180022) #####
::Impact: A system under attack would become unresponsive with 100% CPU utilization but would recover as soon as the attack terminated. ###
powershell.exe Set-NetIPv4Protocol -ReassemblyLimit 0
powershell.exe Set-NetIPv6Protocol -ReassemblyLimit 0

::MS15-011 Hardening UNC Paths Breaks GPO Access -	Microsoft Group Policy Remote Code Execution Vulnerability (MS15-011) ######
::Impact: The vulnerability could allow remote code execution if an attacker convinces a user with a domain-configured system to connect to an attacker-controlled network ###
powershell.exe Set-ItemProperty -Path 'hklm:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths' -Name "\\*\netlogon" -Value "RequireMutualAuthentication=1, RequireIntegrity=1, RequirePrivacy=1"
powershell.exe Set-ItemProperty -Path 'hklm:\SOFTWARE\Policies\Microsoft\Windows\NetworkProvider\HardenedPaths' -Name "\\*\sysvol" -Value "RequireMutualAuthentication=1, RequireIntegrity=1, RequirePrivacy=1"

:: Windows Update for Credentials Protection and Management (Microsoft Security Advisory 2871997)
:: IMPACT If this vulnerability is successfully exploited, attackers can steal credentials of the system. ###
powershell.exe Set-ItemProperty -Path 'hklm:\System\CurrentControlSet\Control\SecurityProviders\WDigest' -Name "UseLogonCredential" -Value "0"

:: Enabling strong cryptography for .NET V4...

::x64
powershell.exe Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord

::x86
powershell.exe Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord



