* Stata Environment Configuration File
* Shared variables for log paths used by all .do files
* Author: Stata Test Suite
* Created: `c(current_date)'

* =================================================================
* ENVIRONMENT VARIABLES
* =================================================================

* Local log path - where logs are stored locally
* Default: current directory, can be customized as needed
global log_path_local "."

* Network log path - where logs should be copied/stored on network
* Update this path according to your network storage location
global log_path_network "\\server\shared\logs"

* Alternative network paths for different environments:
* Development: \\dev-server\logs
* Testing: \\test-server\logs  
* Production: \\prod-server\logs

* =================================================================
* DERIVED VARIABLES (computed from above)
* =================================================================

* Make paths available as locals for easier use in scripts
local log_path_local "$log_path_local"
local log_path_network "$log_path_network"

* =================================================================
* PATH VALIDATION
* =================================================================

* Check if local path exists, create if it doesn't
capture mkdir "`log_path_local'"

* Display environment configuration
display as text "=== STATA ENVIRONMENT LOADED ==="
display as text "Local log path: `log_path_local'"
display as text "Network log path: `log_path_network'"
display as text "================================="

* =================================================================
* ADDITIONAL CONFIGURATION OPTIONS
* =================================================================

* Log file retention settings (optional)
* global log_retention_days 30

* Log file compression settings (optional)  
* global compress_logs 1

* Email notification settings (optional)
* global notify_email "admin@company.com"

* Debug mode (set to 1 to enable verbose logging)
global debug_mode 0

if $debug_mode == 1 {
    display as text "DEBUG: Environment variables loaded"
    display as text "DEBUG: log_path_local = `log_path_local'"
    display as text "DEBUG: log_path_network = `log_path_network'"
}