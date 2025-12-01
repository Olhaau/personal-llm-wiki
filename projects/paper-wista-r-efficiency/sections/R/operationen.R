

# Benchmark Functions

max_cores <- parallel::detectCores()

## helper ----

count_dplyr <- function(df){
  nrow_df <- nrow(df)
  df |> select(jahr, verk) |> 
    
    mutate(
      e = str_detect(verk, "e"), 
      g = str_detect(verk, "g"), 
      k = str_detect(verk, "k"), 
      p = str_detect(verk, "p"), 
      r = str_detect(verk, "r"), 
      u = str_detect(verk, "u"), 
      v = str_detect(verk, "v")) |>
    
    group_by(jahr) |>
    
    summarize(across(where(is.logical), ~ sum(.)/nrow_df)) |>
    
    arrange(jahr)
}

regr_dplyr <- function(da, lazy = FALSE){
  
  da_clean <- da |> filter(str_detect(verk, "k") & str_detect(verk, "u")) |>
    select(
      jahr,
      k_k65270,  # Verlustvorträge
      k_k65823,  # Gesamtbetrag der Einkünfte 
      k_c15018,  # Summe der Umsätze/Löhne/Gehälter 
      k_ef20,    # WZ Generierung
      k_k65172,  # Spende 
      
      urs_we_tp_stichtag,  # Tätige Personen
      urs_rt_gruppen_kennz # Statuskennzeichen, = 3/6 heißt "auslandskontrolliert" 
    ) 
  
  if(lazy){da_clean <- compute(da_clean)}
  
  da_clean <- da_clean |>
    
    mutate(
      
      # Positiver Verlustvortrag vorhanden?
      vl_dummy    = ifelse(k_k65270 > 0 & !is.na(k_k65270) , 1, 0), 
      
      # International taetig?
      ifats_dummy = ifelse(urs_rt_gruppen_kennz %in% c(3,6), 1, 0),
      
      # Wirtschaftszweig
      # key = as.numeric(substr(k_ef20,1,2)), 
      # wz = case_when(
      #   key %in% 1:3 ~ "A",
      #   key %in% 5:9 ~ "B",
      #   key %in% 10:33 ~ "C",
      #   key %in% 35 ~ "D",
      #   key %in% 36:39 ~ "E",
      #   key %in% 41:43 ~ "F",
      #   key %in% 45:47 ~ "G",
      #   key %in% 49:53 ~ "H",
      #   key %in% 55:56 ~ "I",
      #   key %in% 58:63 ~ "J",
      #   key %in% 64:66 ~ "K",
      #   key %in% 68    ~ "L",
      #   key %in% 69:75 ~ "M",
      #   key %in% 77:82 ~ "N",
      #   key %in% 84    ~ "O",
      #   key %in% 85    ~ "P",
      #   key %in% 86:88 ~ "Q",
      #   key %in% 90:93 ~ "R",
      #   key %in% 99    ~ "U",
      #   .default = NA)
      
      , .keep="unused"
      
    )  |> #select(-key) |> 
    
    mutate(across(where(is.numeric), as.numeric))
  
  mod <- da_clean |> 
    # Shift der erklaerenden Variablen um ein Jahr
    
    
    #left_join(
    #  mutate(da_clean, jahr = jahr + 1),
    #  by = c("ID", "jahr"), suffix = c("", "_t1")
    #) |>
    select(
      vl_dummy, jahr, 
      k_k65823, k_c15018, k_k65172, 
      ifats_dummy, urs_we_tp_stichtag #,wz
    ) %>%
    
    # Modell
    {glm("vl_dummy ~ .", data = ., family = binomial)}
  
  mod
}

