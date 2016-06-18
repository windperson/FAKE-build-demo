$paketExe = ".paket\paket.exe"

if ( ! (Test-Path $paketExe )){
    Start-Process ".paket\paket.bootstrapper.exe" -NoNewWindow -Wait
    if ($LASTEXITCODE -eq 1 ) {
        echo "Install paket failed."
        exit $LASTEXITCODE
    }
}

$fakeExe = "packages\FAKE\tools\FAKE.exe"

if ( ! (Test-Path $fakeExe)){
    Start-Process $paketExe -ArgumentList 'restore' -NoNewWindow -Wait
    if ($LASTEXITCODE -eq 1 ) {
        echo "Install FAKE failed."
        exit $LASTEXITCODE
    }
}

Start-Process $fakeExe $Args -NoNewWindow -Wait
