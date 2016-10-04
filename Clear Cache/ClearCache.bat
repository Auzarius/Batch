@ECHO OFF
echo Running Clear Cache 2.0 . . . 
echo Making sure Chrome is not open . . . 
taskkill /F /IM chrome.exe /T >nul 2>&1

echo Clearing the local file cache . . . 
erase "%TEMP%\*.*" /f /s /q >nul 2>&1
for /D %%i in ("%TEMP%\*") do RD /S /Q "%%i" >nul 2>&1

erase "%TMP%\*.*" /f /s /q >nul 2>&1
for /D %%i in ("%TMP%\*") do RD /S /Q "%%i" >nul 2>&1

erase "%ALLUSERSPROFILE%\TEMP\*.*" /f /s /q >nul 2>&1
for /D %%i in ("%ALLUSERSPROFILE%\TEMP\*") do RD /S /Q "%%i" >nul 2>&1

erase "%SystemRoot%\TEMP\*.*" /f /s /q >nul 2>&1
for /D %%i in ("%SystemRoot%\TEMP\*") do RD /S /Q "%%i" >nul 2>&1

RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2

echo Clearing IE's browser cache . . . 
@rem Clear IE cache -  (Deletes Temporary Internet Files Only)
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
erase "%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*.*" /f /s /q >nul 2>&1
for /D %%i in ("%LOCALAPPDATA%\Microsoft\Windows\Tempor~1\*") do RD /S /Q "%%i" >nul 2>&1

echo Clearing Chrome's browser cache . . . 
@rem Make directories to store the backup files for Chrome
rmdir /Q /S "%LOCALAPPDATA%\Google\Chrome\Backup" >nul 2>&1
mkdir "%LOCALAPPDATA%\Google\Chrome\Backup" >nul 2>&1
mkdir "%LOCALAPPDATA%\Google\Chrome\Backup\Default" >nul 2>&1

@rem Copy Chrome files that we do not want to remove to a Backup folder
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\First Run" "%LOCALAPPDATA%\Google\Chrome\Backup" >nul 2>&1
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\Local State" "%LOCALAPPDATA%\Google\Chrome\Backup" >nul 2>&1
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Bookmarks" "%LOCALAPPDATA%\Google\Chrome\Backup\Default" >nul 2>&1
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Bookmarks.bak" "%LOCALAPPDATA%\Google\Chrome\Backup\Default" >nul 2>&1
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Shortcuts" "%LOCALAPPDATA%\Google\Chrome\Backup\Default" >nul 2>&1
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Login Data" "%LOCALAPPDATA%\Google\Chrome\Backup\Default" >nul 2>&1
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Login Data-journal" "%LOCALAPPDATA%\Google\Chrome\Backup\Default" >nul 2>&1
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Secure Preferences" "%LOCALAPPDATA%\Google\Chrome\Backup\Default" >nul 2>&1
xcopy /E /Y /I "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Extensions" "%LOCALAPPDATA%\Google\Chrome\Backup\Default\Extensions" >nul 2>&1
copy /Y "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Preferences" "%LOCALAPPDATA%\Google\Chrome\Backup\Default" >nul 2>&1 

@rem Clear Google Chrome cache
erase "%LOCALAPPDATA%\Google\Chrome\User Data\*.*" /f /s /q >nul 2>&1
for /D %%i in ("%LOCALAPPDATA%\Google\Chrome\User Data\*") do RD /S /Q "%%i" >nul 2>&1
mkdir "%LOCALAPPDATA%\Google\Chrome\User Data\Default" >nul 2>&1
xcopy /Y /E /I "%LOCALAPPDATA%\Google\Chrome\Backup\*" "%LOCALAPPDATA%\Google\Chrome\User Data" >nul 2>&1

echo Clearing Firefox's cache if installed . . .
@rem Clear Firefox cache
erase "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.*" /f /s /q >nul 2>&1
for /D %%i in ("%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*") do RD /S /Q "%%i" >nul 2>&1

echo Launching Google Chrome . . .
start chrome.exe

echo Complete!
timeout 3
