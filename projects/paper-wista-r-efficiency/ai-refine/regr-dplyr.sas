/*==============================================================================
 * regr-dplyr.sas - SAS Implementation of R dplyr regression function
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

/* Clear log and output */
dm 'log; clear; output; clear;';

/* Set system options for performance monitoring */
options fullstimer mprint mlogic symbolgen;

/* Create timestamp for logging */
%let datetime = %sysfunc(datetime());
%let timestamp = %sysfunc(putn(&datetime., datetime20.), $char20.);
%let timestamp = %sysfunc(compress(&timestamp., :));
%let timestamp = %sysfunc(tranwrd(&timestamp., %str( ), _));

/* Get SAS version info */
%let sas_version = &sysvlong4.;
%let sas_site = &syssiteid.;

/* Create log filename with timestamp and version */
%let logname = regr_dplyr_&timestamp._sas&sas_version.;

/* Start logging to external file */
proc printto log="&logname..log" new;
run;

/* Display system information */
%put ==============================================================================;
%put Performance Benchmark: regr_dplyr SAS Implementation;
%put ==============================================================================;
%put Date/Time: %sysfunc(datetime(), datetime20.);
%put SAS Version: &sas_version.;
%put Site ID: &sas_site.;
%put System: &sysscp. &sysscpl.;
%put User: &sysuserid.;
%put Memory Available: %sysfunc(getoption(memsize));
%put ==============================================================================;

/* Start performance timer (BEFORE dataset loading) */
%let start_time = %sysfunc(datetime());

/* Get initial memory statistics */
%let initial_memory = %sysfunc(getoption(memsize));
%put Initial memory available: &initial_memory.;
%put ;

/*==============================================================================
 DATASET LOADING (INCLUDED IN RUNTIME MEASUREMENT)
==============================================================================*/

/* Load dataset - MODIFY THIS PATH AS NEEDED */
%let dataset_path = PATH_TO_DATASET; /* *** USER: Replace with actual dataset path *** */

%put Loading dataset from: &dataset_path.;

/* Check if dataset exists */
%if %sysfunc(exist(&dataset_path.)) = 0 %then %do;
    %put ERROR: Dataset &dataset_path. does not exist;
    %abort cancel;
%end;

/* Load the dataset */
data work.analysis_data;
    set &dataset_path.;
run;

/* Verify required variables exist */
proc contents data=work.analysis_data out=work.vars_check(keep=name) noprint;
run;

%let required_vars = VERK JAHR K_K65270 K_K65823 K_C15018 K_EF20 K_K65172 URS_WE_TP_STICHTAG URS_RT_GRUPPEN_KENNZ;

%macro check_vars;
    %let missing_vars = ;
    %let var_count = %sysfunc(countw(&required_vars.));
    
    %do i = 1 %to &var_count.;
        %let var = %scan(&required_vars., &i.);
        %let var_exists = 0;
        
        data _null_;
            set work.vars_check;
            if upcase(name) = "&var." then do;
                call symputx('var_exists', 1);
                stop;
            end;
        run;
        
        %if &var_exists. = 0 %then %let missing_vars = &missing_vars. &var.;
    %end;
    
    %if &missing_vars. ne %then %do;
        %put ERROR: Required variables not found: &missing_vars.;
        %abort cancel;
    %end;
%mend;

%check_vars;

/* Get initial dataset information */
proc sql noprint;
    select count(*) into :initial_obs from work.analysis_data;
quit;

%put Dataset loaded successfully. Observations: &initial_obs.;
%put Required variables confirmed: &required_vars.;

/* Get memory usage after dataset loading */
%let post_load_time = %sysfunc(datetime());
%let load_time = %sysevalf(&post_load_time. - &start_time.);
%put Dataset loading time: %sysfunc(putn(&load_time., 8.3)) seconds;
%put ;

/*==============================================================================
 DATA PREPARATION - equivalent to R filter and select operations
==============================================================================*/

%put Initial observations: &initial_obs.;

/* Filter: keep only observations with both "k" and "u" in verk */
%put Filtering data (equivalent to filter(str_detect(verk, 'k') & str_detect(verk, 'u')))...;

data work.filtered_data;
    set work.analysis_data;
    where index(upcase(verk), 'K') > 0 and index(upcase(verk), 'U') > 0;
    
    /* Keep only required variables (equivalent to select()) */
    keep jahr k_k65270 k_k65823 k_c15018 k_ef20 k_k65172 
         urs_we_tp_stichtag urs_rt_gruppen_kennz;
run;

proc sql noprint;
    select count(*) into :filtered_obs from work.filtered_data;
quit;

%let dropped_obs = %eval(&initial_obs. - &filtered_obs.);
%put Observations after filtering: &filtered_obs. (dropped: &dropped_obs.);

/*==============================================================================
 VARIABLE CREATION - equivalent to R mutate operations
==============================================================================*/

%put Creating derived variables...;

data work.with_dummies;
    set work.filtered_data;
    
    /* Create vl_dummy: Positive loss carryforward indicator */
    /* R: vl_dummy = ifelse(k_k65270 > 0 & !is.na(k_k65270), 1, 0) */
    if k_k65270 > 0 and not missing(k_k65270) then vl_dummy = 1;
    else vl_dummy = 0;
    
    /* Create ifats_dummy: International activity indicator */  
    /* R: ifats_dummy = ifelse(urs_rt_gruppen_kennz %in% c(3,6), 1, 0) */
    if urs_rt_gruppen_kennz in (3, 6) then ifats_dummy = 1;
    else ifats_dummy = 0;
    
    /* Ensure all variables are numeric (equivalent to as.numeric) */
    /* SAS handles this automatically for most cases */
    
    /* Label variables for clarity */
    label vl_dummy = "Positive loss carryforward indicator"
          ifats_dummy = "International activity indicator (auslandskontrolliert)";
