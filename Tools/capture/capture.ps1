Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing


$Path = "C:\Users\" + "Public" + "\Desktop"

$screen_width = Get-Content -Path ./screen_w_WmiObject.dat
$screen_height = Get-Content -Path ./screen_h_WmiObject.dat

$screen_width = [int] $($screen_width)
$screen_height = [int] $($screen_height)

$screen_width
$screen_height

$bitmap = New-Object System.Drawing.Bitmap($screen_width, $screen_height)

$graphic = [System.Drawing.Graphics]::FromImage($bitmap)

$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)

$screen_file = "$Path\" + 'Result' + "_" + "$((get-date).tostring('yyyy.MM.dd-HH.mm.ss')).png"

$bitmap.Save($screen_file)

<#
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width = $Screen.Width
$Height = $Screen.Height
$Left = $Screen.Left
$Top = $Screen.Top

# Set bounds
$bitmap = New-Object System.Drawing.Bitmap $Width, $Height

# Create Object
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)

# Capture
$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)

# Date
$screen_file = "$Path\" + 'Result' + "_" + "$((get-date).tostring('yyyy.MM.dd-HH.mm.ss')).png"

# Save
$bitmap.Save($screen_file)

#>

<#
If (!(test-path $path)) {
New-Item -ItemType Directory -Force -Path $path
}
#>

<#
#$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$screen_width = Get-Content -Path ./screen_w.dat
$screen_height = Get-Content -Path ./screen_h.dat

#$screen_width = 300
#$screen_height = 300

$screen_width = [int]$screen_width
$screen_height = [int]$screen_height

#write-host $screen
#$image = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)
$image = New-Object System.Drawing.Bitmap($screen_width, $screen_height)


# Create a graphic object
$graphic = [System.Drawing.Graphics]::FromImage($image)
$point = New-Object System.Drawing.Point(0, 0)
$graphic.CopyFromScreen($point, $point, $image.Size);
$cursorBounds = New-Object System.Drawing.Rectangle([System.Windows.Forms.Cursor]::Position, [System.Windows.Forms.Cursor]::Current.Size)
write-host $image.Size
# Get a screenshot
[System.Windows.Forms.Cursors]::Default.Draw($graphic, $cursorBounds)
$screen_file = "$Path\" + 'Result' + "_" + "$((get-date).tostring('yyyy.MM.dd-HH.mm.ss')).png"


# Save the screenshot as a PNG file
$image.Save($screen_file, [System.Drawing.Imaging.ImageFormat]::Png)
#>