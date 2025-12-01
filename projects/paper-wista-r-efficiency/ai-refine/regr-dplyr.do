/*==============================================================================
 * regr-dplyr.do - Stata Implementation of R dplyr regression function
 * 
 * Description: Replicates the regr_dplyr R function that:
 * - Filters data for entries with both "k" and "u" in 'verk' variable
 * - Selects specific financial and organizational variables
 * - Creates dummy variables for loss carryforward and international activity
 * - Runs logistic regression predicting positive loss carryforward
 * 
 * Requirements: Dataset must contain variables:
 * - verk, jahr, k_k65270, k_k65823, k_c15018, k_ef20, k_k65172
 * - urs_we_tp_stichtag, urs_rt_gruppen_kennz
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
local logname "regr_dplyr_`timestamp'_stata`stata_version'"
if "`se_version'" == "1" local logname "`logname'_SE"
if "`mp_version'" == "1" local logname "`logname'_MP"

// Start logging with performance monitoring
log using "`logname'.log", replace text

// Display system information
display "=============================================================================="
display "Performance Benchmark: regr_dplyr Stata Implementation"
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
local required_vars "verk jahr k_k65270 k_k65823 k_c15018 k_ef20 k_k65172 urs_we_tp_stichtag urs_rt_gruppen_kennz"
foreach var of local required_vars {
    capture confirm variable `var'
    if _rc != 0 {
        display as error "Error: Required variable '`var'' not found in dataset"
        exit 111
    }
}

display "Dataset loaded successfully. Observations: " _N
display "Required variables confirmed: " wordcount("`required_vars'") " variables"

// Store memory usage after dataset loading
quietly memory
local post_load_memory = r(data_memory)
local load_memory_diff = `post_load_memory' - `initial_memory'
display "Memory after dataset loading: `post_load_memory' bytes (diff: +`load_memory_diff' bytes)"
display ""

//==============================================================================
// DATA PREPARATION - equivalent to R filter and select operations
//==============================================================================

// Store initial number of observations
local initial_obs = _N
display "Initial observations: `initial_obs'"

// Filter: keep only observations with both "k" and "u" in verk
display "Filtering data (equivalent to filter(str_detect(verk, 'k') & str_detect(verk, 'u')))..."
keep if regexm(verk, "k") & regexm(verk, "u")

local filtered_obs = _N
local dropped_obs = `initial_obs' - `filtered_obs'
display "Observations after filtering: `filtered_obs' (dropped: `dropped_obs')"

// Select only required variables (equivalent to select())
display "Selecting variables..."
keep ///
    jahr ///
    k_k65270 ///    /* Verlustvorträge */
    k_k65823 ///    /* Gesamtbetrag der Einkünfte */
    k_c15018 ///    /* Summe der Umsätze/Löhne/Gehälter */
    k_ef20 ///      /* WZ Generierung */
    k_k65172 ///    /* Spende */
    urs_we_tp_stichtag /// /* Tätige Personen */
    urs_rt_gruppen_kennz   /* Statuskennzeichen */

//==============================================================================
// VARIABLE CREATION - equivalent to R mutate operations
//==============================================================================

display "Creating derived variables..."

// Create vl_dummy: Positive loss carryforward indicator
// R: vl_dummy = ifelse(k_k65270 > 0 & !is.na(k_k65270), 1, 0)
gen byte vl_dummy = (k_k65270 > 0 & !missing(k_k65270))
label variable vl_dummy "Positive loss carryforward indicator"

// Create ifats_dummy: International activity indicator  
// R: ifats_dummy = ifelse(urs_rt_gruppen_kennz %in% c(3,6), 1, 0)
gen byte ifats_dummy = inlist(urs_rt_gruppen_kennz, 3, 6)
label variable ifats_dummy "International activity indicator (auslandskontrolliert)"

// Ensure all numeric variables are properly typed (equivalent to as.numeric)
// Note: In Stata, this is typically handled automatically, but we can confirm types
foreach var of varlist jahr k_k65270 k_k65823 k_c15018 k_ef20 k_k65172 urs_we_tp_stichtag urs_rt_gruppen_kennz {
    capture confirm numeric variable `var'
    if _rc == 0 {
        display "  `var': numeric type confirmed"
    }
    else {
        display "  `var': WARNING - not numeric type"
    }
}

//==============================================================================
// FINAL VARIABLE SELECTION FOR REGRESSION
//==============================================================================

// Keep only variables needed for regression (equivalent to final select())
keep vl_dummy jahr k_k65823 k_c15018 k_k65172 ifats_dummy urs_we_tp_stichtag

// Display summary statistics before regression
display ""
display "Summary statistics before regression:"
display "=============================================================================="
summarize

// Check for missing values
display ""
display "Missing value check:"
display "=============================================================================="
misstable summarize

//==============================================================================
// LOGISTIC REGRESSION - equivalent to R glm(..., family = binomial)
//==============================================================================

display ""
display "Running logistic regression..."
display "R equivalent: glm('vl_dummy ~ .', data = ., family = binomial)"
display "=============================================================================="

// Run logistic regression (equivalent to R's glm with binomial family)
logit vl_dummy jahr k_k65823 k_c15018 k_k65172 ifats_dummy urs_we_tp_stichtag

// Display detailed results
display ""
display "Detailed regression results:"
display "=============================================================================="

// Show odds ratios for easier interpretation
logit, or

// Display model fit statistics
estat ic
estat classification

// Display marginal effects
margins, dydx(*)

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

// Get model statistics
local observations = e(N)
local converged = e(converged)
local ll = e(ll)
local chi2 = e(chi2)
local p_value = e(p)

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
display "Initial observations: " %12.0fc `initial_obs'
display "Filtered observations: " %12.0fc `filtered_obs'
display "Final observations: " %12.0fc `observations'
display "Observations per second: " %12.1f (`observations'/`runtime')
display "=============================================================================="
display "MODEL METRICS"
display "=============================================================================="
display "Converged: " ("`converged'" == "1" ? "Yes" : "No")
display "Log likelihood: " %12.3f `ll'
display "Chi-squared: " %12.3f `chi2'
display "P-value: " %12.6f `p_value'
display "Pseudo R-squared: " %8.4f `e(r2_p)'
display "=============================================================================="

// Close log
log close

// Display completion message
display ""
display "Regression analysis completed successfully!"
display "Log file saved as: `logname'.log"
display "Runtime: " %6.3f `runtime' " seconds"
display "Final model: Logistic regression with " `observations' " observations"

/*==============================================================================
 * USAGE INSTRUCTIONS:
 * 
 * 1. Edit the dataset_path local macro at the top of the script:
 *    local dataset_path "your/path/to/dataset.dta"
 * 2. Ensure your dataset contains required variables:
 *    - verk, jahr, k_k65270, k_k65823, k_c15018, k_ef20, k_k65172
 *    - urs_we_tp_stichtag, urs_rt_gruppen_kennz
 * 3. Run: do regr-dplyr.do
 * 4. Check the generated log file for detailed performance and model metrics
 * 
 * The log file will be named with timestamp and Stata version, e.g.:
 * regr_dplyr_01Dec2024_143052_stata17_SE.log
 * 
 * Note: The script will automatically verify that all required variables exist
 * and will exit with an error message if any are missing.
 * 
 * Model interpretation:
 * - Dependent variable: vl_dummy (positive loss carryforward indicator)
 * - Independent variables: jahr, k_k65823, k_c15018, k_k65172, 
 *                         ifats_dummy, urs_we_tp_stichtag
 * - Method: Logistic regression (equivalent to R's glm with binomial family)
 *==============================================================================*/