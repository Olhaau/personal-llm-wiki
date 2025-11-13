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
- User account (no administrative privileges required)
- PowerShell execution policy allowing script execution

## Quick Start

### 1. Setup Stata Environment (One-time Setup)

Run the setup script to permanently configure Stata:

```powershell
# Default installation paths
.\setup-stata-path.ps1

# Custom installation paths
.\setup-stata-path.ps1 -Stata19Path "C:\Custom\Path\Stata19" -Stata15Path "C:\Custom\Path\Stata15"
```

This script will **permanently**:
- Add Stata directories to your user PATH environment variable
- Create `stata15` and `stata19` aliases in your PowerShell profile
- Automatically detect the best Stata executable (MP, SE, or IC)
- Update your PowerShell profile for persistent access across sessions

**Important**: After running this script:
1. **Restart PowerShell** to activate PATH changes
2. Aliases will be available in all future PowerShell sessions
3. No need to run the setup script again unless paths change

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

# Override log path
.\run-tests.ps1 -LogPath "D:\custom\logs"
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
- Check execution policy: `Get-ExecutionPolicy`
- If needed, allow scripts: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
- No administrative privileges required (uses user environment variables)

### Aliases Not Working After Setup
- **Restart PowerShell** after running setup-stata-path.ps1
- Check if profile was created: `Test-Path $PROFILE.CurrentUserAllHosts`
- Verify PATH was updated: `$env:PATH -split ';' | Where-Object { $_ -like '*Stata*' }`
- Re-run setup if needed: `.\setup-stata-path.ps1 -Force`

### Batch Mode Execution Issues
The aliases automatically handle batch mode execution to prevent interruption prompts:

```powershell
# ✅ Correct - No interruption prompts
stata19 do test-log-append-generation.do
stata15 do test-data-analysis.do

# ❌ Avoid - May cause interruption prompts  
stata19 /e do test-log-append-generation.do

# ✅ Manual batch mode (if needed)
stata19 /b do test-log-append-generation.do
```

**Key Points:**
- Use `stata19 do filename.do` for smooth batch execution
- The `/e` flag can cause "batch job interrupted" prompts
- The aliases automatically use `/b` (batch mode) for `.do` files
- Interactive mode: just run `stata19` with no arguments

### Profile Issues
- If profile doesn't load, check: `Get-ExecutionPolicy`
- View profile content: `Get-Content $PROFILE.CurrentUserAllHosts`
- Manual profile creation: `New-Item $PROFILE.CurrentUserAllHosts -Force`

### Log File Issues
- Ensure write permissions in the current directory
- Check disk space availability
- Verify no other processes are using the log files

## Log Path Configuration

The test suite supports flexible log path configuration:

### 1. Default Path
By default, logs are saved to: `C:/[USERNAME]/Documents/logs`

### 2. Environment File Override
Edit `stata-env.do` to change the default:
```stata
global log_path_local "D:\MyLogs"
global log_path_network "\\server\shared\logs"
```

### 3. Runtime Override
Use the `-LogPath` parameter to override at runtime:
```powershell
# Save logs to custom directory
.\run-tests.ps1 -LogPath "C:\CustomLogs"

# Save logs to network location
.\run-tests.ps1 -LogPath "\\server\projects\logs"
```

The `-LogPath` parameter takes precedence over all other settings.

## Advanced Usage

### Direct Alias Usage

Once aliases are set up, you can use Stata directly:

```powershell
# Run .do files directly with aliases (batch mode - no interruption prompts)
stata19 do test-log-append-generation.do
stata15 do test-data-analysis.do

# Get help
stata19 -help
stata15 -help

# Run interactively (GUI mode)
stata19

# Manual batch mode (if needed)
stata19 /b do test-log-append-generation.do
```

### Multiple Stata Versions Testing

Test with different Stata versions:

```powershell
# Test with Stata 19
.\run-tests.ps1 -StataVersion "19" -DoFile "version-test.do"

# Test with Stata 15
.\run-tests.ps1 -StataVersion "15" -DoFile "version-test.do"
```

### Persistent Configuration

The setup script automatically handles persistence:

- **PATH Changes**: Added to user environment variables (permanent)
- **PowerShell Aliases**: Added to your PowerShell profile automatically
- **Profile Location**: `$PROFILE.CurrentUserAllHosts`
- **Automatic Loading**: Aliases load in every new PowerShell session

If you need to modify or remove the configuration:

```powershell
# View your PowerShell profile
notepad $PROFILE.CurrentUserAllHosts

# Look for the "STATA TEST SUITE" section
# Delete the section to remove aliases
```

### Automated Test Runs

Create batch testing scripts:

```powershell
# Run multiple tests with different configurations
.\run-tests.ps1 -DoFile "test-log-append-generation.do" -LogPath "C:\TestLogs"
.\run-tests.ps1 -DoFile "test-data-analysis.do" -StataVersion "15"
.\run-tests.ps1 -DoFile "custom-test.do" -LogPath "\\server\shared\logs"
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