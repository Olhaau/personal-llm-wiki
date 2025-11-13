# Stata Test Suite Setup Script
# Adds Stata 19 and Stata 15 to PATH environment variable

param(
    [string]$Stata19Path = "C:\Program Files\Stata19",
    [string]$Stata15Path = "C:\Program Files\Stata15"
)

Write-Host "Setting up Stata Test Suite Environment..." -ForegroundColor Green

# Function to check if a path exists and add to PATH if it does
function Add-StataToPath {
    param(
        [string]$StataPath,
        [string]$Version
    )
    
    if (Test-Path $StataPath) {
        Write-Host "Found Stata $Version at: $StataPath" -ForegroundColor Yellow
        
        # Check if already in PATH
        $currentPath = $env:PATH
        if ($currentPath -notlike "*$StataPath*") {
            $env:PATH = "$StataPath;$currentPath"
            Write-Host "Added Stata $Version to PATH" -ForegroundColor Green
        } else {
            Write-Host "Stata $Version already in PATH" -ForegroundColor Cyan
        }
        
        # Try to verify Stata executable and return the found executable
        $stataExe = Join-Path $StataPath "StataMP-64.exe"
        if (-not (Test-Path $stataExe)) {
            $stataExe = Join-Path $StataPath "StataSE-64.exe"
        }
        if (-not (Test-Path $stataExe)) {
            $stataExe = Join-Path $StataPath "StataIC-64.exe"
        }
        
        if (Test-Path $stataExe) {
            Write-Host "Verified Stata executable: $stataExe" -ForegroundColor Green
            return $stataExe
        } else {
            Write-Host "Warning: Could not find Stata executable in $StataPath" -ForegroundColor Red
            return $null
        }
    } else {
        Write-Host "Warning: Stata $Version not found at: $StataPath" -ForegroundColor Red
        Write-Host "Please verify the installation path or provide correct path using parameters" -ForegroundColor Yellow
        return $null
    }
}

# Function to create and export alias
function Create-StataAlias {
    param(
        [string]$AliasName,
        [string]$ExecutablePath
    )
    
    if ($ExecutablePath -and (Test-Path $ExecutablePath)) {
        # Create alias in current session
        Set-Alias -Name $AliasName -Value $ExecutablePath -Scope Global
        
        # Export alias function to make it available
        $functionDefinition = @"
function $AliasName {
    & "$ExecutablePath" `$args
}
"@
        
        Invoke-Expression $functionDefinition
        Write-Host "Created alias: $AliasName -> $ExecutablePath" -ForegroundColor Green
        return $true
    }
    return $false
}

# Add Stata versions to PATH and get executable paths
Write-Host "`nConfiguring Stata paths..." -ForegroundColor Cyan
$Stata19Exe = Add-StataToPath -StataPath $Stata19Path -Version "19"
$Stata15Exe = Add-StataToPath -StataPath $Stata15Path -Version "15"

# Display current PATH for verification
Write-Host "`nCurrent PATH includes:" -ForegroundColor Cyan
$env:PATH.Split(';') | Where-Object { $_ -like "*Stata*" } | ForEach-Object { Write-Host "  $_" -ForegroundColor White }

Write-Host "`nStata Test Suite environment setup complete!" -ForegroundColor Green
Write-Host "You can now run Stata .do files for testing log generation." -ForegroundColor Yellow

# Create Stata aliases for easier access
Write-Host "`nCreating Stata aliases..." -ForegroundColor Cyan
$aliasesCreated = @()

if ($Stata19Exe) {
    if (Create-StataAlias -AliasName "stata19" -ExecutablePath $Stata19Exe) {
        $aliasesCreated += "stata19"
    }
}

if ($Stata15Exe) {
    if (Create-StataAlias -AliasName "stata15" -ExecutablePath $Stata15Exe) {
        $aliasesCreated += "stata15"
    }
}

# Export functions to make aliases work in current session
if ($aliasesCreated.Count -gt 0) {
    Write-Host "`nAliases available in this session:" -ForegroundColor Green
    foreach ($alias in $aliasesCreated) {
        Write-Host "  $alias" -ForegroundColor White
    }
    
    # Create profile script for persistent aliases (optional)
    $profilePath = $PROFILE
    if ($profilePath) {
        Write-Host "`nTo make aliases persistent across sessions:" -ForegroundColor Yellow
        Write-Host "  Add the following to your PowerShell profile: $profilePath" -ForegroundColor Cyan
        Write-Host ""
        if ($Stata19Exe) {
            Write-Host "  function stata19 { & `"$Stata19Exe`" `$args }" -ForegroundColor White
        }
        if ($Stata15Exe) {
            Write-Host "  function stata15 { & `"$Stata15Exe`" `$args }" -ForegroundColor White
        }
    }
} else {
    Write-Host "No aliases created - no Stata installations found" -ForegroundColor Red
}

Write-Host "`nUsage examples:" -ForegroundColor Yellow
Write-Host "  stata19 /e do test-script.do" -ForegroundColor White
Write-Host "  stata15 /e do test-script.do" -ForegroundColor White
Write-Host "  stata19 -help" -ForegroundColor White
Write-Host "  stata15 -help" -ForegroundColor White