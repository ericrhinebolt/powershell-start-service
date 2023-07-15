# powershell-start-service

This script was written to start a 7 Days to Die dedicated server automatically on windows restart.

#### **_This was intended to be used on Windows 11, Powershell 6.+._**

My server is located in the directory "C:\7-days". Either install to the same directory or change the code/commands to match your location.

### If you would like to use this script for you own server, please follow the steps below.

1. Download the code in the "start-service-refresh.ps1" file. Save it to a text file with a .ps1 extension. Either save it to C:\7-days\start-service-refresh.ps1 or change the path in step 4. - iii.

2. This code will need signed with a self signed certificate for it to run correctly. Open Powershell with Run as Administrator.

3. Run the following commands:
   1. ```
      $authenticode = New-SelfSignedCertificate -Subject "7 Days Server Authenticode" -CertStoreLocation Cert:\LocalMachine\My -Type CodeSigningCert
      ```
   2. ```
      $rootStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("Root","LocalMachine")
      $rootStore.Open("ReadWrite")
      $rootStore.Add($authenticode)
      $rootStore.Close()
      $publisherStore = [System.Security.Cryptography.X509Certificates.X509Store]::new("TrustedPublisher","LocalMachine")
      $publisherStore.Open("ReadWrite")
      $publisherStore.Add($authenticode)
      $publisherStore.Close()
      ```
   3. ```
      $codeCertificate = Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Subject -eq "CN=7 Days Server Authenticode"}
      Set-AuthenticodeSignature -FilePath C:\7-days\start-service-refresh.ps1 -Certificate $codeCertificate -TimeStampServer http://timestamp.digicert.com
      ```
   4. ```
      Set-ExecutionPolicy AllSigned
      ```
4. You should now have a signed powershell script that you can run from powershell. Continue on to the next steps to have that script starts when windows starts.

5. Create another new text file named "7-days-auto-start.cmd". Open the file. Put the following text into the file:
   1. ```
      powerShell C:\7-days\start-service-refresh.ps1
      ```

6. You will have to add this file to your startup programs. To do this, navigate to the address below. You will need to change YOURUSERNAME to your windows username.
   1. ```
      C:\Users\YOURUSERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
      ```

7. Add a shortcut to "7-days-auto-start.cmd" into this folder. It will now start when you log into windows. If you'd like to have windows perform autologin to completely automate the process, navigate to the following link and follow the instructions.
   1. ```
      https://learn.microsoft.com/en-us/troubleshoot/windows-server/user-profiles-and-logon/turn-on-automatic-logon
      ```