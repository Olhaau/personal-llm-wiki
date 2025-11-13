# Test Stata Aliases Script
# Verifies that stata15 and stata19 aliases are working correctly

Write-Host "Testing Stata Aliases..." -ForegroundColor Green
Write-Host "========================" -ForegroundColor Green

# Test stata19 alias
Write-Host "`nTesting stata19 alias:" -ForegroundColor Cyan
try {
    $stata19Cmd = Get-Command "stata19" -ErrorAction SilentlyContinue
    if ($stata19Cmd) {
        Write-Host "✓ stata19 alias found" -ForegroundColor Green
        Write-Host "  Command: $($stata19Cmd.Definition)" -ForegroundColor White
        
        # Test if it's a function or alias
        if ($stata19Cmd.CommandType -eq "Function") {
            Write-Host "  Type: PowerShell Function" -ForegroundColor Yellow
        } elseif ($stata19Cmd.CommandType -eq "Alias") {
            Write-Host "  Type: PowerShell Alias" -ForegroundColor Yellow
        }
        
        # Try to get version (this will only work if Stata is actually installed)
        Write-Host "  Testing execution (attempting to get version)..." -ForegroundColor Gray
        try {
            $result = & "stata19" -help 2>&1
            if ($LASTEXITCODE -eq 0 -or $result) {
                Write-Host "  ✓ stata19 executable responds" -ForegroundColor Green
            }
        } catch {
            Write-Host "  ⚠ stata19 alias exists but executable may not be available" -ForegroundColor Yellow
            Write-Host "    This is normal if Stata 19 is not installed" -ForegroundColor Gray
        }
    } else {
        Write-Host "✗ stata19 alias not found" -ForegroundColor Red
    }
} catch {
    Write-Host "✗ Error testing stata19: $($_.Exception.Message)" -ForegroundColor Red
}

# Test stata15 alias
Write-Host "`nTesting stata15 alias:" -ForegroundColor Cyan
try {
    $stata15Cmd = Get-Command "stata15" -ErrorAction SilentlyContinue
    if ($stata15Cmd) {
        Write-Host "✓ stata15 alias found" -ForegroundColor Green
        Write-Host "  Command: $($stata15Cmd.Definition)" -ForegroundColor White
        
        # Test if it's a function or alias
        if ($stata15Cmd.CommandType -eq "Function") {
            Write-Host "  Type: PowerShell Function" -ForegroundColor Yellow
        } elseif ($stata15Cmd.CommandType -eq "Alias") {
            Write-Host "  Type: PowerShell Alias" -ForegroundColor Yellow
        }
        
        # Try to get version (this will only work if Stata is actually installed)
        Write-Host "  Testing execution (attempting to get version)..." -ForegroundColor Gray
        try {
            $result = & "stata15" -help 2>&1
            if ($LASTEXITCODE -eq 0 -or $result) {
                Write-Host "  ✓ stata15 executable responds" -ForegroundColor Green
            }
        } catch {
            Write-Host "  ⚠ stata15 alias exists but executable may not be available" -ForegroundColor Yellow
            Write-Host "    This is normal if Stata 15 is not installed" -ForegroundColor Gray
        }
    } else {
        Write-Host "✗ stata15 alias not found" -ForegroundColor Red
    }
} catch {
    Write-Host "✗ Error testing stata15: $($_.Exception.Message)" -ForegroundColor Red
}

# Display all available Stata-related commands
Write-Host "`nAll Stata-related commands found:" -ForegroundColor Cyan
try {
    $stataCommands = Get-Command "*stata*" -ErrorAction SilentlyContinue
    if ($stataCommands) {
        foreach ($cmd in $stataCommands) {
            Write-Host "  $($cmd.Name) ($($cmd.CommandType))" -ForegroundColor White
        }
    } else {
        Write-Host "  No Stata-related commands found" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  Error searching for Stata commands" -ForegroundColor Red
}

Write-Host "`nAlias test complete!" -ForegroundColor Green
Write-Host "`nIf aliases are missing, run: .\setup-stata-path.ps1" -ForegroundColor Yellow