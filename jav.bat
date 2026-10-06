@echo off
setlocal EnableExtensions
title Java EE Practical Auto Creator - NetBeans
color 0A

REM ============================================================
REM JAVA EE PRACTICAL AUTO CREATOR (NetBeans + Java 8)
REM Compatible with NetBeans 8.2 or any other version installed
REM All source files are stored at the bottom of this .bat as
REM plain text (lines starting with "::") and extracted with
REM PowerShell. No batch escaping is needed for file contents.
REM ============================================================

set "ROOT=%~dp0JEE_Practicals\"
set "LIBROOT=%~dp0JEE_Libraries\"
set "BATFILE=%~f0"
set "NB_LNK=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\NetBeans\NetBeans IDE 8.2.lnk"
set "NETBEANS_EXE="
set "MYSQL_JAR="
set "WB_DIR=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MySQL"
set "OPEN_WORKBENCH=Y"

REM Auto-detect NetBeans
call :find_netbeans
if not defined NETBEANS_EXE goto ASK_NB

:NB_FOUND
call :resolve_lnk
if not defined NETBEANS_EXE goto NB_FAIL
if not exist "%NETBEANS_EXE%" goto NB_FAIL
goto START

:ASK_NB
cls
echo.
echo ========================================================
echo NetBeans not found automatically.
echo ========================================================
echo.
echo Enter FULL path to netbeans64.exe or the NetBeans .lnk file
echo Example: C:\Program Files\NetBeans-12.0\bin\netbeans64.exe
echo.
set /p "NETBEANS_EXE=NetBeans path: "
if not defined NETBEANS_EXE goto NB_FAIL
set "NETBEANS_EXE=%NETBEANS_EXE:"=%"
goto NB_FOUND

:NB_FAIL
echo.
echo ERROR: Could not locate NetBeans executable.
echo Please install NetBeans 8.2 or provide the correct path.
pause
exit /b 1

:START
if not exist "%ROOT%" mkdir "%ROOT%"
if not exist "%LIBROOT%" mkdir "%LIBROOT%"

:ASK_DB
cls
echo.
echo ============================================================
echo MySQL Configuration
echo ============================================================
echo.
echo Do you need MySQL/Database support for your practicals?
echo (Required for Practicals 1, 3, 4, 6)
echo (NOT required for Practicals 2, 5)
echo.
choice /C YN /N /M "Enable MySQL support? [Y/N]: "
if errorlevel 2 goto SKIP_MYSQL

echo.
echo MySQL settings (written into the generated Java/JSP code)
echo Press Enter to keep the default shown in [ ]
echo.
set "DBUSER=root"
set "DBPASS=root123"
set /p "DBUSER=MySQL username [root]: "
if "%DBUSER%"=="" set "DBUSER=root"
set /p "DBPASS=MySQL password [root123]: "
if "%DBPASS%"=="" set "DBPASS=root123"

:ASK_JAR
echo.
echo ============================================================
echo MySQL Connector JAR Configuration
echo ============================================================
echo.
if defined MYSQL_JAR if exist "%MYSQL_JAR%" goto JAR_OK
echo Enter the full path to mysql-connector-java-8.0.21.jar
echo (or any mysql-connector-java-*.jar file)
echo.
echo Type SKIP to continue without MySQL JAR (not recommended)
echo.
set /p "MYSQL_JAR=MySQL JAR path: "
if /i "%MYSQL_JAR%"=="SKIP" goto SKIP_MYSQL
if not defined MYSQL_JAR goto ASK_JAR
set "MYSQL_JAR=%MYSQL_JAR:"=%"
if not exist "%MYSQL_JAR%" (
    echo.
    echo WARNING: JAR file not found at: %MYSQL_JAR%
    echo Database pages will fail until you copy it into WEB-INF\lib.
    echo.
    choice /C YN /N /M "Continue anyway? [Y/N]: "
    if errorlevel 2 goto ASK_JAR
)

:JAR_OK
call :find_workbench
goto MENU

:SKIP_MYSQL
echo.
echo MySQL support disabled. Database practicals will need manual configuration.
set "MYSQL_JAR="
set "DBUSER=root"
set "DBPASS=root123"
timeout /t 2 >nul

:MENU
cls
echo.
echo ============================================================
echo JAVA EE PRACTICAL AUTO CREATOR
echo ============================================================
echo.
echo NetBeans  : %NETBEANS_EXE%
echo Projects  : %ROOT%
if defined MYSQL_JAR (
    echo MySQL JAR : %MYSQL_JAR%
) else (
    echo MySQL JAR : [NOT CONFIGURED - Database practicals may fail]
)
echo.
echo ------------------------------------------------------------
echo Select Practical
echo ------------------------------------------------------------
echo.
echo 1. Practical 1 - Servlet + JDBC Registration / Login [MySQL Required]
echo 2. Practical 2 - RequestDispatcher + Cookies + Session
echo 3. Practical 3 - JSP Implicit Objects + Form + Login [MySQL Required]
echo 4. Practical 4 - JSP Update + EL + JSTL [MySQL Required]
echo 5. Practical 5 - EJB Currency + Room + Cart
echo 6. Practical 6 - EJB Singleton + Stateless [MySQL Required]
echo.
echo 8. Reconfigure MySQL Settings
echo 0. Exit
echo.
set "CHOICE="
set /p "CHOICE=Enter Practical Number: "

if "%CHOICE%"=="0" exit /b
if "%CHOICE%"=="1" goto P1_MENU
if "%CHOICE%"=="2" goto P2_MENU
if "%CHOICE%"=="3" goto P3_MENU
if "%CHOICE%"=="4" goto P4_MENU
if "%CHOICE%"=="5" goto P5_MENU
if "%CHOICE%"=="6" goto P6_MENU
if "%CHOICE%"=="8" goto ASK_DB

echo Invalid choice.
timeout /t 2 >nul
goto MENU

REM ============================================================
REM PRACTICAL 1
REM ============================================================
:P1_MENU
cls
echo.
echo ============================================================
echo PRACTICAL 1 - SERVLET + JDBC
echo ============================================================
echo.
echo 1. Registration (Servlet + JDBC)
echo 2. Login (Servlet + JDBC)
echo 3. Registration + Login (Complete)
echo 0. Back
echo.
set "Q="
set /p "Q=Enter Question: "

if "%Q%"=="0" goto MENU
if "%Q%"=="1" goto P1Q1
if "%Q%"=="2" goto P1Q2
if "%Q%"=="3" goto P1Q3
goto P1_MENU

:P1Q1
set "PROJECT=Practical1_Q1_Registration"
set "DBNAME=p1q1_db"
set "QLABEL=Practical 1 - Question 1"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "Registration Servlet JDBC"
call :emit P1Q1
call :entry "registration.html" "Registration"
call :finish_index
call :open_project
goto DONE

:P1Q2
set "PROJECT=Practical1_Q2_Login"
set "DBNAME=p1q2_db"
set "QLABEL=Practical 1 - Question 2"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "Login Servlet JDBC"
call :emit P1Q2
call :entry "login.html" "Login"
call :finish_index
call :open_project
goto DONE

:P1Q3
set "PROJECT=Practical1_Q3_Complete"
set "DBNAME=p1q3_db"
set "QLABEL=Practical 1 - Question 3"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "Registration and Login"
call :emit P1Q1
call :entry "registration.html" "Registration"
call :emit P1Q2
call :entry "login.html" "Login"
call :finish_index
call :open_project
goto DONE

REM ============================================================
REM PRACTICAL 2
REM ============================================================
:P2_MENU
cls
echo.
echo ============================================================
echo PRACTICAL 2 - RequestDispatcher / Cookie / Session
echo ============================================================
echo.
echo 1. RequestDispatcher - Password Validation
echo 2. Cookie - Visit Counter
echo 3. Session - Visit Counter + Logout
echo 4. All Questions
echo 0. Back
echo.
set "Q="
set /p "Q=Enter Question: "

if "%Q%"=="0" goto MENU
if "%Q%"=="1" goto P2Q1
if "%Q%"=="2" goto P2Q2
if "%Q%"=="3" goto P2Q3
if "%Q%"=="4" goto P2Q4
goto P2_MENU

:P2Q1
set "PROJECT=Practical2_Q1_RequestDispatcher"
set "DBNAME=p2q1_db"
set "QLABEL=Practical 2 - Question 1"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "RequestDispatcher"
call :emit P2Q1
call :entry "password.html" "Password Validation with RequestDispatcher"
call :finish_index
call :open_project
goto DONE