regr_dt <- function(da, lazy = FALSE) {
  
  # filter rows
  da_clean <- da[
    str_detect(verk, "k") & str_detect(verk, "u"),
    .(
      jahr,
      k_k65270,   # Verlustvorträge
      k_k65823,   # Gesamtbetrag der Einkünfte 
      k_c15018,   # Summe der Umsätze/Löhne/Gehälter 
      k_ef20,     # WZ Generierung
      k_k65172,   # Spende 
      urs_we_tp_stichtag,  # Tätige Personen
      urs_rt_gruppen_kennz # Statuskennzeichen (= 3/6 -> auslandskontrolliert)
    )
  ]
  
  # (optional) lazy evaluation equivalent - not directly applicable in data.table
  if (lazy) {
    message("Note: 'lazy = TRUE' ignored in data.table version (no deferred execution).")
  }
  
  # mutate equivalents
  da_clean[, vl_dummy := fifelse(k_k65270 > 0 & !is.na(k_k65270), 1, 0)]
  da_clean[, ifats_dummy := fifelse(urs_rt_gruppen_kennz %in% c(3, 6), 1, 0)]
  
  # convert numeric columns to numeric (ensuring type consistency)
  num_cols <- names(da_clean)[sapply(da_clean, is.numeric)]
  da_clean[, (num_cols) := lapply(.SD, as.numeric), .SDcols = num_cols]
  
  mod <- glm("vl_dummy ~ .", data = da_clean, family = binomial)
  return(mod)
}

data_size <- function(data_path){
  if(fs::is_dir(data_path)){size <- sum(fs::dir_info(data_path, recurse=TRUE)$size)
  } else {
      size <- fs::file_info(data_path)$size
  }
  size
}

here <- function(path,...){
  file.path("/mnt/FDZ-DATA/fdz-intern/workdir/06_it/btp-benchmark", path,...)
}

benchmark <- function(ops, obs, iters, cores = NULL){
  bm <- select(ops, -fns, -contains("_control"))
  data_path <- here(sprintf("data/%s_obs%d/%s", statistic, obs, ops$input))

  op <- ops$fns[[1]]

  
  
  
  
  bm$obs   <- obs
  bm$stat  <- statistic
  bm$datpath <- data_path
  bm$datsize <- data_size(data_path)
  bm$starttime <- Sys.time()
  bm$iter <- iters
  
  tryCatch(
    {
      mem <- bench_memory({
        sys_time <- system_time({
          res <- op(data_path)
        })
      })
      bm$status <- "success"
      bm$mem_alloc <- mem$mem_alloc
      bm$real_time <- sys_time[['real']]
      bm$proc_time <- sys_time[['process']]
      bm$memory <- mem$memory
      bm$result <- list(res)
      message(sprintf("bm: success for operation %s, obs=%i, iter=%i",ops$fns_name, obs, iters))
      bm
    },
    error = function(e) {
      message("Error: ", e$message)
      bm$status <- e$message
      bm$mem_alloc <- NA
      bm$proc_time <- NA
      bm$real_time <- NA
      bm$result <- NA
      bm
    }
    ,
    finally = {
    }
  )
  
}


benchmark_mp <- function(ops, obs, iters, cores = max_cores){
  bm <- select(ops, -fns, -contains("_control"))
  data_path <- here(sprintf("data/%s_obs%d/%s", statistic, obs, ops$input))
  
  op <- ops$fns[[1]]
  
  bm$obs   <- obs
  bm$stat  <- statistic
  bm$datpath <- data_path
  bm$datsize <- data_size(data_path)
  bm$starttime <- Sys.time()
  bm$iter <- iters
  bm$cores <- cores
  
  tryCatch(
    {
      mem <- bench_memory({
        sys_time <- system_time({
          res <- op(data_path, cores = cores)
        })
      })
      bm$status <- "success"
      bm$mem_alloc <- mem$mem_alloc
      bm$real_time <- sys_time[['real']]
      bm$proc_time <- sys_time[['process']]
      bm$memory <- mem$memory
      bm$result <- list(res)
      message(sprintf("bm: success for operation %s, obs=%i, iter=%i",ops$fns_name, obs, iters))
      bm
    },
    error = function(e) {
      message("Error: ", e$message)
      bm$status <- e$message
      bm$mem_alloc <- NA
      bm$proc_time <- NA
      bm$real_time <- NA
      bm$result <- NA
      bm
    }
    ,
    finally = {
    }
  )
  
}



## Test cases ----

regr_dplyr_csv <- function(input_path, cores = max_cores){
  df <- read_csv(input_path, show_col_types = FALSE, num_threads=cores)
  mod <- regr_dplyr(df)
  summary(mod)
}

regr_vroom_csv <- function(input_path, cores = max_cores){
  df <- vroom(input_path, show_col_types = FALSE, num_threads=cores)
  mod <- regr_dplyr(df)
  summary(mod)
}

