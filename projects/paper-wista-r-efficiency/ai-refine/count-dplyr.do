/*==============================================================================
 * count_dplyr.do - Stata Implementation of R dplyr count function
 * 
 * Description: Replicates the count_dplyr R function that:
 * - Detects specific letters (e,g,k,p,r,u,v) in 'verk' variable
 * - Groups by 'jahr' (year) 
 * - Calculates proportions of each letter detection
 * - Returns results sorted by year
 * 
 * Requirements: Dataset must contain variables 'jahr' and 'verk'
 *==============================================================================*/

version 17
clear all
set more off

// Create timestamp for logging
local datetime = c(current_date) + " " + c(current_time)
local timestamp = subinstr("`datetime'", " ", "_", .)
local timestamp = subinstr("`timestamp'", ":", "", .)

// Get Stata version info
local stata_version = c(stata_version)
local se_version = c(SE)
local mp_version = c(MP)

// Create log filename with timestamp and version
local logname "count_dplyr_`timestamp'_stata`stata_version'"
if "`se_version'" == "1" local logname "`logname'_SE"
if "`mp_version'" == "1" local logname "`logname'_MP"

// Start logging with performance monitoring
log using "`logname'.log", replace text

// Display system information
display "=============================================================================="
display "Performance Benchmark: count_dplyr Stata Implementation"
display "=============================================================================="
display "Date/Time: `datetime'"
display "Stata Version: `stata_version'"
if "`se_version'" == "1" display "Edition: SE"
if "`mp_version'" == "1" display "Edition: MP"
display "System: " c(os) " " c(osdtl)
display "Processors: " c(processors)
display "Memory: " c(memory) " MB"
display "=============================================================================="

// Start performance timer (BEFORE dataset loading)
timer clear
timer on 1

// Store initial memory usage (before dataset loading)
quietly memory
local initial_memory = r(data_memory)
display "Initial memory usage (before dataset): `initial_memory' bytes"
display ""

//==============================================================================
// DATASET LOADING (INCLUDED IN RUNTIME MEASUREMENT)
//==============================================================================

// Load dataset - MODIFY THIS PATH AS NEEDED
local dataset_path "PATH_TO_DATASET"  // *** USER: Replace with actual dataset path ***

display "Loading dataset from: `dataset_path'"
use "`dataset_path'", clear

// Verify required variables exist
local required_vars "jahr verk"
foreach var of local required_vars {
    capture confirm variable `var'
    if _rc != 0 {
        display as error "Error: Required variable '`var'' not found in dataset"
        exit 111
    }
}

display "Dataset loaded successfully. Observations: " _N
display "Required variables confirmed: `required_vars'"

// Store memory usage after dataset loading
quietly memory
local post_load_memory = r(data_memory)
local load_memory_diff = `post_load_memory' - `initial_memory'
display "Memory after dataset loading: `post_load_memory' bytes (diff: +`load_memory_diff' bytes)"
display ""

//==============================================================================
// MAIN FUNCTION: count_dplyr equivalent
//==============================================================================

// Store total number of observations at start
local nrow_df = _N
display "Total observations in dataset: `nrow_df'"

// Keep only required variables (equivalent to select(jahr, verk))
keep jahr verk

// Create indicator variables for letter detection (equivalent to mutate with str_detect)
display "Creating letter detection variables..."
gen byte e = regexm(verk, "e")
gen byte g = regexm(verk, "g") 
gen byte k = regexm(verk, "k")
gen byte p = regexm(verk, "p")
gen byte r = regexm(verk, "r")
gen byte u = regexm(verk, "u")
gen byte v = regexm(verk, "v")

// Calculate proportions by year (equivalent to group_by + summarize)
display "Calculating proportions by year..."

// Create temporary dataset for results
preserve
collapse (mean) e g k p r u v, by(jahr)

// Sort by year (equivalent to arrange)
sort jahr

// Display results
display ""
display "Results (proportions by year):"
display "=============================================================================="
list jahr e g k p r u v, separator(5) abbreviate(12)

restore

//==============================================================================
// PERFORMANCE LOGGING
//==============================================================================

// Stop timer and get performance metrics
timer off 1
quietly timer list 1
local runtime = r(t1)

// Get final memory usage
quietly memory
local final_memory = r(data_memory)
local memory_diff = `final_memory' - `initial_memory'

// Get CPU information if available
if c(processors) > 0 {
    local cpu_info = "CPUs: " + string(c(processors))
}
else {
    local cpu_info = "CPU info not available"
}

// Log performance results
display ""
display "=============================================================================="
display "PERFORMANCE METRICS"
display "=============================================================================="
display "Total runtime (including dataset loading): " %9.3f `runtime' " seconds"
display "Initial memory (before dataset): " %12.0fc `initial_memory' " bytes"
display "Memory after dataset loading: " %12.0fc `post_load_memory' " bytes"
display "Dataset loading memory impact: " %12.0fc `load_memory_diff' " bytes"
display "Final memory: " %12.0fc `final_memory' " bytes" 
display "Total memory difference: " %12.0fc `memory_diff' " bytes"
display "`cpu_info'"
display "Observations processed: " %12.0fc `nrow_df'
display "Observations per second: " %12.1f (`nrow_df'/`runtime')
display "=============================================================================="

// Close log
log close

// Display completion message
display ""
display "Analysis completed successfully!"
display "Log file saved as: `logname'.log"
display "Runtime: " %6.3f `runtime' " seconds"

/*==============================================================================
 * USAGE INSTRUCTIONS:
 * 
 * 1. Edit the dataset_path local macro at the top of the script:
 *    local dataset_path "your/path/to/dataset.dta"
 * 2. Ensure your dataset contains required variables: 'jahr' and 'verk'
 * 3. Run: do count-dplyr.do
 * 4. Check the generated log file for detailed performance metrics
 * 
 * The log file will be named with timestamp and Stata version, e.g.:
 * count_dplyr_01Dec2024_143052_stata17_SE.log
 * 
 * Note: The script will automatically verify that required variables exist
 * and will exit with an error message if any are missing.
 *==============================================================================*/