:P2Q2
set "PROJECT=Practical2_Q2_Cookie"
set "DBNAME=p2q2_db"
set "QLABEL=Practical 2 - Question 2"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "Cookie Visit Counter"
call :emit P2Q2
call :entry "cookie.html" "Cookie Visit Counter"
call :finish_index
call :open_project
goto DONE

:P2Q3
set "PROJECT=Practical2_Q3_Session"
set "DBNAME=p2q3_db"
set "QLABEL=Practical 2 - Question 3"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "Session Management"
call :emit P2Q3
call :entry "session.html" "Session Visit Counter and Logout"
call :finish_index
call :open_project
goto DONE

:P2Q4
set "PROJECT=Practical2_Q4_All"
set "DBNAME=p2q4_db"
set "QLABEL=Practical 2 - Question 4"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "RequestDispatcher Cookie Session"
call :emit P2Q1
call :entry "password.html" "Password Validation with RequestDispatcher"
call :emit P2Q2
call :entry "cookie.html" "Cookie Visit Counter"
call :emit P2Q3
call :entry "session.html" "Session Visit Counter and Logout"
call :finish_index
call :open_project
goto DONE

REM ============================================================
REM PRACTICAL 3
REM ============================================================
:P3_MENU
cls
echo.
echo ============================================================
echo PRACTICAL 3 - JSP
echo ============================================================
echo.
echo 1. JSP Implicit Objects
echo 2. JSP Form Validation
echo 3. JSP Registration + Login
echo 4. All Questions
echo 0. Back
echo.
set "Q="
set /p "Q=Enter Question: "

if "%Q%"=="0" goto MENU
if "%Q%"=="1" goto P3Q1
if "%Q%"=="2" goto P3Q2
if "%Q%"=="3" goto P3Q3
if "%Q%"=="4" goto P3Q4
goto P3_MENU

:P3Q1
set "PROJECT=Practical3_Q1_Implicit"
set "DBNAME=p3q1_db"
set "QLABEL=Practical 3 - Question 1"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "JSP Implicit Objects"
call :emit P3Q1
call :entry "implicitObjects.jsp" "JSP Implicit Objects"
call :finish_index
call :open_project
goto DONE

:P3Q2
set "PROJECT=Practical3_Q2_Form"
set "DBNAME=p3q2_db"
set "QLABEL=Practical 3 - Question 2"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "JSP Form Validation"
call :emit P3Q2
call :entry "form.jsp" "Registration Form with Validation"
call :finish_index
call :open_project
goto DONE

:P3Q3
set "PROJECT=Practical3_Q3_Login"
set "DBNAME=p3q3_db"
set "QLABEL=Practical 3 - Question 3"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "JSP Registration Login"
call :emit P3Q3
call :entry "register.jsp" "Registration"
call :entry "login.jsp" "Login"
call :finish_index
call :open_project
goto DONE

:P3Q4
set "PROJECT=Practical3_Q4_All"
set "DBNAME=p3q4_db"
set "QLABEL=Practical 3 - Question 4"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "JSP All"
call :emit P3Q1
call :entry "implicitObjects.jsp" "JSP Implicit Objects"
call :emit P3Q2
call :entry "form.jsp" "Registration Form with Validation"
call :emit P3Q3
call :entry "register.jsp" "Registration"
call :entry "login.jsp" "Login"
call :finish_index
call :open_project
goto DONE

REM ============================================================
REM PRACTICAL 4
REM ============================================================
:P4_MENU
cls
echo.
echo ============================================================
echo PRACTICAL 4 - JSP / EL / JSTL
echo ============================================================
echo.
echo 1. JSP Update Registration
echo 2. Expression Language
echo 3. JSTL
echo 4. All Questions
echo 0. Back
echo.
set "Q="
set /p "Q=Enter Question: "

if "%Q%"=="0" goto MENU
if "%Q%"=="1" goto P4Q1
if "%Q%"=="2" goto P4Q2
if "%Q%"=="3" goto P4Q3
if "%Q%"=="4" goto P4Q4
goto P4_MENU

:P4Q1
set "PROJECT=Practical4_Q1_Update"
set "DBNAME=p4q1_db"
set "QLABEL=Practical 4 - Question 1"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "JSP Update"
call :emit P4Q1
call :entry "updateForm.jsp" "Update Registration"
call :finish_index
call :open_project
goto DONE

:P4Q2
set "PROJECT=Practical4_Q2_EL"
set "DBNAME=p4q2_db"
set "QLABEL=Practical 4 - Question 2"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "JSP EL"
call :emit P4Q2
call :entry "el.jsp" "Expression Language Demo"
call :finish_index
call :open_project
goto DONE

:P4Q3
set "PROJECT=Practical4_Q3_JSTL"
set "DBNAME=p4q3_db"
set "QLABEL=Practical 4 - Question 3"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "JSP JSTL"
call :emit P4Q3
call :entry "jstl.jsp" "JSTL Demo"
call :add_jstl
call :finish_index
call :open_project
goto DONE

:P4Q4
set "PROJECT=Practical4_Q4_All"
set "DBNAME=p4q4_db"
set "QLABEL=Practical 4 - Question 4"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "JSP Update EL JSTL"
call :emit P4Q1
call :entry "updateForm.jsp" "Update Registration"
call :emit P4Q2
call :entry "el.jsp" "Expression Language Demo"
call :emit P4Q3
call :entry "jstl.jsp" "JSTL Demo"
call :add_jstl
call :finish_index
call :open_project
goto DONE

REM ============================================================
REM PRACTICAL 5
REM ============================================================
:P5_MENU
cls
echo.
echo ============================================================
echo PRACTICAL 5 - EJB
echo ============================================================
echo.
echo 1. Currency Conversion (EJB Stateless)
echo 2. Room Reservation (EJB Stateless)
echo 3. Shopping Cart (EJB Stateful)
echo 4. All Questions
echo 0. Back
echo.
set "Q="
set /p "Q=Enter Question: "

if "%Q%"=="0" goto MENU
if "%Q%"=="1" goto P5Q1
if "%Q%"=="2" goto P5Q2
if "%Q%"=="3" goto P5Q3
if "%Q%"=="4" goto P5Q4
goto P5_MENU

:P5Q1
set "PROJECT=Practical5_Q1_Currency"
set "DBNAME=p5q1_db"
set "QLABEL=Practical 5 - Question 1"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "EJB Currency Converter"
call :emit P5Q1
call :entry "currency.html" "Currency Converter EJB"
call :finish_index
call :open_project
goto DONE

:P5Q2
set "PROJECT=Practical5_Q2_Room"
set "DBNAME=p5q2_db"
set "QLABEL=Practical 5 - Question 2"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "EJB Room Reservation"
call :emit P5Q2
call :entry "room.html" "Room Reservation EJB"
call :finish_index
call :open_project
goto DONE

:P5Q3
set "PROJECT=Practical5_Q3_Cart"
set "DBNAME=p5q3_db"
set "QLABEL=Practical 5 - Question 3"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "EJB Shopping Cart Stateful"
call :emit P5Q3
call :entry "cart.html" "Shopping Cart EJB Stateful"
call :finish_index
call :open_project
goto DONE

:P5Q4
set "PROJECT=Practical5_Q4_All"
set "DBNAME=p5q4_db"
set "QLABEL=Practical 5 - Question 4"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "EJB Currency Room Cart"
call :emit P5Q1
call :entry "currency.html" "Currency Converter EJB"
call :emit P5Q2
call :entry "room.html" "Room Reservation EJB"
call :emit P5Q3
call :entry "cart.html" "Shopping Cart EJB Stateful"
call :finish_index
call :open_project
goto DONE

REM ============================================================
REM PRACTICAL 6
REM ============================================================
:P6_MENU
cls
echo.
echo ============================================================
echo PRACTICAL 6 - EJB
echo ============================================================
echo.
echo 1. Singleton EJB Visit Counter
echo 2. Stateless Visitor Statistics
echo 3. Both Questions
echo 0. Back
echo.
set "Q="
set /p "Q=Enter Question: "

if "%Q%"=="0" goto MENU
if "%Q%"=="1" goto P6Q1
if "%Q%"=="2" goto P6Q2
if "%Q%"=="3" goto P6Q3
goto P6_MENU

:P6Q1
set "PROJECT=Practical6_Q1_Singleton"
set "DBNAME=p6q1_db"
set "QLABEL=Practical 6 - Question 1"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "EJB Singleton"
call :emit P6Q1
call :entry "singleton.html" "EJB Singleton Visit Counter"
call :finish_index
call :open_project
goto DONE

