Add-Type -AssemblyName PresentationFramework
$dir="C:\`$WINDOWS.~BT\Sources"
$FakeSource=".\AppraiserRes.dll"
$TureSource="C:\`$WINDOWS.~BT\Sources\AppraiserRes.dll"
$time=0
$NOTADMIN=0

if(test-Path -Path $FakeSource)
{
    $Yourfile = Get-Item $FakeSource
    Write-Output "替换文件已经创建"
    $Yourfile.IsReadOnly = $true
} Else {
    $null > $FakeSource
    Write-Output "未创建替换文件，正在创建一个只读的AppraiserRes.dll"
    $Yourfile = Get-Item $FakeSource
    $Yourfile.IsReadOnly = $true
}

if ((([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544"))
 {
     Write-Output "你是系统管理员，可以运行这个脚本"
 } Else {
     Write-Output "你不是系统管理员，请使用管理员Powershell权限运行"
     $NOTADMIN=1
 }

if($NOTADMIN)
{
    $Yourfile.IsReadOnly = $false
    break
}
else
{
for (1) {
    If (Test-Path -Path $dir -PathType Container)
    {
        Write-Output "已找到系统更新文件夹，正在等待安装文件"
        break;
    } Else {
        Write-Output "等待安装文件夹中......"
        Start-Sleep –s 1
        $time+=1;
        Write-Output "已经等待$time`s"
    }
}
$time=0
for(1) {
    if (Test-Path -Path $TureSource)
    {
     try {
        Copy-Item -Path $FakeSource  -Destination $TureSource -Recurse -Force -ErrorAction Stop
        } Catch {
            $MessageBody = $_.Exception.Message
            $ButtonType = [System.Windows.MessageBoxButton]::OK
            $MessageIcon = [System.Windows.MessageBoxImage]::Error
            $MessageTitle = "替换失败"
            Write-Error $MessageTitle
            [System.Windows.MessageBox]::Show($MessageBody, $MessageTitle, $ButtonType, $MessageIcon)
            $Yourfile.IsReadOnly = $false
            Throw $MessageBody
        }
        
        $MessageBody = "替换成功"
        $ButtonType = [System.Windows.MessageBoxButton]::OK
        $MessageIcon = [System.Windows.MessageBoxImage]::Information
        $MessageTitle = "安装成功"
        Write-Output $MessageTitle
        [System.Windows.MessageBox]::Show($MessageBody, $MessageTitle, $ButtonType, $MessageIcon)
        $Yourfile.IsReadOnly = $false
        break;
    } Else {
        Write-Output "等待安装文件中......"
        Start-Sleep –s 1
        $time+=1;
        Write-Output "已经等待$time`s"
    }
}
}