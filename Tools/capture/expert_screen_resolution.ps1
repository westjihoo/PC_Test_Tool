# Add-Type -AssemblyName System.Windows.Forms

<#
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
Out-File -filePath .\screen_w_PrimaryScreen.dat -inputObject $screen.Width
Out-File -filePath .\screen_h_PrimaryScreen.dat -inputObject $screen.Height

$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
Out-File -filePath .\screen_w_VirtualScreen.dat -inputObject $screen.Width
Out-File -filePath .\screen_h_VirtualScreen.dat -inputObject $screen.Height

$Screen = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
Out-File -filePath .\screen_w_ScreenOrientation.dat -inputObject $screen.Width
Out-File -filePath .\screen_h_ScreenOrientation.dat -inputObject $screen.Height
#>

$Screen = Get-WmiObject -Class Win32_VideoController
Out-File -filePath .\screen_w_WmiObject.dat -inputObject $screen.CurrentHorizontalResolution
Out-File -filePath .\screen_h_WmiObject.dat -inputObject $screen.CurrentVerticalResolution