:P6Q2
set "PROJECT=Practical6_Q2_Stateless"
set "DBNAME=p6q2_db"
set "QLABEL=Practical 6 - Question 2"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "EJB Stateless"
call :emit P6Q2
call :entry "stat.html" "EJB Stateless Visitor Statistics"
call :finish_index
call :open_project
goto DONE

:P6Q3
set "PROJECT=Practical6_Q3_All"
set "DBNAME=p6q3_db"
set "QLABEL=Practical 6 - Question 3"
call :reset_project "%PROJECT%"
call :make_web_project "%PROJECT%" "EJB Both"
call :emit P6Q1
call :entry "singleton.html" "EJB Singleton Visit Counter"
call :emit P6Q2
call :entry "stat.html" "EJB Stateless Visitor Statistics"
call :finish_index
call :open_project
goto DONE

:DONE
echo.
echo ============================================================
echo DONE
echo ============================================================
echo.
echo Project location:
echo %ROOT%%PROJECT%
echo.
echo Press any key to return to main menu...
pause >nul
goto MENU

REM ============================================================
REM CORE FUNCTIONS
REM ============================================================

:find_netbeans
REM Check common NetBeans installation paths

REM First priority: NetBeans 8.2
if exist "%ProgramFiles%\NetBeans 8.2\bin\netbeans64.exe" (
    set "NETBEANS_EXE=%ProgramFiles%\NetBeans 8.2\bin\netbeans64.exe"
    exit /b
)
if exist "%ProgramFiles%\NetBeans 8.2\bin\netbeans.exe" (
    set "NETBEANS_EXE=%ProgramFiles%\NetBeans 8.2\bin\netbeans.exe"
    exit /b
)
if exist "%ProgramFiles%\NetBeans-8.2\bin\netbeans64.exe" (
    set "NETBEANS_EXE=%ProgramFiles%\NetBeans-8.2\bin\netbeans64.exe"
    exit /b
)
if exist "%ProgramFiles(x86)%\NetBeans 8.2\bin\netbeans.exe" (
    set "NETBEANS_EXE=%ProgramFiles(x86)%\NetBeans 8.2\bin\netbeans.exe"
    exit /b
)
if exist "%NB_LNK%" (
    set "NETBEANS_EXE=%NB_LNK%"
    exit /b
)

REM Second priority: Any other NetBeans version in Program Files
for /d %%D in ("%ProgramFiles%\NetBeans*") do (
    if exist "%%D\bin\netbeans64.exe" (
        set "NETBEANS_EXE=%%D\bin\netbeans64.exe"
        exit /b
    )
    if exist "%%D\bin\netbeans.exe" (
        set "NETBEANS_EXE=%%D\bin\netbeans.exe"
        exit /b
    )
)

REM Check Program Files (x86)
for /d %%D in ("%ProgramFiles(x86)%\NetBeans*") do (
    if exist "%%D\bin\netbeans.exe" (
        set "NETBEANS_EXE=%%D\bin\netbeans.exe"
        exit /b
    )
)

REM Third priority: Check Start Menu shortcuts for any NetBeans version
for /r "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" %%F in (NetBeans*.lnk) do (
    if not defined NETBEANS_EXE (
        set "NETBEANS_EXE=%%F"
        exit /b
    )
)

REM Fourth priority: Check user's Start Menu
for /r "%APPDATA%\Microsoft\Windows\Start Menu\Programs" %%F in (NetBeans*.lnk) do (
    if not defined NETBEANS_EXE (
        set "NETBEANS_EXE=%%F"
        exit /b
    )
)

exit /b

:resolve_lnk
REM If NETBEANS_EXE is a .lnk, read the real target .exe from it
if /i not "%NETBEANS_EXE:~-4%"==".lnk" exit /b
set "LNK=%NETBEANS_EXE%"
set "NETBEANS_EXE="
for /f "usebackq delims=" %%T in (`powershell -NoProfile -Command "(New-Object -ComObject WScript.Shell).CreateShortcut('%LNK%').TargetPath"`) do set "NETBEANS_EXE=%%T"
exit /b

:reset_project
set "P=%ROOT%%~1"
set "ENTRY_COUNT=0"
set "ENTRY_FIRST="
del "%P%\nbproject\entries.tmp" 2>nul
if not exist "%P%" goto rp_make
echo.
echo Project already exists: %P%
echo.
echo TIP: close this project in NetBeans first (right-click project, Close).
choice /C YN /N /M "Overwrite its files with fresh copies? [Y/N]: "
if errorlevel 2 goto MENU
REM Folder is NOT deleted. Files are rewritten in place so NetBeans keeps recognising the project.
rmdir /s /q "%P%\build" 2>nul
rmdir /s /q "%P%\dist" 2>nul
:rp_make
mkdir "%P%" 2>nul
mkdir "%P%\src" 2>nul
mkdir "%P%\web" 2>nul
mkdir "%P%\web\WEB-INF" 2>nul
mkdir "%P%\web\WEB-INF\lib" 2>nul
mkdir "%P%\lib" 2>nul
mkdir "%P%\nbproject" 2>nul
exit /b

:make_web_project
set "PROJECT=%~1"
set "P=%ROOT%%~1"
set "PTITLE=%~2"
call :emit COMMON
call :copy_jar
exit /b

:copy_jar
if not defined MYSQL_JAR exit /b
if not exist "%MYSQL_JAR%" exit /b
mkdir "%P%\web\WEB-INF\lib" 2>nul
for %%F in ("%MYSQL_JAR%") do set "JAR_NAME=%%~nxF"
copy /y "%MYSQL_JAR%" "%P%\web\WEB-INF\lib\%JAR_NAME%" >nul
exit /b

:find_workbench
set "WB_LNK="
if not exist "%WB_DIR%" exit /b
for /r "%WB_DIR%" %%F in (Workbench.lnk) do if not defined WB_LNK set "WB_LNK=%%F"
exit /b

:emit
REM %1 = payload group name. Uses P, PROJECT, PTITLE, BATFILE.
set "GRP=%~1"
set "OUTDIR=%P%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$w={param($p,$s) $t=($s -join [Environment]::NewLine).Replace('@@PROJECT@@',$env:PROJECT).Replace('@@TITLE@@',$env:PTITLE).Replace('@@DBUSER@@',$env:DBUSER).Replace('@@DBPASS@@',$env:DBPASS).Replace('@@DBNAME@@',$env:DBNAME).Replace('@@QLABEL@@',$env:QLABEL); [IO.File]::WriteAllText($p,$t,(New-Object Text.UTF8Encoding $false))}; $g=$env:GRP; $d=$env:OUTDIR; $on=$false; $f=$null; $sb=$null; foreach($l in [IO.File]::ReadAllLines($env:BATFILE)){ if(-not $on){ if($l -eq ('::#GROUP '+$g)){$on=$true}; continue }; if($l -eq '::#END'){break}; if($l.StartsWith('::#FILE ')){ if($f){& $w $f $sb}; $f=Join-Path $d $l.Substring(8).Trim(); New-Item -ItemType Directory -Force -Path (Split-Path $f) | Out-Null; $sb=New-Object 'Collections.Generic.List[string]'; continue }; if($f){$sb.Add($l.Substring(2))} }; if($f){& $w $f $sb}"
exit /b

:open_project
echo.
echo ============================================================
echo PROJECT CREATED SUCCESSFULLY
echo ============================================================
echo Location: %P%
echo.
echo Opening in NetBeans...
echo.
echo Waiting 3 seconds so NetBeans sees the new files...
timeout /t 3 /nobreak >nul
start "" "%NETBEANS_EXE%" --open "%P%"
echo.
echo If NetBeans shows a plain folder instead of a project: close that node, then
echo use File ^> Open Project in NetBeans and pick this folder (it has a project icon).
if exist "%P%\database_queries.txt" start "" notepad "%P%\database_queries.txt"
if /i "%OPEN_WORKBENCH%"=="Y" if defined WB_LNK if exist "%P%\database_queries.txt" start "" "%WB_LNK%"
exit /b

:entry
REM %1 = page file, %2 = title. Adds a link to the start page list.
set /a ENTRY_COUNT+=1
if "%ENTRY_COUNT%"=="1" set "ENTRY_FIRST=%~1"
echo ^<li^>^<a href="%~1"^>%~2^</a^>^</li^> >> "%P%\nbproject\entries.tmp"
exit /b

