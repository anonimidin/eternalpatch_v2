@echo off
:: Console size 70x25
mode 70,25
:: Color Blue & White text
color 1f
:: UTF-8 unicode
chcp 65001 >nul
:: Title
title EternalBlue Defense

:menu
    :: You can also use banner locally
    :: type banner.txt
    curl https://raw.githubusercontent.com/r3x08/eternalpatch_v2/main/banner.txt 
    echo Main Menu:
    echo.
    echo 1. EternalBlue protect
    echo 2. SMBv1 to SMBv2
    echo 3. About
    echo 4. Restart PC
    echo 5. Exit
    echo.
    set choice=
    set /p choice=Enter your choice: 
    ::Choices with calling functions
    if %choice% == 1 ( call :fix )
    if %choice% == 2 ( call :update )
    if %choice% == 3 ( start https://github.com/cyberdome-tj )
    if %choice% == 4 ( call :restartPC )
    if %choice% == 5 ( msg * " Obeserve ur security! CyberDome " && exit )
goto menu

:fix
    echo Checking Windows version...
    ver | findstr /i "not found" > nul
    if %errorlevel% == 0 (
    echo Windows version is not supported or not recognized
    echo No action taken. Exiting.
    exit
    )
    ::Windows 7
    echo Adding firewall rules to block incoming connections on vulnerable ports...
    ver | findstr /i "6.1" > nul
    if %errorlevel% == 0 (
    echo.
    echo Windows 7 detected
    echo Blocking incoming connections on ports 139 and 445...
    netsh advfirewall firewall show rule name="Block TCP 139" > nul
    if %errorlevel% == 0 (
        echo Port 139 already blocked
    ) else (
        netsh advfirewall firewall add rule name="Block TCP 139" dir=in action=block protocol=TCP localport=139
        echo Port 139 blocked
    )

    netsh advfirewall firewall show rule name="Block TCP 445" > nul
    if %errorlevel% == 0 (
        echo Port 445 already blocked
    ) else (
        netsh advfirewall firewall add rule name="Block TCP 445" dir=in action=block protocol=TCP localport=445
        echo Port 445 blocked
    )
    echo PRESS ENTER TO RETURN TO MAIN MENU. && pause > nul && cls
    )
    ::Windows 8.1
    ver | findstr /i "6.3" > nul
    if %errorlevel% == 0 (
    cls && echo.
    echo Windows 8.1 detected
    echo Blocking incoming connections on ports 139 and 445...
    netsh advfirewall firewall show rule name="Block TCP 139" > nul
    if %errorlevel% == 0 (
        echo Port 139 already blocked
    ) else (
        netsh advfirewall firewall add rule name="Block TCP 139" dir=in action=block protocol=TCP localport=139
        echo Port 139 blocked
    )

    netsh advfirewall firewall show rule name="Block TCP 445" > nul
    if %errorlevel% == 0 (
        echo Port 445 already blocked
    ) else (
        netsh advfirewall firewall add rule name="Block TCP 445" dir=in action=block protocol=TCP localport=445
        echo Port 445 blocked
    )
    echo PRESS ENTER TO RETURN TO MAIN MENU. && pause >nul && cls
    )
    ::Windows 10
    ver | findstr /i "10." > nul
    if %errorlevel% == 0 (
    cls && echo.
    echo Windows 10 detected
    echo Blocking incoming connections on port 445...
    netsh advfirewall firewall show rule name="Block TCP 445" > nul
    if %errorlevel% == 0 (
        echo Port 445 already blocked
    ) else (
        netsh advfirewall firewall add rule name="Block TCP 445" dir=in action=block protocol=TCP localport=445
        echo Port 445 blocked
    )
    echo PRESS ENTER TO RETURN TO MAIN MENU. && pause >nul && cls
    )
goto menu 

:update
    ::Powershell commands changes SMBv1 to SMBv2.
    color f1 && powershell.exe Set-SmbServerConfiguration -EnableSMB1Protocol $false -Confirm:$false; Set-SmbServerConfiguration -EnableSMB2Protocol $true -Confirm:$false
    echo.
    echo SMBv1 changed to SMBv2! Restart PC!
    echo PRESS ENTER TO RETURN TO MAIN MENU. && pause >nul && cls
goto menu

:restartPC
    ::Restart the computer
    echo Restarting the PC...
    shutdown /r /c "Observe your security!" /t 3
goto menu
