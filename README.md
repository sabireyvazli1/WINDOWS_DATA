# WINDOWS_DATA
Python script işləyə bilməsi üçün python və onun request kitabxanasını tələb edir.

▶ Invoke-WebRequest -Uri "https://www.python.org/ftp/python/3.9.10/python-3.9.10-amd64.exe" -OutFile "python-installer.exe"
▶ Start-Process -FilePath "python-installer.exe" -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
▶ pip install request 
