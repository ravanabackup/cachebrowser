@echo off
:: Self-elevation check
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Stopping running update processes...
taskkill /F /IM MicrosoftEdgeUpdate.exe /T >nul 2>&1
taskkill /F /IM updater.exe /T >nul 2>&1

echo Disabling Edge Update Scheduled Tasks...
schtasks /Change /TN "\MicrosoftEdgeUpdateTaskMachineCore" /DISABLE >nul 2>&1
schtasks /Change /TN "\MicrosoftEdgeUpdateTaskMachineUA" /DISABLE >nul 2>&1

echo Disabling Google Update Scheduled Tasks...
schtasks /Change /TN "\GoogleUpdateTaskMachineCore" /DISABLE >nul 2>&1
schtasks /Change /TN "\GoogleUpdateTaskMachineUA" /DISABLE >nul 2>&1

echo Disabling Update Services...
sc config edgeupdate start= disabled >nul 2>&1
sc config edgeupdatem start= disabled >nul 2>&1
sc config gupdate start= disabled >nul 2>&1
sc config gupdatem start= disabled >nul 2>&1

sc stop edgeupdate >nul 2>&1
sc stop edgeupdatem >nul 2>&1
sc stop gupdate >nul 2>&1
sc stop gupdatem >nul 2>&1

echo.
echo Process terminated and background autostarts disabled successfully.
pause