regr_dplyr_csv_sel <- function(input_path, cores = max_cores){
  df <- read_csv(input_path, show_col_types = FALSE,num_threads=cores, col_select= 
                   c("jahr", "verk",
                 "k_k65270",  # Verlustvorträge
                 "k_k65823",  # Gesamtbetrag der Einkünfte 
                 "k_c15018",  # Summe der Umsätze/Löhne/Gehälter 
                 "k_ef20",    # WZ Generierung
                 "k_k65172",  # Spende 
                 
                 "urs_we_tp_stichtag",  # Tätige Personen
                 "urs_rt_gruppen_kennz" # Statuskennzeichen, = 3/6 heißt "auslandskontrolliert" 
  ) 
                   
                   )
  mod <- regr_dplyr(df)
  summary(mod)
}

count_base_csv <- function(input_path){
    df <- read.csv(input_path)
  
  
  nrow_df <- nrow(df)
  
  # keep only needed columns
  tmp <- df[c("jahr", "verk")]
  
  # create logical columns
  tmp$e <- grepl("e", tmp$verk)
  tmp$g <- grepl("g", tmp$verk)
  tmp$k <- grepl("k", tmp$verk)
  tmp$p <- grepl("p", tmp$verk)
  tmp$r <- grepl("r", tmp$verk)
  tmp$u <- grepl("u", tmp$verk)
  tmp$v <- grepl("v", tmp$verk)
  
  # aggregate by jahr
  res <- aggregate(
    cbind(e, g, k, p, r, u, v) ~ jahr,
    data = tmp,
    FUN = function(x) sum(x) / nrow_df
  )
  
  # sort by jahr
  res <- res[order(res$jahr), ]
  
  res
}

count_readr_csv <- function(input_path,cores=max_cores, col_select = FALSE){
  if(col_select){
    df <- read_csv(input_path, col_select = c("jahr", "verk"), show_col_types = FALSE, num_threads =cores)
  }else{df <- read_csv(input_path, show_col_types = FALSE, num_threads =cores)}
  count_dplyr(df)
}

count_vroom_csv <- function(input_path, cores= max_cores,col_select = FALSE){
  if(col_select){
    df <- vroom(input_path, col_select = c("jahr", "verk"), show_col_types = FALSE, num_threads=max_cores)
  }else{df <- vroom(input_path, show_col_types = FALSE)}
  count_dplyr(df)
}

count_readr_csv_sel <- function(input_path, cores=max_cores){
  count_readr_csv(input_path, col_select = TRUE, cores=cores)
}

count_arrow_parquet <- function(input_path, cores = max_cores, lazy = FALSE, col_select = FALSE){
  set_cpu_count(cores)
  
  if(col_select){
    df <- read_parquet(input_path, as_data_frame = !lazy, col_select = c("jahr", "verk"))
  } else {
    df <- read_parquet(input_path, as_data_frame = !lazy)
  }

  nrow_df <- nrow(df)
  res <- df |> count_dplyr()
  if(lazy){res <- collect(res)}
  return(res)
}

count_arrow_parquet_lazy <- function(input_path, cores = max_cores, col_select = FALSE){
  count_arrow_parquet(input_path, cores = cores, lazy = TRUE, col_select = col_select)
}

count_arrow_parquet_sel <- function(input_path, cores = max_cores, lazy = FALSE){
  count_arrow_parquet(input_path, cores = cores, lazy = lazy, col_select = TRUE)
}

regr_arrow_parquet_jahr <- function(input_path, cores = max_cores){
  set_cpu_count(cores)
  
  df <- open_dataset(input_path, partitioning = "jahr")
  res <- df |> regr_dplyr(lazy=TRUE) |>
    summary()
}

count_arrow_parquet_jahr <- function(input_path, cores = max_cores){
  
  set_cpu_count(cores)
  
  df <- open_dataset(input_path, partitioning = "jahr")
  res <- df |> count_dplyr() |> collect()
  
  return(res)
}

count_arrow_parquet_folder <- function(input_path, cores = max_cores){
  set_cpu_count(cores)
  
  df <- open_dataset(input_path)
  res <- df |> count_dplyr() |> collect()
  
  return(res)
}

count_arrow_csv <- function(input_path, cores = max_cores, lazy = FALSE, compress = FALSE){
  set_cpu_count(cores)
  
  compress <- ifelse(compress, ".gz", "")
  
  df <- read_csv_arrow(input_path, as_data_frame = !lazy)
  res <- df |> count_dplyr()
  if(lazy){res <- collect(res)}
  return(res)
}

