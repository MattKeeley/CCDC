$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://raw.githubusercontent.com/MattKeeley/CCDC/master/Hammer.cmd","C:\hammer.cmd")
$WebClient.DownloadFile("https://github.com/MattKeeley/CCDC/raw/master/PatchMyPC.exe","C:\patchmypc.exe")
$WebClient.DownloadFile("https://github.com/MattKeeley/CCDC/raw/master/MBSetup.exe","C:\malwarebytes.exe")