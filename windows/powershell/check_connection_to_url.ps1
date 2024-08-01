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
        # Create a web request
        $request = [System.Net.WebRequest]::Create($url)
        $request.Method = "HEAD"
        $response = $request.GetResponse()
        $response.Close()
        return $true
    } catch {
        return $false
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
