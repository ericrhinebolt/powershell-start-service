Set-Location -Path "C:\7-days"

for(;;){
    try{
        $GetProcess = Get-Process -Name 7DaysToDieServer -ErrorAction SilentlyContinue
        If (!$GetProcess){
            write-host 'Server starting'
            Start-Process -FilePath ".\startdedicated.bat"
            }
        Start-Sleep -Seconds 30
        }
    catch{}
        Start-sleep -Seconds 30
}
