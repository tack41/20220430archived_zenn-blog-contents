Set-StrictMode -Version 3.0
$ErrorActionPreference = �gStop�h

$CURRENT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
#$PARENT_DIR = Split-Path -Parent $CURRENT_DIR
#$SCRIPT_NAME = $MyInvocation.MyCommand.Name

Push-Location $CURRENT_DIR
npx markdownlint . --ignore node_modules/
Pop-Location