/*==============================================================================
 * count-dplyr.sas - SAS Implementation of R dplyr count function
 * 
 * Description: Replicates the count_dplyr R function that:
 * - Detects specific letters (e,g,k,p,r,u,v) in 'verk' variable
 * - Groups by 'jahr' (year) 
 * - Calculates proportions of each letter detection
 * - Returns results sorted by year
 * 
 * Requirements: Dataset must contain variables 'jahr' and 'verk'
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
%let logname = count_dplyr_&timestamp._sas&sas_version.;

/* Start logging to external file */
proc printto log="&logname..log" new;
run;

/* Display system information */
%put ==============================================================================;
%put Performance Benchmark: count_dplyr SAS Implementation;
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

data _null_;
    set work.vars_check;
    if upcase(name) = 'JAHR' then call symputx('jahr_exists', 1);
    if upcase(name) = 'VERK' then call symputx('verk_exists', 1);
run;

%if &jahr_exists. ne 1 %then %do;
    %put ERROR: Required variable JAHR not found in dataset;
    %abort cancel;
%end;

%if &verk_exists. ne 1 %then %do;
    %put ERROR: Required variable VERK not found in dataset;
    %abort cancel;
%end;

/* Get dataset information */
proc sql noprint;
    select count(*) into :nrow_df from work.analysis_data;
quit;

%put Dataset loaded successfully. Observations: &nrow_df.;
%put Required variables confirmed: jahr, verk;

/* Get memory usage after dataset loading */
%let post_load_time = %sysfunc(datetime());
%let load_time = %sysevalf(&post_load_time. - &start_time.);
%put Dataset loading time: %sysfunc(putn(&load_time., 8.3)) seconds;
%put ;

/*==============================================================================
 MAIN FUNCTION: count_dplyr equivalent
==============================================================================*/

%put Total observations in dataset: &nrow_df.;

/* Keep only required variables (equivalent to select(jahr, verk)) */
data work.selected_data;
    set work.analysis_data(keep=jahr verk);
run;

/* Create indicator variables for letter detection (equivalent to mutate with str_detect) */
%put Creating letter detection variables...;

data work.with_indicators;
    set work.selected_data;
    
    /* Create byte indicators for each letter (equivalent to str_detect) */
    e = (index(upcase(verk), 'E') > 0);
    g = (index(upcase(verk), 'G') > 0);
    k = (index(upcase(verk), 'K') > 0);
    p = (index(upcase(verk), 'P') > 0);
    r = (index(upcase(verk), 'R') > 0);
    u = (index(upcase(verk), 'U') > 0);
    v = (index(upcase(verk), 'V') > 0);
    
    /* Convert to numeric for averaging */
    if e then e_num = 1; else e_num = 0;
    if g then g_num = 1; else g_num = 0;
    if k then k_num = 1; else k_num = 0;
    if p then p_num = 1; else p_num = 0;
    if r then r_num = 1; else r_num = 0;
    if u then u_num = 1; else u_num = 0;
    if v then v_num = 1; else v_num = 0;
run;

/* Calculate proportions by year (equivalent to group_by + summarize) */
%put Calculating proportions by year...;

proc sql;
    create table work.results as
    select 
        jahr,
        mean(e_num) as e format=8.6,
        mean(g_num) as g format=8.6,
        mean(k_num) as k format=8.6,
        mean(p_num) as p format=8.6,
        mean(r_num) as r format=8.6,
        mean(u_num) as u format=8.6,
        mean(v_num) as v format=8.6
    from work.with_indicators
    group by jahr
    order by jahr;
quit;

/* Display results */
%put ;
%put Results (proportions by year):;
%put ==============================================================================;

proc print data=work.results noobs;
    title "Letter Detection Proportions by Year";
    title2 "Equivalent to R: count_dplyr(df) function";
run;

/*==============================================================================
 PERFORMANCE LOGGING
==============================================================================*/

/* Stop timer and calculate performance metrics */
%let end_time = %sysfunc(datetime());
%let total_runtime = %sysevalf(&end_time. - &start_time.);

/* Get SAS system performance information */
proc sql noprint;
    select nobs into :final_obs from dictionary.tables 
    where libname='WORK' and memname='RESULTS';
quit;

%let obs_per_second = %sysevalf(&nrow_df. / &total_runtime.);

/* Get memory information (approximate) */
data _null_;
    call symputx('current_memsize', getoption('memsize'));
    call symputx('current_memused', getoption('memused'));
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
%put Observations processed: &nrow_df.;
%put Final result rows: &final_obs.;
%put Observations per second: %sysfunc(putn(&obs_per_second., 12.1)) obs/sec;
%put SAS Version: &sas_version.;
%put ==============================================================================;

/* Close external log */
proc printto;
run;

/* Display completion message */
%put ;
%put Analysis completed successfully!;
%put Log file saved as: &logname..log;
%put Runtime: %sysfunc(putn(&total_runtime., 8.3)) seconds;

/* Clean up temporary datasets */
proc datasets library=work nolist;
    delete analysis_data selected_data with_indicators vars_check;
quit;

/*==============================================================================
 USAGE INSTRUCTIONS:
 
 1. Edit the dataset_path macro variable at the top of the script:
    %let dataset_path = your.dataset.name;
    or
    %let dataset_path = "/path/to/your/dataset.sas7bdat";
 2. Ensure your dataset contains required variables: 'jahr' and 'verk'
 3. Run the entire SAS program
 4. Check the generated log file for detailed performance metrics
 
 The log file will be named with timestamp and SAS version, e.g.:
 count_dplyr_01DEC24_143052_sasXXX.log
 
 Note: The script will automatically verify that required variables exist
 and will abort with an error message if any are missing.
==============================================================================*/