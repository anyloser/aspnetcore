param(
    [switch]$ci
)

# GenAPI with `dotnet msbuild` doesn't consistently order attributes in Microsoft.AspNetCore.Mvc.TagHelpers.netcoreapp.cs
$msbuildEngine = 'vs'

$ErrorActionPreference = 'stop'
$repoRoot = Resolve-Path "$PSScriptRoot/../.."

try {
  & "$repoRoot\eng\common\msbuild.ps1" -ci:$ci "$repoRoot/eng/CodeGen.proj" `
    /t:GenerateReferenceSources `
    /bl:artifacts/log/genrefassemblies.binlog `
    /p:BuildNative=true
} finally {
    Remove-Item variable:global:_BuildTool -ErrorAction Ignore
    Remove-Item variable:global:_DotNetInstallDir -ErrorAction Ignore
    Remove-Item variable:global:_ToolsetBuildProj -ErrorAction Ignore
    Remove-Item variable:global:_MSBuildExe -ErrorAction Ignore
}
