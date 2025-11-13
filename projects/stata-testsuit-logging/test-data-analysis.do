* Stata Test Suite - Data Analysis Log Test
* This .do file tests log generation with actual data analysis operations
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
local script_name "test-data-analysis"

* Create log filename
local log_filename "log-`hostname'-`date_formatted'-`time_formatted'-`script_name'.log"

* Use log path from environment (local path)
local full_log_path "`log_path_local'/`log_filename'"

* Display test information
display as text "=================================================="
display as text "Stata Test Suite - Data Analysis Test"
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

* Log header
display as text "=== DATA ANALYSIS TEST LOG START ==="
display as text "Log started: `c(current_date)' `c(current_time)'"
display as text "Hostname: `hostname'"
display as text "Test type: Data Analysis Operations"
display as text "=================================="

* Create sample dataset for analysis
clear
set obs 1000
set seed 12345

* Generate test variables
generate id = _n
generate group = mod(_n-1, 4) + 1
generate treatment = runiform() > 0.5
generate age = round(rnormal(45, 15))
replace age = max(18, min(80, age))
generate income = round(exp(rnormal(10, 0.5)))
generate outcome = 50 + 10*treatment + 0.1*age + rnormal(0, 10)

* Add some missing values for realistic testing
replace age = . if runiform() < 0.05
replace income = . if runiform() < 0.03

* Label variables
label variable id "Participant ID"
label variable group "Study Group (1-4)"
label variable treatment "Treatment Assignment"
label variable age "Age in years"
label variable income "Annual Income"
label variable outcome "Primary Outcome Score"

label define treatment_lbl 0 "Control" 1 "Treatment"
label values treatment treatment_lbl

* Data description and summary
display as text ""
display as text "=== DATASET DESCRIPTION ==="
describe
display as text ""
display as text "=== SUMMARY STATISTICS ==="
summarize

* Missing data analysis
display as text ""
display as text "=== MISSING DATA ANALYSIS ==="
misstable summarize
misstable patterns

* Group analysis
display as text ""
display as text "=== GROUP ANALYSIS ==="
tabulate group treatment, missing
by group: summarize outcome age income

* Treatment effect analysis
display as text ""
display as text "=== TREATMENT EFFECT ANALYSIS ==="
ttest outcome, by(treatment)

* Regression analysis
display as text ""
display as text "=== REGRESSION ANALYSIS ==="
regress outcome treatment age income
estimates store model1

* Display model results
display as text ""
display as text "=== MODEL DIAGNOSTICS ==="
predict residuals, residuals
summarize residuals
histogram residuals, normal title("Residuals Distribution")

* Additional analysis by group
display as text ""
display as text "=== SUBGROUP ANALYSIS ==="
forvalues i = 1/4 {
    display as text "--- Group `i' Analysis ---"
    regress outcome treatment age income if group == `i'
}

* Create frequency tables
display as text ""
display as text "=== FREQUENCY ANALYSIS ==="
tabulate group
tabulate treatment
tabulate group treatment, chi2

* Export some results (to memory/display)
display as text ""
display as text "=== RESULTS SUMMARY ==="
display as text "Total observations: " _N
count if !missing(outcome, treatment, age, income)
display as text "Complete cases: " r(N)

quietly summarize outcome if treatment == 1
local mean_treat = r(mean)
quietly summarize outcome if treatment == 0  
local mean_control = r(mean)
local diff = `mean_treat' - `mean_control'

display as text "Mean outcome (Treatment): " %6.2f `mean_treat'
display as text "Mean outcome (Control): " %6.2f `mean_control'
display as text "Difference: " %6.2f `diff'

* Test completion
display as text ""
display as text "=== DATA ANALYSIS TEST COMPLETE ==="
display as text "All analysis operations completed successfully"
display as text "Log entry completed: `c(current_date)' `c(current_time)'"
display as text "=== DATA ANALYSIS TEST LOG END ==="

* Close log
log close

* Confirmation
display as text ""
display as text "=================================================="
display as text "Data Analysis test completed!"
display as text "Log file: `log_filename'"
display as text "Log saved to: `full_log_path'"
display as text "Test included: descriptive stats, regression, subgroup analysis"
display as text "=================================================="