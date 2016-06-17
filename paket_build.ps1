Start-Process ".paket\paket.bootstrapper.exe" -NoNewWindow -Wait

if ($LASTEXITCODE -eq 1 ) {
    exit $LASTEXITCODE
}

Start-Process ".paket\paket.exe" -ArgumentList 'restore' -NoNewWindow -Wait

if ($LASTEXITCODE -eq 1 ) {
    exit $LASTEXITCODE
}

$buildConfigArgs =  $Args -join ','

[string[]]$buildArgs = 'build.fsx'

if( $buildConfigArgs ) {
    $buildArgs = $buildArgs , $buildConfigArgs
}

Start-Process "packages\FAKE\tools\FAKE.exe" -ArgumentList( $buildArgs ) -NoNewWindow -Wait
