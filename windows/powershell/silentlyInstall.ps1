# Define the path to the FSLogix installer
$installerPath = "C:\Path\To\FSLogix\FSLogixApps.exe"

# Define the silent installation arguments
$silentArgs = "/silent /other_options_here"

# Start the installation silently
Start-Process -FilePath $installerPath -ArgumentList $silentArgs -Wait
