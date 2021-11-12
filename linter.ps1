Set-StrictMode -Version 3.0
$ErrorActionPreference = ÅgStopÅh
$CURRENT_DIR = $PSScriptRoot

Push-Location $CURRENT_DIR
npx markdownlint . --ignore node_modules/
Pop-Location