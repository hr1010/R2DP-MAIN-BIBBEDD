@echo off
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
del /f "C:\Users\Public\Desktop\Unity Hub.lnk" > out.txt 2>&1
del /f "C:\Users\Public\Desktop\Google Cloud SDK Shell.lnk" > out.txt 2>&1
del /f "C:\Users\Public\Desktop\Microsoft Edge.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows LuppiLandia VM" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V EnableAutoTray /T REG_DWORD /D 0 /F > out.txt 2>&1
net user administrator @Basu01 /add >nul
net localgroup administrators administrator /add >nul
net user installer /delete
echo All done! Connect your VM using RDP. When RDP expired and VM shutdown, Re-run jobs to get a new RDP.
echo IP:
tasklist | find /i "ngrok.exe" >Nul && curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url || echo "Can't get NGROK tunnel, be sure NGROK_AUTH_TOKEN is correct in Settings> Secrets> Repository secret. Maybe your previous VM still running: https://dashboard.ngrok.com/status/tunnels " 
echo User: Administrator
echo Pass: @Basu01
curl -O https://raw.githubusercontent.com/c9ffin/rdp/main/Files/DisablePasswordComplexity.ps1 > out.txt 2>&1

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& './DisablePasswordComplexity.ps1'" > out.txt 2>&1
diskperf -Y >nul
sc start audiosrv >nul
sc config Audiosrv start= auto >nul
ICACLS C:\Windows\Temp /grant administrator:F >nul
ICACLS C:\Windows\installer /grant administrator:F >nul
ping -n 10 127.0.0.1 >nul
