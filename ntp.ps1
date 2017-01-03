$Hosts = get-vmhost 
ForEach ($Host in $Hosts)
{
Remove-VmHostNtpServer -NtpServer "*.*.*.*" -VMHost $Host | Out-Null 
Add-VmHostNtpServer -NtpServer "*.*.*.*" -VMHost $Host | Out-Null
Get-VmHostService -VMHost $Host | Where-Object {$_.key -eq "ntpd"} | Restart-VMHostService -Confirm:$false | Out-Null
write "NTP Server was changed on $Host"
}