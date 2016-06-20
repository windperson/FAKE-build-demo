$paketBootStrapper = "./.paket/paket.bootstrapper.exe"

if ( ! (Test-Path $paketBootStrapper)){
    $url = "http://github.com/fsprojects/Paket/releases/download/3.1.6/paket.bootstrapper.exe"
    try{
        $wc = New-Object System.Net.WebClient
        $wc.UseDefaultCredentials=$true
        $wc.Proxy.Credentials=$wc.Credentials
        $wc.DownloadFile($url,  $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($paketBootStrapper))
    }catch{
        echo "Download paket bootstrapper failed."
        echo $Error[0]
        exit 1
    }
}
    
$paketExe = ".paket\paket.exe"

if ( ! (Test-Path $paketExe )){
    Start-Process ".paket\paket.bootstrapper.exe" -NoNewWindow -Wait
    if ($LASTEXITCODE -eq 1 -and ! (Test-Path $paketExe) ) {
        echo "Install paket failed."
        exit $LASTEXITCODE
    }
}

$fakeExe = "packages\FAKE\tools\FAKE.exe"

if ( ! (Test-Path $fakeExe)){
    Start-Process $paketExe -ArgumentList 'restore' -NoNewWindow -Wait
    if ($LASTEXITCODE -eq 1 -and ! (Test-Path $fakeExe) ) {
        echo "Install FAKE failed."
        exit $LASTEXITCODE
    }
} 

Start-Process $fakeExe $Args -NoNewWindow -Wait