:finish_index
REM Builds web\index.html so the project opens directly when you click Run.
if "%ENTRY_COUNT%"=="0" exit /b
set "IDX=%P%\web\index.html"
echo ^<!DOCTYPE html^> > "%IDX%"
echo ^<html^>^<head^>^<meta charset="UTF-8"^> >> "%IDX%"
if "%ENTRY_COUNT%"=="1" echo ^<meta http-equiv="refresh" content="0; url=%ENTRY_FIRST%"^> >> "%IDX%"
echo ^<title^>%PTITLE%^</title^>^</head^>^<body^> >> "%IDX%"
echo ^<h2^>%PTITLE%^</h2^> >> "%IDX%"
echo ^<ul^> >> "%IDX%"
type "%P%\nbproject\entries.tmp" >> "%IDX%"
echo ^</ul^>^</body^>^</html^> >> "%IDX%"
exit /b

:add_jstl
REM JSTL is built into GlassFish but NOT into Tomcat, so bundle the JAR in the project.
set "JSTL_JAR=%LIBROOT%jstl-1.2.jar"
if exist "%JSTL_JAR%" goto aj_copy
echo Downloading jstl-1.2.jar ...
powershell -NoProfile -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest -UseBasicParsing -Uri 'https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar' -OutFile '%JSTL_JAR%' } catch { Write-Host 'Download failed' }"
:aj_copy
if exist "%JSTL_JAR%" copy /y "%JSTL_JAR%" "%P%\web\WEB-INF\lib" >nul
if not exist "%JSTL_JAR%" echo WARNING: could not get jstl-1.2.jar. Add it manually (needed on Tomcat only).
exit /b

REM ############################################################
REM Nothing below this line is executed. File payloads only.
REM ############################################################
exit /b

