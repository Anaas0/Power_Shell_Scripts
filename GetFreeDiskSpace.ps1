$prompt = New-Object -ComObject Wscript.Shell
$prompt.Popup("Checks C Drive disk space for Leeds Domain servers only. Accurate as of 07/05/2021.",0,"Disk Space", 64)
Get-CimInstance -Class CIM_LogicalDisk -ComputerName (Get-Content -Path 'C:\Scripts\Disk Space Check\DiskServers.txt') | Select-Object @{Name="Size(GB)";Expression={[Math]::Ceiling($_.size/1gb)}}, @{Name="Free Space(GB)";Expression={[Math]::Ceiling($_.freespace/1gb)}}, @{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}}, DeviceID, DriveType, SystemName | Where-Object DriveType -EQ '3' | Where-Object DeviceID -eq 'C:' | Out-GridView -Title "Disk Space"