regr_datatable_csv <- function(input_path, cores = max_cores){
  
  setDTthreads(cores)
  df <- fread(input_path)
  
  mod <- regr_dt(df)
  summary(mod)
}

count_datatable_csv <- function(input_path, cores = max_cores, col_select = FALSE){

  setDTthreads(cores)
  if(col_select){
    df <- fread(input_path, select = c("jahr", "verk"))
  } else {
    df <- fread(input_path)
  }
  

  
  
  
  nrow_df <- nrow(df)
  
  
  res <-df[, 
           c("e", "g", "k", "p", "r", "u", "v") :=
             lapply(c("e", "g", "k", "p", "r", "u", "v"),\(x) str_detect(verk, x))
  ][, lapply(.SD, \(x) sum(x) / nrow_df),
    by = jahr, .SDcols = c("e", "g", "k", "p", "r", "u", "v")]
  
  return(res)
} 

count_datatable_csv_sel <- function(input_path, cores = max_cores){
  count_datatable_csv(input_path, cores = cores, col_select = TRUE)
}

count_datatable_csv_folder <- function(input_folder, cores = max_cores){
  
  setDTthreads(cores)
  l <- lapply(list.files(input_folder, recursive = TRUE, pattern = "*\\.csv", full.names=TRUE), fread)
  df <- rbindlist(l)
  nrow_df <- nrow(df)
  
  res <-df[, 
           c("e", "g", "k", "p", "r", "u", "v") :=
             lapply(c("e", "g", "k", "p", "r", "u", "v"),\(x) str_detect(df$verk, x))
  ][, lapply(.SD, \(x) sum(x) / nrow_df),
    by = df$jahr, .SDcols = c("e", "g", "k", "p", "r", "u", "v")]
  
  return(res)
} 

# see code: limitation
count_duckdb_parquet <- function(input_path, cores = max_cores){
  
  con <- dbConnect(duckdb(), dbdir = ":memory:", config = list(threads = cores))
  
  # read directly from Parquet (lazy / queryable)
  df <- tbl(con, input_path)
  
  # total number of rows (computed inside DuckDB)
  nrow_df <- df %>% summarise(n = n()) %>% collect() %>% pull(n)
  
  # query entirely within DuckDB
  res <- df %>%
    select(jahr, verk) %>%
    mutate(
      e = str_detect(verk, "e"),
      g = str_detect(verk, "g"),
      k = str_detect(verk, "k"),
      p = str_detect(verk, "p"),
      r = str_detect(verk, "r"),
      u = str_detect(verk, "u"),
      v = str_detect(verk, "v")
    ) %>%
    group_by(jahr) %>%
    # That error comes from the fact that DuckDB's dplyr interface (tbl_duckdb) does not fully support where() predicates (like where(is.logical)) inside across() - it only works in local (in-memory) dplyr
    summarise(
      e = sum(as.integer(e), na.rm = TRUE) / nrow_df,
      g = sum(as.integer(g), na.rm = TRUE) / nrow_df,
      k = sum(as.integer(k), na.rm = TRUE) / nrow_df,
      p = sum(as.integer(p), na.rm = TRUE) / nrow_df,
      r = sum(as.integer(r), na.rm = TRUE) / nrow_df,
      u = sum(as.integer(u), na.rm = TRUE) / nrow_df,
      v = sum(as.integer(v), na.rm = TRUE) / nrow_df
    ) %>%
    arrange(jahr) %>%
    collect()
  return(res)
}  

# difficulty to limit cores
# difficulty to get syntax right, https://ddotta.github.io/cookbook-rpolars/first_steps.html
# difficulty to get it lazy
# polars does not know relative paths, e.g. ~
count_polars_parquet <- function(input_path, lazy = FALSE) {
  #Sys.setenv(POLARS_MAX_THREADS = cores)

  # Set number of threads Polars should use
  #pl$set_n_threads(cores)
  
  # Read dataset
  if (lazy) {
    df <- pl$scan_parquet(input_path)  # lazy
  } else {
    df <- pl$read_parquet(input_path)  # eager
  }
  
  # total number of rows
  if (lazy) {
    nrow_df <- df |> collect() |> nrow() 
  } else {
    nrow_df <- df |> nrow()
  }
  
  res <- df |> count_dplyr()
  if(lazy){res <- res |> collect()}
  return("hidden")
  
}
