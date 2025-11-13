# Stata Test Suite for Log Generation

A PowerShell and Stata-based test suite for testing Stata log file generation with standardized naming conventions.

## Overview

This test suite provides tools to:
- Configure Stata 19 and Stata 15 in your PATH environment
- Generate Stata log files with standardized naming: `log-<hostname>-<YYYYMMDD-HHMM>-<script-name>.log`
- Run long-duration logging tests (5-hour continuous logging)
- Configure shared log paths for local and network storage
- Run automated tests for log generation functionality

## Files

- `setup-stata-path.ps1` - PowerShell script to add Stata installations to PATH and create aliases
- `stata-env.do` - Environment configuration file with shared variables for log paths
- `test-log-append-generation.do` - .do file that runs for 5 hours using log append method, logging timestamped entries every minute
- `test-data-analysis.do` - Advanced .do file with data analysis operations for testing
- `run-tests.ps1` - PowerShell script to execute .do files and manage test runs
- `test-aliases.ps1` - Utility script to verify stata15/stata19 aliases are working
- `README.md` - This documentation file

## Prerequisites

- Windows PowerShell 5.1 or PowerShell Core 7+
- Stata 15 and/or Stata 19 installed
- Administrative privileges may be required for PATH modifications

## Quick Start

### 1. Setup Stata Environment

Run the setup script to add Stata to your PATH and create aliases:

```powershell
# Default installation paths
.\setup-stata-path.ps1

# Custom installation paths
.\setup-stata-path.ps1 -Stata19Path "C:\Custom\Path\Stata19" -Stata15Path "C:\Custom\Path\Stata15"
```

This script will:
- Add Stata directories to your PATH
- Create `stata15` and `stata19` aliases for easy access
- Automatically detect the best Stata executable (MP, SE, or IC)
- Provide instructions for making aliases persistent

### 1.1. Verify Aliases (Optional)

Test that the aliases were created successfully:

```powershell
# Test if aliases are working
.\test-aliases.ps1

# Or test manually
stata19 -help
stata15 -help
```

### 2. Configure Environment (Optional)

Edit the `stata-env.do` file to customize log paths:

```stata
* Edit stata-env.do to set your preferred paths
global log_path_local "C:\logs\local"
global log_path_network "\\server\shared\logs"
```

### 3. Run Log Generation Tests

Execute the test runner to generate log files:

```powershell
# Run 5-hour log append test with default settings
.\run-tests.ps1

# Specify Stata version
.\run-tests.ps1 -StataVersion "15"

# Run data analysis test instead
.\run-tests.ps1 -DoFile "test-data-analysis.do"

# Clean previous log files before running
.\run-tests.ps1 -CleanLogs
```

**Note**: The default `test-log-append-generation.do` runs for 5 hours using the log append method, writing a timestamped entry every minute (300 total entries).

## Log File Naming Convention

Generated log files follow this pattern:
```
log-<hostname>-<YYYYMMDD-HHMM>-<script-name>.log
```

Examples:
- `log-DESKTOP-ABC123-20241113-1430-test-log-generation.log`
- `log-SERVER01-20241113-0915-custom-test.log`

## Creating Custom Test Files

To create additional .do files for testing:

1. Copy `test-log-append-generation.do` as a template
2. Modify the `script_name` variable to match your filename
3. Add your specific test operations
4. Use `run-tests.ps1` with the `-DoFile` parameter to execute

## Troubleshooting

### Stata Not Found
- Verify Stata is installed in the expected location
- Run `setup-stata-path.ps1` with correct paths
- Check that PATH includes Stata directory

### Permission Issues
- Run PowerShell as Administrator
- Check execution policy: `Get-ExecutionPolicy`
- If needed, temporarily allow scripts: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

### Log File Issues
- Ensure write permissions in the current directory
- Check disk space availability
- Verify no other processes are using the log files

## Advanced Usage

### Direct Alias Usage

Once aliases are set up, you can use Stata directly:

```powershell
# Run .do files directly with aliases
stata19 /e do test-log-append-generation.do
stata15 /e do test-data-analysis.do

# Get help
stata19 -help
stata15 -help

# Run interactively
stata19
```

### Multiple Stata Versions Testing

Test with different Stata versions:

```powershell
# Test with Stata 19
.\run-tests.ps1 -StataVersion "19" -DoFile "version-test.do"

# Test with Stata 15
.\run-tests.ps1 -StataVersion "15" -DoFile "version-test.do"
```

### Making Aliases Persistent

To use `stata15` and `stata19` aliases in future sessions, add the following to your PowerShell profile:

```powershell
# Check if you have a profile
$PROFILE

# Edit your profile (create if it doesn't exist)
notepad $PROFILE

# Add these lines to your profile (adjust paths as needed):
function stata19 { & "C:\Program Files\Stata19\StataMP-64.exe" $args }
function stata15 { & "C:\Program Files\Stata15\StataMP-64.exe" $args }
```

### Automated Test Runs

Create batch testing scripts:

```powershell
# Clean and run multiple tests
.\run-tests.ps1 -CleanLogs -DoFile "test1.do"
.\run-tests.ps1 -DoFile "test2.do"
.\run-tests.ps1 -DoFile "test3.do"
```

## Log File Analysis

Generated log files contain:
- System information (hostname, Stata version, OS, user)
- Timestamp information
- Test operations and results
- Complete Stata session output

Use these files to verify:
- Correct naming convention implementation
- Proper log content generation
- System information capture
- Test operation execution

## Contributing

To extend the test suite:
1. Add new .do files following the existing template pattern
2. Update the script_name variable appropriately
3. Test with both `run-tests.ps1` and manual execution
4. Document any new functionality in this README