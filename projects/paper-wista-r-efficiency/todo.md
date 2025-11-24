## OPEN

### Human in the loop

- get DSF write upsample and test performance...
- cores vs performance
- some tools, different data source (parquet, ...) and performance, easy case aggregated table (line of code -> proxy for simplicity, runtime, RAM usage, storage size, cores ...)
- need to mention the versions
- SAS and Stata Benchmarks from csv, dta?

### AI Agent

- use @btp_2013-2019_on-site_mdr-prod.pdf and the excel in Datensatzbeschreibung https://www.forschungsdatenzentrum.de/de/10-21242-73511-2019-00-05-2-1-0 (fetch them to resources/raw) to create a syntetic btp dataset. create a R-function `synth_btp(obs = 100, select="all")` that has all variables that are present in the btp with obs observations (set minimum needed obs to respect the statistical structure). Label each variable with a description. Create the data so that it respects the available statistical and structural information. Save the function to projects/paper-wista-r-effiency/dev/experiment