// include Fake lib
#r @"packages\FAKE\tools\FakeLib.dll"
open Fake

// Properties
let buildDir = "./build/"

// Targets
Target "Clean" (fun _ ->
    CleanDir buildDir
)

Target "BuildApp" (fun _ ->
    !! "src/app/**/*.csproj"
        |> MSBuildRelease buildDir "Build"
        |> Log "AppBuild-Output: "
)

// Default target
Target "Default" (fun _ ->
    trace "Hello World from FAKE"
)

// Dependencies
"Clean"
    ==> "BuildApp"
    ==> "Default"

// start build
RunTargetOrDefault "Default"