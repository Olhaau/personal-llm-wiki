# Stata Test Suite Runner
# Executes .do files and manages test runs

param(
    [string]$StataVersion = "19",
    [string]$DoFile = "test-log-append-generation.do",
    [string]$LogPath = ""
)

Write-Host "Stata Test Suite Runner" -ForegroundColor Green
Write-Host "======================" -ForegroundColor Green

# Handle LogPath parameter
if ($LogPath) {
    Write-Host "Custom log path specified: $LogPath" -ForegroundColor Cyan
    # Set environment variable that Stata can access
    $env:STATA_LOG_PATH = $LogPath
    Write-Host "Set STATA_LOG_PATH environment variable" -ForegroundColor Green
}

# Verify .do file exists
if (-not (Test-Path $DoFile)) {
    Write-Host "Error: .do file '$DoFile' not found!" -ForegroundColor Red
    Write-Host "Available .do files:" -ForegroundColor Yellow
    Get-ChildItem -Path "." -Name "*.do" | ForEach-Object { Write-Host "  $_" -ForegroundColor White }
    exit 1
}

# Determine Stata executable to use
$stataExe = $null

# First try to use the stata15/stata19 aliases (preferred method)
$preferredAlias = "stata$StataVersion"
try {
    if (Get-Command $preferredAlias -ErrorAction SilentlyContinue) {
        $stataExe = $preferredAlias
        Write-Host "Using alias: $preferredAlias" -ForegroundColor Green
    }
} catch {
    # Continue to fallback methods
}

# Fallback to checking PATH for executables
if (-not $stataExe) {
    $stataAliases = @("StataMP-64.exe", "StataSE-64.exe", "StataIC-64.exe")
    
    foreach ($alias in $stataAliases) {
        try {
            $testCommand = Get-Command $alias -ErrorAction SilentlyContinue
            if ($testCommand) {
                $stataExe = $alias
                Write-Host "Found executable in PATH: $alias" -ForegroundColor Yellow
                break
            }
        } catch {
            continue
        }
    }
}

if (-not $stataExe) {
    Write-Host "Error: Could not find Stata $StataVersion executable!" -ForegroundColor Red
    Write-Host "Please ensure:" -ForegroundColor Yellow
    Write-Host "  1. Stata is installed" -ForegroundColor White
    Write-Host "  2. Run setup-stata-path.ps1 first" -ForegroundColor White
    Write-Host "  3. Stata is in your PATH" -ForegroundColor White
    exit 1
}

Write-Host "Using Stata executable: $stataExe" -ForegroundColor Cyan
Write-Host "Running .do file: $DoFile" -ForegroundColor Cyan
if ($LogPath) {
    Write-Host "Log path override: $LogPath" -ForegroundColor Cyan
}

# Run the .do file
Write-Host "`nExecuting Stata script..." -ForegroundColor Yellow
try {
    # Execute Stata in batch mode (use /b flag for non-interactive batch processing)
    if ($stataExe -like "stata*") {
        # Using alias - let it handle the batch mode optimization
        & $stataExe "do" "$DoFile"
    } else {
        # Using direct executable - use batch mode flags
        & $stataExe "/b" "do" "$DoFile"
    }
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`nStata execution completed successfully!" -ForegroundColor Green
        
        # List generated log files
        Write-Host "`nGenerated log files:" -ForegroundColor Cyan
        
        # Check both current directory and custom log path
        $searchPaths = @(".")
        if ($LogPath -and (Test-Path $LogPath)) {
            $searchPaths += $LogPath
        }
        
        foreach ($path in $searchPaths) {
            $logFiles = Get-ChildItem -Path $path -Name "log-*.log" -ErrorAction SilentlyContinue
            if ($logFiles) {
                Write-Host "  In $path :" -ForegroundColor Yellow
                $logFiles | Sort-Object LastWriteTime -Descending | ForEach-Object {
                    $file = Get-Item (Join-Path $path $_)
                    Write-Host "    $($file.Name) ($(Get-Date $file.LastWriteTime -Format 'yyyy-MM-dd HH:mm:ss'))" -ForegroundColor White
                }
            }
        }
    } else {
        Write-Host "`nStata execution failed with exit code: $LASTEXITCODE" -ForegroundColor Red
    }
} catch {
    Write-Host "`nError executing Stata: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "`nTest run complete!" -ForegroundColor Green