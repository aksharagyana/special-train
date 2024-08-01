# Define the list of URLs
$urls = @(
    "https://www.google.com",
    "https://www.microsoft.com",
    "https://nonexistentwebsite.example"
)

# Function to check URL connectivity
function Test-Url {
    param (
        [string]$url
    )
    try {
        # Send a HEAD request using Invoke-RestMethod
        $response = Invoke-RestMethod -Uri $url -Method Head -UseBasicParsing -TimeoutSec 5
        return $true
    } catch {
        # If an error occurs, check the status code
        if ($_.Exception.Response.StatusCode -ge 400 -and $_.Exception.Response.StatusCode -le 599) {
            return $true
        } else {
            return $false
        }
    }
}

# Check connectivity for each URL and print the result
foreach ($url in $urls) {
    if (Test-Url -url $url) {
        Write-Host "$url is reachable" -ForegroundColor Green
    } else {
        Write-Host "$url is not reachable" -ForegroundColor Red
    }
}