::#GROUP COMMON
::#FILE nbproject/project.xml
::<?xml version="1.0" encoding="UTF-8"?>
::<project xmlns="http://www.netbeans.org/ns/project/1">
::    <type>org.netbeans.modules.web.project</type>
::    <configuration>
::        <data xmlns="http://www.netbeans.org/ns/web-project/3">
::            <name>@@PROJECT@@</name>
::            <minimum-ant-version>1.6.5</minimum-ant-version>
::            <web-module-libraries/>
::            <web-module-additional-libraries/>
::            <source-roots>
::                <root id="src.dir"/>
::            </source-roots>
::            <test-roots>
::                <root id="test.src.dir"/>
::            </test-roots>
::        </data>
::    </configuration>
::</project>
::#FILE nbproject/project.properties
::annotation.processing.enabled=true
::annotation.processing.enabled.in.editor=false
::annotation.processing.processor.options=
::annotation.processing.processors.list=
::annotation.processing.run.all.processors=true
::annotation.processing.source.output=${build.generated.sources.dir}/ap-source-output
::build.classes.dir=${build.web.dir}/WEB-INF/classes
::build.classes.excludes=**/*.java,**/*.form
::build.dir=build
::build.generated.dir=${build.dir}/generated
::build.generated.sources.dir=${build.dir}/generated-sources
::build.test.classes.dir=${build.dir}/test/classes
::build.test.results.dir=${build.dir}/test/results
::build.web.dir=${build.dir}/web
::build.web.excludes=${build.classes.excludes}
::client.urlPart=
::compile.jsps=false
::conf.dir=${source.root}/conf
::debug.classpath=${javac.classpath}:${build.classes.dir}
::display.browser=true
::dist.dir=dist
::dist.ear.war=${dist.dir}/${war.ear.name}
::dist.javadoc.dir=${dist.dir}/javadoc
::dist.war=${dist.dir}/${war.name}
::endorsed.classpath=
::excludes=
::includes=**
::j2ee.compile.on.save=true
::j2ee.deploy.on.save=true
::j2ee.platform=1.7
::j2ee.server.type=Tomcat
::jar.compress=false
::javac.classpath=${libs.javaee-web-api-7.0.classpath}
::javac.compilerargs=
::javac.debug=true
::javac.deprecation=false
::javac.processorpath=${javac.classpath}
::javac.source=1.8
::javac.target=1.8
::jspcompilation.classpath=${jspc.classpath}:${javac.classpath}
::lib.dir=${web.docbase.dir}/WEB-INF/lib
::no.dependencies=false
::persistence.xml.dir=${conf.dir}
::platform.active=default_platform
::resource.dir=setup
::source.encoding=UTF-8
::source.root=.
::src.dir=${source.root}/src
::test.src.dir=test
::war.content.additional=
::war.ear.name=${war.name}
::war.name=@@PROJECT@@.war
::web.docbase.dir=web
::webinf.dir=web/WEB-INF
::#FILE web/WEB-INF/web.xml
::<?xml version="1.0" encoding="UTF-8"?>
::<web-app xmlns="http://java.sun.com/xml/ns/javaee"
::         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
::         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
::         version="3.0">
::    <display-name>@@TITLE@@</display-name>
::    <session-config>
::        <session-timeout>30</session-timeout>
::    </session-config>
::    <welcome-file-list>
::        <welcome-file>index.html</welcome-file>
::        <welcome-file>index.jsp</welcome-file>
::    </welcome-file-list>
::</web-app>
::#FILE build.xml
::<?xml version="1.0" encoding="UTF-8"?>
::<project name="@@PROJECT@@" default="default" basedir=".">
::    <description>Builds, tests, and runs the project.</description>
::    <import file="nbproject/build-impl.xml"/>
::</project>
::#FILE README.txt
::============================================================
::@@TITLE@@
::============================================================
::
::HOW TO RUN:
::1. Right-click the project > Resolve Missing Server Problem > pick Tomcat 8.5/9 or GlassFish 4.1.1.
::2. Right-click the project > Clean and Build, then click Run (green arrow).
::3. The browser opens the start page by itself.
::4. If the project has database_queries.txt, run it in MySQL Workbench first (it creates this question's own database).
::5. The MySQL connector JAR is already inside web/WEB-INF/lib.
::
::NOTES:
::- Use Tomcat 8.5 or 9 (NOT Tomcat 10).
::- EJB practicals run on GlassFish with the real EJB container. On Tomcat
::  they automatically fall back to a plain Java object, so they still work.
::============================================================
::#END

::#GROUP P1Q1
::#FILE web/registration.html
::<!DOCTYPE html>
::<html>
::<head><title>Registration</title></head>
::<body>
::<h2>User Registration</h2>
::<form action="RegisterServlet" method="post">
::Username: <input type="text" name="username" required><br><br>
::Password: <input type="password" name="password" required><br><br>
::Email: <input type="email" name="email" required><br><br>
::Country: <input type="text" name="country" required><br><br>
::<input type="submit" value="Register">
::</form>
::</body>
::</html>
::#FILE src/app/RegisterServlet.java
::package app;
::
::import java.io.*;
::import java.sql.*;
::import javax.servlet.*;
::import javax.servlet.annotation.WebServlet;
::import javax.servlet.http.*;
::
::@WebServlet("/RegisterServlet")
::public class RegisterServlet extends HttpServlet {
::    private static final String URL = "jdbc:mysql://localhost:3306/@@DBNAME@@?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
::    private static final String USER = "@@DBUSER@@";
::    private static final String PASS = "@@DBPASS@@";
::
::    protected void doGet(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        response.sendRedirect("registration.html");
::    }
::
::    protected void doPost(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        response.setContentType("text/html");
::        PrintWriter out = response.getWriter();
::        String username = request.getParameter("username");
::        String password = request.getParameter("password");
::        String email = request.getParameter("email");
::        String country = request.getParameter("country");
::        try {
::            Class.forName("com.mysql.cj.jdbc.Driver");
::            Connection con = DriverManager.getConnection(URL, USER, PASS);
::            PreparedStatement ps = con.prepareStatement("INSERT INTO users(username,password,email,country) VALUES(?,?,?,?)");
::            ps.setString(1, username);
::            ps.setString(2, password);
::            ps.setString(3, email);
::            ps.setString(4, country);
::            ps.executeUpdate();
::            out.println("<h2>Registration Successful</h2>");
::            con.close();
::        } catch (Exception e) {
::            out.println("<h2>Error: " + e + "</h2>");
::        }
::        out.println("<br><a href='registration.html'>Back</a>");
::    }
::}
::#FILE database_queries.txt
::-- ============================================================
::-- @@QLABEL@@ : @@TITLE@@
::-- Database used ONLY by this question: @@DBNAME@@
::-- Every question has its own database, so other questions are never touched.
::-- Nothing here drops or deletes data (safe to run again).
::-- ============================================================
::
::-- STEP 1: Open MySQL Workbench and connect to your local MySQL server.
::-- STEP 2: Paste everything below into a query tab and click the lightning button (Execute).
::-- STEP 3: After using the web form, run the last SELECT line to see the saved rows.
::
::CREATE DATABASE IF NOT EXISTS @@DBNAME@@;
::USE @@DBNAME@@;
::CREATE TABLE IF NOT EXISTS users (
::    id INT AUTO_INCREMENT PRIMARY KEY,
::    username VARCHAR(50) UNIQUE,
::    password VARCHAR(100),
::    email VARCHAR(100),
::    country VARCHAR(50)
::);
::
::-- Check saved data:
::SELECT * FROM @@DBNAME@@.users;
::#END

::#GROUP P1Q2
::#FILE web/login.html
::<!DOCTYPE html>
::<html>
::<body>
::<h2>Login</h2>
::<form action="LoginServlet" method="post">
::Username: <input type="text" name="username" required><br><br>
::Password: <input type="password" name="password" required><br><br>
::<input type="submit" value="Login">
::</form>
::</body>
::</html>
::#FILE src/app/LoginServlet.java
::package app;
::
::import java.io.*;
::import java.sql.*;
::import javax.servlet.*;
::import javax.servlet.annotation.WebServlet;
::import javax.servlet.http.*;
::
::@WebServlet("/LoginServlet")
::public class LoginServlet extends HttpServlet {
::    private static final String URL = "jdbc:mysql://localhost:3306/@@DBNAME@@?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
::    private static final String USER = "@@DBUSER@@";
::    private static final String PASS = "@@DBPASS@@";
::
::    protected void doGet(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        response.sendRedirect("login.html");
::    }
::
::    protected void doPost(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        response.setContentType("text/html");
::        PrintWriter out = response.getWriter();
::        String username = request.getParameter("username");
::        String password = request.getParameter("password");
::        try {
::            Class.forName("com.mysql.cj.jdbc.Driver");
::            Connection con = DriverManager.getConnection(URL, USER, PASS);
::            PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE username=? AND password=?");
::            ps.setString(1, username);
::            ps.setString(2, password);
::            ResultSet rs = ps.executeQuery();
::            if (rs.next()) {
::                out.println("<h2>Login Successful</h2>");
::                out.println("<h3>Welcome " + rs.getString("username") + "</h3>");
::            } else {
::                out.println("<h2>Invalid Username or Password</h2>");
::            }
::            con.close();
::        } catch (Exception e) {
::            out.println("<h2>Error: " + e + "</h2>");
::        }
::        out.println("<br><a href='login.html'>Back</a>");
::    }
::}
::#FILE database_queries.txt
::-- ============================================================
::-- @@QLABEL@@ : @@TITLE@@
::-- Database used ONLY by this question: @@DBNAME@@
::-- Every question has its own database, so other questions are never touched.
::-- Nothing here drops or deletes data (safe to run again).
::-- ============================================================
::
::-- STEP 1: Open MySQL Workbench and connect to your local MySQL server.
::-- STEP 2: Paste everything below into a query tab and click the lightning button (Execute).
::-- STEP 3: After using the web form, run the last SELECT line to see the saved rows.
::
::CREATE DATABASE IF NOT EXISTS @@DBNAME@@;
::USE @@DBNAME@@;
::CREATE TABLE IF NOT EXISTS users (
::    id INT AUTO_INCREMENT PRIMARY KEY,
::    username VARCHAR(50) UNIQUE,
::    password VARCHAR(100),
::    email VARCHAR(100),
::    country VARCHAR(50)
::);
::INSERT IGNORE INTO users(username,password,email,country) VALUES('admin','12345','admin@example.com','India');
::
::-- Check saved data:
::SELECT * FROM @@DBNAME@@.users;
::#END

::#GROUP P2Q1
::#FILE web/password.html
::<!DOCTYPE html>
::<html>
::<body>
::<h2>Password Validation</h2>
::<p>Hint: the correct password is <b>servlet</b></p>
::<form action="ValidateServlet" method="post">
::Password: <input type="password" name="password"><br><br>
::<input type="submit" value="Login">
::</form>
::</body>
::</html>
::#FILE src/app/ValidateServlet.java
::package app;
::
::import java.io.*;
::import javax.servlet.*;
::import javax.servlet.annotation.WebServlet;
::import javax.servlet.http.*;
::
::@WebServlet("/ValidateServlet")
::public class ValidateServlet extends HttpServlet {
::    protected void doGet(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        response.sendRedirect("password.html");
::    }
::
::    protected void doPost(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        String pwd = request.getParameter("password");
::        if ("servlet".equals(pwd)) {
::            RequestDispatcher rd = request.getRequestDispatcher("/WelcomeServlet");
::            rd.forward(request, response);
::        } else {
::            response.setContentType("text/html");
::            PrintWriter out = response.getWriter();
::            out.println("<h3>Invalid Password</h3>");
::            request.getRequestDispatcher("/password.html").include(request, response);
::        }
::    }
::}
::#FILE src/app/WelcomeServlet.java
::package app;
::
::import java.io.*;
::import javax.servlet.*;
::import javax.servlet.annotation.WebServlet;
::import javax.servlet.http.*;
::
::@WebServlet("/WelcomeServlet")
::public class WelcomeServlet extends HttpServlet {
::    protected void doGet(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        doPost(request, response);
::    }
::
::    protected void doPost(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        response.setContentType("text/html");
::        response.getWriter().println("<h2>Welcome Servlet!</h2>");
::    }
::}
::#END

::#GROUP P2Q2
::#FILE web/cookie.html
::<!DOCTYPE html>
::<html>
::<body>
::<h2>Cookie Visit Counter</h2>
::<a href="VisitCounter">Visit Servlet</a>
::</body>
::</html>
::#FILE src/app/VisitCounter.java
::package app;
::
::import java.io.*;
::import javax.servlet.*;
::import javax.servlet.annotation.WebServlet;
::import javax.servlet.http.*;
::
::@WebServlet("/VisitCounter")
::public class VisitCounter extends HttpServlet {
::    protected void doGet(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        int count = 1;
::        Cookie[] cookies = request.getCookies();
::        if (cookies != null) {
::            for (Cookie c : cookies) {
::                if ("visitCount".equals(c.getName())) {
::                    count = Integer.parseInt(c.getValue()) + 1;
::                }
::            }
::        }
::        Cookie cookie = new Cookie("visitCount", String.valueOf(count));
::        cookie.setMaxAge(60 * 60 * 24 * 30);
::        response.addCookie(cookie);
::        response.setContentType("text/html");
::        response.getWriter().println("<h2>You visited this servlet " + count + " time(s).</h2>");
::    }
::}
::#END

::#GROUP P2Q3
::#FILE web/session.html
::<!DOCTYPE html>
::<html>
::<body>
::<h2>Session Demo</h2>
::<a href="SessionDemo">Start / Refresh Session</a><br><br>
::<a href="SessionDemo?action=logout">Logout / Destroy Session</a>
::</body>
::</html>
::#FILE src/app/SessionDemo.java
::package app;
::
::import java.io.*;
::import javax.servlet.*;
::import javax.servlet.annotation.WebServlet;
::import javax.servlet.http.*;
::
::@WebServlet("/SessionDemo")
::public class SessionDemo extends HttpServlet {
::    protected void doGet(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        response.setContentType("text/html");
::        PrintWriter out = response.getWriter();
::        String action = request.getParameter("action");
::        if ("logout".equals(action)) {
::            HttpSession old = request.getSession(false);
::            if (old != null) old.invalidate();
::            out.println("<h2>Session Destroyed</h2>");
::            return;
::        }
::        HttpSession session = request.getSession();
::        Integer count = (Integer) session.getAttribute("count");
::        if (count == null) count = 1;
::        else count++;
::        session.setAttribute("count", count);
::        out.println("<h2>Session Demo</h2>");
::        out.println("Session ID: " + session.getId() + "<br>");
::        out.println("Visit Count: " + count + "<br>");
::        out.println("<a href='SessionDemo'>Refresh</a>");
::    }
::}
::#END

::#GROUP P3Q1
::#FILE web/implicitObjects.jsp
::<%@ page import="java.util.Date" %>
::<html>
::<body>
::<h2>Request Object</h2>
::Client Locale: <%= request.getLocale().toString() %><br>
::<h2>Out Object</h2>
::<% out.println("Printed using out object<br>"); %>
::<h2>Config Object</h2>
::Servlet Name: <%= config.getServletName() %><br>
::<h2>Application Object</h2>
::Server Info: <%= application.getServerInfo() %><br>
::<h2>Page Object</h2>
::Page Class: <%= page.getClass().getName() %><br>
::<h2>Session Object</h2>
::Creation Time: <%= new Date(session.getCreationTime()) %>
::</body>
::</html>
::#END

::#GROUP P3Q2
::#FILE web/form.jsp
::<html>
::<body>
::<h2>Registration Form</h2>
::<form action="display.jsp" method="post">
::Name: <input type="text" name="name" required><br><br>
::Age: <input type="number" name="age" required><br><br>
::Email: <input type="email" name="email" required><br><br>
::Gender:
::<input type="radio" name="gender" value="Male">Male
::<input type="radio" name="gender" value="Female">Female
::<br><br>
::Hobby:
::<input type="checkbox" name="hobby" value="Reading">Reading
::<input type="checkbox" name="hobby" value="Sports">Sports
::<input type="checkbox" name="hobby" value="Music">Music
::<br><br>
::<input type="submit" value="Submit">
::</form>
::</body>
::</html>
::#FILE web/display.jsp
::<html>
::<body>
::<h2>Entered Details</h2>
::<%
::String name = request.getParameter("name");
::String age = request.getParameter("age");
::String email = request.getParameter("email");
::String gender = request.getParameter("gender");
::String[] hobbies = request.getParameterValues("hobby");
::if (name == null || name.trim().isEmpty()) {
::    out.println("<h3>Invalid Name</h3>");
::} else {
::%>
::Name: <%= name %><br>
::Age: <%= age %><br>
::Email: <%= email %><br>
::Gender: <%= gender %><br>
::Hobbies:
::<%
::if (hobbies != null) for (String h : hobbies) out.print(h + " ");
::%>
::<% } %>
::</body>
::</html>
::#END

::#GROUP P3Q3
::#FILE web/register.jsp
::<html>
::<body>
::<h2>Registration</h2>
::<form action="process.jsp" method="post">
::Name: <input type="text" name="name"><br>
::Username: <input type="text" name="username"><br>
::Password: <input type="password" name="password"><br>
::City: <input type="text" name="city"><br>
::Country: <input type="text" name="country"><br>
::<input type="hidden" name="action" value="register">
::<input type="submit" value="Register">
::</form>
::<a href="login.jsp">Login</a>
::</body>
::</html>
::#FILE web/login.jsp
::<html>
::<body>
::<h2>Login</h2>
::<form action="process.jsp" method="post">
::Username: <input type="text" name="username"><br>
::Password: <input type="password" name="password"><br>
::<input type="hidden" name="action" value="login">
::<input type="submit" value="Login">
::</form>
::<a href="register.jsp">Register</a>
::</body>
::</html>
::#FILE web/process.jsp
::<%@ page import="java.sql.*" %>
::<%
::String action = request.getParameter("action");
::Class.forName("com.mysql.cj.jdbc.Driver");
::Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/@@DBNAME@@?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true", "@@DBUSER@@", "@@DBPASS@@");
::if ("register".equals(action)) {
::    String name = request.getParameter("name");
::    String username = request.getParameter("username");
::    String password = request.getParameter("password");
::    String city = request.getParameter("city");
::    String country = request.getParameter("country");
::    PreparedStatement ps = con.prepareStatement("INSERT INTO register VALUES(?,?,?,?,?)");
::    ps.setString(1, name); ps.setString(2, username); ps.setString(3, password);
::    ps.setString(4, city); ps.setString(5, country);
::    ps.executeUpdate();
::    out.println("<h2>Registration Successful</h2>");
::} else {
::    String username = request.getParameter("username");
::    String password = request.getParameter("password");
::    PreparedStatement ps = con.prepareStatement("SELECT * FROM register WHERE username=? AND password=?");
::    ps.setString(1, username); ps.setString(2, password);
::    ResultSet rs = ps.executeQuery();
::    if (rs.next()) out.println("<h2>Login Successful. Welcome " + rs.getString("name") + "</h2>");
::    else out.println("<h2>Invalid Username or Password</h2>");
::}
::con.close();
::%>
::#FILE database_queries.txt
::-- ============================================================
::-- @@QLABEL@@ : @@TITLE@@
::-- Database used ONLY by this question: @@DBNAME@@
::-- Every question has its own database, so other questions are never touched.
::-- Nothing here drops or deletes data (safe to run again).
::-- ============================================================
::
::-- STEP 1: Open MySQL Workbench and connect to your local MySQL server.
::-- STEP 2: Paste everything below into a query tab and click the lightning button (Execute).
::-- STEP 3: After using the web form, run the last SELECT line to see the saved rows.
::
::CREATE DATABASE IF NOT EXISTS @@DBNAME@@;
::USE @@DBNAME@@;
::CREATE TABLE IF NOT EXISTS register (
::    name VARCHAR(50),
::    username VARCHAR(50) PRIMARY KEY,
::    password VARCHAR(100),
::    city VARCHAR(50),
::    country VARCHAR(50)
::);
::
::-- Check saved data:
::SELECT * FROM @@DBNAME@@.register;
::#END

::#GROUP P4Q1
::#FILE web/updateForm.jsp
::<html>
::<body>
::<h2>Update Registration</h2>
::<form action="update.jsp" method="post">
::First Name: <input type="text" name="firstname"><br>
::Last Name: <input type="text" name="lastname"><br>
::Username: <input type="text" name="username"><br>
::Password: <input type="password" name="password"><br>
::City: <input type="text" name="city"><br>
::Country: <input type="text" name="country"><br>
::<input type="submit" value="Update">
::</form>
::</body>
::</html>
::#FILE web/update.jsp
::<%@ page import="java.sql.*" %>
::<%
::try {
::    Class.forName("com.mysql.cj.jdbc.Driver");
::    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/@@DBNAME@@?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true", "@@DBUSER@@", "@@DBPASS@@");
::    String sql = "UPDATE registration SET firstname=?,lastname=?,password=?,city=?,country=? WHERE username=?";
::    PreparedStatement ps = con.prepareStatement(sql);
::    ps.setString(1, request.getParameter("firstname"));
::    ps.setString(2, request.getParameter("lastname"));
::    ps.setString(3, request.getParameter("password"));
::    ps.setString(4, request.getParameter("city"));
::    ps.setString(5, request.getParameter("country"));
::    ps.setString(6, request.getParameter("username"));
::    int result = ps.executeUpdate();
::    out.println(result > 0 ? "<h2>Updated Successfully</h2>" : "<h2>Username Not Found</h2>");
::    con.close();
::} catch (Exception e) {
::    out.println("Error: " + e);
::}
::%>
::#FILE database_queries.txt
::-- ============================================================
::-- @@QLABEL@@ : @@TITLE@@
::-- Database used ONLY by this question: @@DBNAME@@
::-- Every question has its own database, so other questions are never touched.
::-- Nothing here drops or deletes data (safe to run again).
::-- ============================================================
::
::-- STEP 1: Open MySQL Workbench and connect to your local MySQL server.
::-- STEP 2: Paste everything below into a query tab and click the lightning button (Execute).
::-- STEP 3: After using the web form, run the last SELECT line to see the saved rows.
::
::CREATE DATABASE IF NOT EXISTS @@DBNAME@@;
::USE @@DBNAME@@;
::CREATE TABLE IF NOT EXISTS registration (
::    firstname VARCHAR(50),
::    lastname VARCHAR(50),
::    username VARCHAR(50) PRIMARY KEY,
::    password VARCHAR(100),
::    city VARCHAR(50),
::    country VARCHAR(50)
::);
::INSERT IGNORE INTO registration VALUES('First','Last','user1','pass','Mumbai','India');
::
::-- Check saved data:
::SELECT * FROM @@DBNAME@@.registration;
::#END

::#GROUP P4Q2
::#FILE web/el.jsp
::<%@ page contentType="text/html" %>
::<html>
::<body>
::<h2>Expression Language Demo</h2>
::<%
::request.setAttribute("name", "Archita");
::request.setAttribute("age", 20);
::%>
::Name: ${name}<br>
::Age: ${age}<br>
::Addition: ${10 + 20}<br>
::Multiplication: ${10 * 5}<br>
::Comparison: ${10 > 5}
::</body>
::</html>
::#END

::#GROUP P4Q3
::#FILE web/jstl.jsp
::<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
::<html>
::<body>
::<h2>JSTL Demo</h2>
::<form method="post">
::Name: <input type="text" name="name" required><br>
::Age: <input type="number" name="age" required><br>
::<input type="submit" value="Submit">
::</form>
::<c:if test="${not empty param.name}">
::Name: <c:out value="${param.name}"/><br>
::Age: <c:out value="${param.age}"/><br>
::<c:if test="${param.age >= 18}">You are eligible to vote.</c:if>
::<c:if test="${param.age < 18}">You are not eligible to vote.</c:if>
::</c:if>
::</body>
::</html>
::#END

::#GROUP P5Q1
::#FILE web/currency.html
::<!DOCTYPE html>
::<html>
::<head><title>Currency Converter</title></head>
::<body>
::<h2>Currency Converter</h2>
::<form action="currencyResult.jsp" method="post">
::Amount: <input type="text" name="amount" required><br><br>
::From: <select name="from"><option value="USD">Dollar</option><option value="INR">INR</option></select><br><br>
::To: <select name="to"><option value="USD">Dollar</option><option value="INR" selected>INR</option></select><br><br>
::<input type="submit" value="Convert">
::</form>
::</body>
::</html>
::#FILE web/currencyResult.jsp
::<%@ page import="javax.naming.*" %>
::<%@ page import="ejb.CurrencyConverter" %>
::<html>
::<body>
::<h2>Currency Conversion Result</h2>
::<%
::String from = request.getParameter("from");
::String to = request.getParameter("to");
::double amount;
::try {
::    amount = Double.parseDouble(request.getParameter("amount").trim());
::} catch (Exception e) {
::    out.println("<h3>Please enter a valid number for Amount.</h3><a href='currency.html'>Back</a>");
::    return;
::}
::CurrencyConverter converter;
::String mode;
::try {
::    converter = (CurrencyConverter) new InitialContext().lookup("java:module/CurrencyConverter");
::    mode = "GlassFish EJB container (real Stateless EJB)";
::} catch (Throwable e) {
::    converter = new CurrencyConverter();
::    mode = "plain Java object (no EJB container, e.g. Tomcat)";
::}
::double result = converter.convert(amount, from, to);
::%>
::Amount: <%= amount %><br><br>
::From: <%= from %><br><br>
::To: <%= to %><br><br>
::Converted Amount: <%= String.format("%.2f", result) %><br><br>
::<small>Running on: <%= mode %></small><br><br>
::<a href="currency.html">Convert again</a>
::</body>
::</html>
::#FILE src/ejb/CurrencyConverter.java
::package ejb;
::
::import javax.ejb.Stateless;
::
::@Stateless
::public class CurrencyConverter {
::    public double convert(double amount, String from, String to) {
::        if ("USD".equals(from) && "INR".equals(to)) {
::            return amount * 83;
::        }
::        if ("INR".equals(from) && "USD".equals(to)) {
::            return amount / 83;
::        }
::        return amount;
::    }
::}
::#END

::#GROUP P5Q2
::#FILE web/room.html
::<!DOCTYPE html>
::<html>
::<head><title>Room Reservation</title></head>
::<body>
::<h2>Room Reservation System</h2>
::<form action="roomResult.jsp" method="post">
::Guest Name: <input type="text" name="name" required><br><br>
::Room Type:
::<select name="room">
::<option value="Single">Single - Rs. 1000/day</option>
::<option value="Double">Double - Rs. 1800/day</option>
::<option value="Deluxe">Deluxe - Rs. 2500/day</option>
::</select><br><br>
::Check-in Date: <input type="date" name="checkin" required><br><br>
::Number of Guests: <input type="number" name="guests" min="1" required><br><br>
::Number of Days: <input type="number" name="days" min="1" required><br><br>
::<input type="submit" value="Reserve Room">
::</form>
::</body>
::</html>
::#FILE web/roomResult.jsp
::<%@ page import="javax.naming.*" %>
::<%@ page import="ejb.RoomReservationBean" %>
::<html>
::<body>
::<h2>Room Reservation Details</h2>
::<%
::String name = request.getParameter("name");
::String room = request.getParameter("room");
::String checkin = request.getParameter("checkin");
::int guests;
::int days;
::try {
::    guests = Integer.parseInt(request.getParameter("guests").trim());
::    days = Integer.parseInt(request.getParameter("days").trim());
::    if (guests < 1 || days < 1) {
::        throw new NumberFormatException();
::    }
::} catch (Exception e) {
::    out.println("<h3>Guests and Days must be whole numbers of 1 or more.</h3><a href='room.html'>Back</a>");
::    return;
::}
::String safeName = (name == null) ? "" : name.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;");
::RoomReservationBean reservation;
::String mode;
::try {
::    reservation = (RoomReservationBean) new InitialContext().lookup("java:module/RoomReservationBean");
::    mode = "GlassFish EJB container (real Stateless EJB)";
::} catch (Throwable e) {
::    reservation = new RoomReservationBean();
::    mode = "plain Java object (no EJB container, e.g. Tomcat)";
::}
::double amount = reservation.calculateAmount(room, days);
::%>
::Guest Name: <%= safeName %><br><br>
::Room Type: <%= room %><br><br>
::Check-in Date: <%= checkin %><br><br>
::Number of Guests: <%= guests %><br><br>
::Number of Days: <%= days %><br><br>
::Total Amount: Rs. <%= amount %><br><br>
::<h3>Room Reserved Successfully!</h3>
::<small>Running on: <%= mode %></small><br><br>
::<a href="room.html">New reservation</a>
::</body>
::</html>
::#FILE src/ejb/RoomReservationBean.java
::package ejb;
::
::import javax.ejb.Stateless;
::
::@Stateless
::public class RoomReservationBean {
::    public double calculateAmount(String room, int days) {
::        double rate = 0;
::        if ("Single".equals(room)) {
::            rate = 1000;
::        } else if ("Double".equals(room)) {
::            rate = 1800;
::        } else if ("Deluxe".equals(room)) {
::            rate = 2500;
::        }
::        return rate * days;
::    }
::}
::#END

::#GROUP P5Q3
::#FILE web/cart.html
::<!DOCTYPE html>
::<html>
::<head><title>Shopping Cart</title></head>
::<body>
::<h2>Simple Shopping Cart</h2>
::<form action="cart.jsp" method="post">
::Select Product:
::<select name="product">
::<option value="Laptop">Laptop - Rs. 50000</option>
::<option value="Mobile">Mobile - Rs. 20000</option>
::<option value="Headphones">Headphones - Rs. 2000</option>
::<option value="Keyboard">Keyboard - Rs. 1500</option>
::</select><br><br>
::Quantity: <input type="number" name="quantity" min="1" value="1" required><br><br>
::<input type="submit" value="Add to Cart">
::</form>
::<br><a href="cart.jsp">View Cart</a>
::</body>
::</html>
::#FILE web/cart.jsp
::<%@ page import="javax.naming.*" %>
::<%@ page import="ejb.ShoppingCartBean" %>
::<%@ page import="java.util.List" %>
::<html>
::<body>
::<h2>Shopping Cart</h2>
::<%
::if ("clear".equals(request.getParameter("action"))) {
::    session.removeAttribute("cart");
::}
::String product = request.getParameter("product");
::String quantityString = request.getParameter("quantity");
::ShoppingCartBean cart = (ShoppingCartBean) session.getAttribute("cart");
::if (cart == null) {
::    try {
::        cart = (ShoppingCartBean) new InitialContext().lookup("java:module/ShoppingCartBean");
::    } catch (Throwable e) {
::        cart = new ShoppingCartBean();
::    }
::    session.setAttribute("cart", cart);
::}
::String mode = "ejb.ShoppingCartBean".equals(cart.getClass().getName())
::    ? "plain Java object (no EJB container, e.g. Tomcat)"
::    : "GlassFish EJB container (real Stateful EJB)";
::if (product != null && quantityString != null) {
::    try {
::        int quantity = Integer.parseInt(quantityString.trim());
::        if (quantity > 0) {
::            cart.addItem(product, quantity);
::        }
::    } catch (NumberFormatException e) {
::        out.println("<p>Quantity must be a whole number.</p>");
::    }
::}
::List<String> items = cart.getCart();
::%>
::<h3>Items in Cart:</h3>
::<% if (items.isEmpty()) { %>
::Cart is empty<br>
::<% } %>
::<% for (String item : items) { %>
::<%= item %><br>
::<% } %>
::<br>
::<b>Total Amount: Rs. <%= cart.getTotal() %></b>
::<br><br>
::<a href="cart.html">Continue Shopping</a> | <a href="cart.jsp?action=clear">Clear Cart</a>
::<br><br>
::<small>Running on: <%= mode %></small>
::</body>
::</html>
::#FILE src/ejb/ShoppingCartBean.java
::package ejb;
::
::import java.io.Serializable;
::import java.util.ArrayList;
::import java.util.List;
::import javax.ejb.Stateful;
::
::@Stateful
::public class ShoppingCartBean implements Serializable {
::    private List<String> cart = new ArrayList<String>();
::    private double total = 0;
::
::    public void addItem(String product, int quantity) {
::        cart.add(product + " x " + quantity);
::        if ("Laptop".equals(product)) {
::            total += 50000 * quantity;
::        } else if ("Mobile".equals(product)) {
::            total += 20000 * quantity;
::        } else if ("Headphones".equals(product)) {
::            total += 2000 * quantity;
::        } else if ("Keyboard".equals(product)) {
::            total += 1500 * quantity;
::        }
::    }
::
::    public List<String> getCart() {
::        return cart;
::    }
::
::    public double getTotal() {
::        return total;
::    }
::}
::#END

::#GROUP P6Q1
::#FILE web/singleton.html
::<html>
::<body>
::<h2>EJB Singleton Visit Counter</h2>
::<form method="post" action="client">
::<input type="submit" value="Visit Servlet">
::</form>
::</body>
::</html>
::#FILE src/p1/ServletCount.java
::package p1;
::import javax.ejb.Singleton;
::
::@Singleton
::public class ServletCount {
::    private int cnt = 0;
::    public synchronized int count() {
::        return ++cnt;
::    }
::}
::#FILE src/p1/client.java
::package p1;
::
::import java.io.*;
::import javax.naming.InitialContext;
::import javax.servlet.*;
::import javax.servlet.annotation.WebServlet;
::import javax.servlet.http.*;
::
::@WebServlet("/client")
::public class client extends HttpServlet {
::    // Used only when there is no EJB container (Tomcat)
::    private static final ServletCount LOCAL = new ServletCount();
::
::    protected void doGet(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        doPost(request, response);
::    }
::
::    protected void doPost(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        ServletCount s;
::        String mode;
::        try {
::            s = (ServletCount) new InitialContext().lookup("java:module/ServletCount");
::            mode = "GlassFish EJB container (real Singleton EJB)";
::        } catch (Throwable e) {
::            s = LOCAL;
::            mode = "plain Java object (no EJB container, e.g. Tomcat)";
::        }
::        response.setContentType("text/html");
::        PrintWriter out = response.getWriter();
::        out.println("<h2>No. of times Servlet is visited: " + s.count() + "</h2>");
::        out.println("<p>Running on: " + mode + "</p>");
::        out.println("<a href='singleton.html'>Back</a>");
::    }
::}
::#FILE EJB_NOTE.txt
::Real EJB container: GlassFish / Payara.
::Tomcat has no EJB container, so the servlet automatically falls back to a plain
::Java object and the page still works. The page tells you which mode is running.
::#END

::#GROUP P6Q2
::#FILE src/p1/VisitorStatRemote.java
::package p1;
::import javax.ejb.Remote;
::
::@Remote
::public interface VisitorStatRemote {
::    void connect();
::    void disconnect();
::    int addvisitor(String host);
::}
::#FILE src/p1/VisitorStat.java
::package p1;
::
::import java.sql.*;
::import javax.annotation.PostConstruct;
::import javax.annotation.PreDestroy;
::import javax.ejb.LocalBean;
::import javax.ejb.Stateless;
::
::@Stateless
::@LocalBean
::public class VisitorStat implements VisitorStatRemote {
::    private static final String URL = "jdbc:mysql://localhost:3306/@@DBNAME@@?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
::    private static final String USER = "@@DBUSER@@";
::    private static final String PASS = "@@DBPASS@@";
::
::    @PostConstruct
::    public void connect() {
::        System.out.println("VisitorStat: connection setup");
::    }
::
::    @PreDestroy
::    public void disconnect() {
::        System.out.println("VisitorStat: connection closed");
::    }
::
::    // Adds one visit for this host and returns total visits (-1 on error)
::    public int addvisitor(String host) {
::        try {
::            Class.forName("com.mysql.cj.jdbc.Driver");
::            Connection con = DriverManager.getConnection(URL, USER, PASS);
::            try {
::                PreparedStatement up = con.prepareStatement("UPDATE userstat SET visits = visits + 1, dt = NOW() WHERE hostname = ?");
::                up.setString(1, host);
::                if (up.executeUpdate() == 0) {
::                    PreparedStatement ins = con.prepareStatement("INSERT INTO userstat(dt, hostname, visits) VALUES(NOW(), ?, 1)");
::                    ins.setString(1, host);
::                    ins.executeUpdate();
::                }
::                PreparedStatement sel = con.prepareStatement("SELECT visits FROM userstat WHERE hostname = ?");
::                sel.setString(1, host);
::                ResultSet rs = sel.executeQuery();
::                return rs.next() ? rs.getInt(1) : 0;
::            } finally {
::                con.close();
::            }
::        } catch (Exception e) {
::            e.printStackTrace();
::            return -1;
::        }
::    }
::}
::#FILE database_queries.txt
::-- ============================================================
::-- @@QLABEL@@ : @@TITLE@@
::-- Database used ONLY by this question: @@DBNAME@@
::-- Every question has its own database, so other questions are never touched.
::-- Nothing here drops or deletes data (safe to run again).
::-- ============================================================
::
::-- STEP 1: Open MySQL Workbench and connect to your local MySQL server.
::-- STEP 2: Paste everything below into a query tab and click the lightning button (Execute).
::-- STEP 3: After using the web form, run the last SELECT line to see the saved rows.
::
::CREATE DATABASE IF NOT EXISTS @@DBNAME@@;
::USE @@DBNAME@@;
::CREATE TABLE IF NOT EXISTS userstat (
::    dt DATETIME,
::    hostname VARCHAR(50) PRIMARY KEY,
::    visits INT
::);
::
::-- Check saved data:
::SELECT * FROM @@DBNAME@@.userstat;
::#FILE EJB_NOTE.txt
::Real EJB container: GlassFish / Payara.
::Tomcat has no EJB container, so the servlet automatically falls back to a plain
::Java object and the page still works. Run database_queries.txt in MySQL first.
::#FILE src/p1/VisitorServlet.java
::package p1;
::
::import java.io.*;
::import javax.naming.InitialContext;
::import javax.servlet.*;
::import javax.servlet.annotation.WebServlet;
::import javax.servlet.http.*;
::
::@WebServlet("/stat")
::public class VisitorServlet extends HttpServlet {
::    protected void doGet(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        doPost(request, response);
::    }
::
::    protected void doPost(HttpServletRequest request, HttpServletResponse response)
::            throws ServletException, IOException {
::        String host = request.getRemoteHost();
::        VisitorStat bean;
::        String mode;
::        try {
::            bean = (VisitorStat) new InitialContext().lookup("java:module/VisitorStat!p1.VisitorStat");
::            mode = "GlassFish EJB container (real Stateless EJB)";
::        } catch (Throwable e) {
::            bean = new VisitorStat();
::            bean.connect();
::            mode = "plain Java object (no EJB container, e.g. Tomcat)";
::        }
::        int visits = bean.addvisitor(host);
::        response.setContentType("text/html");
::        PrintWriter out = response.getWriter();
::        out.println("<h2>Visitor Statistics</h2>");
::        if (visits < 0) {
::            out.println("<p>Database error. Check MySQL is running, database_queries.txt was executed, and see the server log.</p>");
::        } else {
::            out.println("<p>Host: " + host + "</p>");
::            out.println("<p>Total visits from this host: " + visits + "</p>");
::        }
::        out.println("<p>Running on: " + mode + "</p>");
::        out.println("<a href='stat.html'>Back</a>");
::    }
::}
::#FILE web/stat.html
::<!DOCTYPE html>
::<html>
::<body>
::<h2>EJB Stateless Visitor Statistics</h2>
::<form method="post" action="stat">
::<input type="submit" value="Record my visit">
::</form>
::</body>
::</html>
::#END
