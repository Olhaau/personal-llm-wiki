* Stata Test Suite - Log Append Generation
* This .do file runs for 5 hours using log append method
* Author: Stata Test Suite
* Created: `c(current_date)'

* Load environment variables
include "stata-env.do"

* Clear any existing programs and data
clear all
set more off

* Get system information for log naming
local hostname = "`c(hostname)'"
local current_date = "`c(current_date)'"
local current_time = "`c(current_time)'"

* Parse date and time for filename format
local date_parts : subinstr local current_date " " "", all
local date_formatted = subinstr("`date_parts'", "/", "", .)
local date_formatted = subinstr("`date_formatted'", "-", "", .)

* Format time to HHMM
local time_parts = subinstr("`current_time'", ":", "", .)
local time_formatted = substr("`time_parts'", 1, 4)

* Set script name for this test
local script_name "test-log-append-generation"

* Create log filename with format: log-<hostname>-<YYYYMMDD-HHMM>-<script-name>.log
local log_filename "log-`hostname'-`date_formatted'-`time_formatted'-`script_name'.log"

* Use log path from environment (local path)
local full_log_path "`log_path_local'/`log_filename'"

* Display information about log creation
display as text "=================================================="
display as text "Stata Test Suite - Log Append Generation"
display as text "=================================================="
display as text "Script: `script_name'.do"
display as text "Log file: `log_filename'"
display as text "Local path: `log_path_local'"
display as text "Network path: `log_path_network'"
display as text "Full log path: `full_log_path'"
display as text "=================================================="

* Start logging
capture log close
log using "`full_log_path'", replace text

* Log initial start message
local start_time = "`c(current_date)' `c(current_time)'"
display as text "`start_time' log generation started - will run for 5 hours"

* Run for 5 hours (300 minutes = 18000 seconds)
* Write a log entry every minute for 5 hours (300 entries total)
local total_minutes = 300
local current_minute = 1

display as text "Starting 5-hour logging cycle..."

while `current_minute' <= `total_minutes' {
    * Sleep for 1 minute (60000 milliseconds)
    sleep 60000
    
    * Get current timestamp
    local current_time = "`c(current_date)' `c(current_time)'"
    
    * Write timestamped log entry
    display as text "`current_time' log successfully updated (minute `current_minute'/`total_minutes')"
    
    * Show progress every 30 minutes
    if mod(`current_minute', 30) == 0 {
        local hours_completed = `current_minute' / 60
        display as text "=== Progress: `hours_completed' hours completed ==="
    }
    
    * Increment counter
    local current_minute = `current_minute' + 1
}

* Final completion message
local end_time = "`c(current_date)' `c(current_time)'"
display as text "`end_time' log generation completed - 5 hours finished"

* Close log
log close

* Confirmation message
display as text ""
display as text "=================================================="
display as text "5-Hour Log generation completed!"
display as text "Started: `start_time'"
display as text "Ended: `end_time'"
display as text "Total entries: 300 (one per minute for 5 hours)"
display as text "Log saved to: `full_log_path'"
display as text "=================================================="