run;

/*==============================================================================
 FINAL VARIABLE SELECTION FOR REGRESSION
==============================================================================*/

/* Keep only variables needed for regression (equivalent to final select()) */
data work.regression_data;
    set work.with_dummies;
    keep vl_dummy jahr k_k65823 k_c15018 k_k65172 ifats_dummy urs_we_tp_stichtag;
run;

/* Display summary statistics before regression */
%put ;
%put Summary statistics before regression:;
%put ==============================================================================;

proc means data=work.regression_data n mean std min max nmiss;
    title "Summary Statistics Before Regression";
run;

/* Check for missing values */
%put ;
%put Missing value check:;
%put ==============================================================================;

proc freq data=work.regression_data;
    tables _all_ / missing nocum;
    title "Missing Value Check";
run;

/*==============================================================================
 LOGISTIC REGRESSION - equivalent to R glm(..., family = binomial)
==============================================================================*/

%put ;
%put Running logistic regression...;
%put R equivalent: glm('vl_dummy ~ .', data = ., family = binomial);
%put ==============================================================================;

/* Run logistic regression (equivalent to R's glm with binomial family) */
proc logistic data=work.regression_data descending;
    model vl_dummy = jahr k_k65823 k_c15018 k_k65172 ifats_dummy urs_we_tp_stichtag;
    title "Logistic Regression: Positive Loss Carryforward Prediction";
    title2 "Equivalent to R: glm(vl_dummy ~ ., family = binomial)";
    
    /* Store model fit statistics */
    ods output ModelInfo=work.model_info
               FitStatistics=work.fit_stats
               ParameterEstimates=work.parameter_est
               OddsRatios=work.odds_ratios;
run;

/* Display odds ratios for easier interpretation */
proc print data=work.odds_ratios;
    title "Odds Ratios";
run;

/* Display model classification table */
proc logistic data=work.regression_data descending;
    model vl_dummy = jahr k_k65823 k_c15018 k_k65172 ifats_dummy urs_we_tp_stichtag;
    output out=work.predicted predicted=p_hat;
    title "Model Classification and Predicted Values";
run;

/*==============================================================================
 PERFORMANCE LOGGING
==============================================================================*/

/* Stop timer and calculate performance metrics */
%let end_time = %sysfunc(datetime());
%let total_runtime = %sysevalf(&end_time. - &start_time.);

/* Get final dataset information */
proc sql noprint;
    select count(*) into :final_observations from work.regression_data;
quit;

%let obs_per_second = %sysevalf(&final_observations. / &total_runtime.);

/* Get memory information (approximate) */
data _null_;
    call symputx('current_memsize', getoption('memsize'));
    call symputx('current_memused', getoption('memused'));
run;

/* Extract model statistics */
data _null_;
    set work.fit_stats;
    if criterion = 'AIC (smaller is better)' then call symputx('aic_value', withoutcovariates);
    if criterion = '-2 Log L' then call symputx('neg2logL', withoutcovariates);
run;

/* Log performance results */
%put ;
%put ==============================================================================;
%put PERFORMANCE METRICS;
%put ==============================================================================;
%put Total runtime (including dataset loading): %sysfunc(putn(&total_runtime., 8.3)) seconds;
%put Dataset loading time: %sysfunc(putn(&load_time., 8.3)) seconds;
%put Analysis time: %sysfunc(putn(%sysevalf(&total_runtime. - &load_time.), 8.3)) seconds;
%put Available memory: &current_memsize.;
%put Memory used: &current_memused.;
%put Initial observations: &initial_obs.;
%put Filtered observations: &filtered_obs.;
%put Final observations: &final_observations.;
%put Observations per second: %sysfunc(putn(&obs_per_second., 12.1)) obs/sec;
%put ==============================================================================;
%put MODEL METRICS;
%put ==============================================================================;
%put AIC: &aic_value.;
%put -2 Log Likelihood: &neg2logL.;
%put SAS Version: &sas_version.;
%put ==============================================================================;

/* Close external log */
proc printto;
run;

/* Display completion message */
%put ;
%put Regression analysis completed successfully!;
%put Log file saved as: &logname..log;
%put Runtime: %sysfunc(putn(&total_runtime., 8.3)) seconds;
%put Final model: Logistic regression with &final_observations. observations;

/* Clean up temporary datasets */
proc datasets library=work nolist;
    delete analysis_data vars_check filtered_data with_dummies regression_data 
           model_info fit_stats parameter_est odds_ratios predicted;
quit;

/*==============================================================================
 USAGE INSTRUCTIONS:
 
 1. Edit the dataset_path macro variable at the top of the script:
    %let dataset_path = your.dataset.name;
    or
    %let dataset_path = "/path/to/your/dataset.sas7bdat";
 2. Ensure your dataset contains required variables:
    - verk, jahr, k_k65270, k_k65823, k_c15018, k_ef20, k_k65172
    - urs_we_tp_stichtag, urs_rt_gruppen_kennz
 3. Run the entire SAS program
 4. Check the generated log file for detailed performance and model metrics
 
 The log file will be named with timestamp and SAS version, e.g.:
 regr_dplyr_01DEC24_143052_sasXXX.log
 
 Note: The script will automatically verify that all required variables exist
 and will abort with an error message if any are missing.
 
 Model interpretation:
 - Dependent variable: vl_dummy (positive loss carryforward indicator)
 - Independent variables: jahr, k_k65823, k_c15018, k_k65172, 
                         ifats_dummy, urs_we_tp_stichtag
 - Method: Logistic regression (equivalent to R's glm with binomial family)
==============================================================================*/