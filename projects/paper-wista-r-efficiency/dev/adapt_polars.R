

fallzahl_polars <- function(df){
  nrow_df <- df$height
  
  df$select(c("jahr", "verk"))$
    with_columns(
      pl$col("verk")$str$contains("e")$alias("e"),
      pl$col("verk")$str$contains("g")$alias("g"),
      pl$col("verk")$str$contains("k")$alias("k"),
      pl$col("verk")$str$contains("p")$alias("p"),
      pl$col("verk")$str$contains("r")$alias("r"),
      pl$col("verk")$str$contains("u")$alias("u"),
      pl$col("verk")$str$contains("v")$alias("v")
    )$
    group_by("jahr")$
    agg(
      pl$col("e")$sum() / nrow_df,
      pl$col("g")$sum() / nrow_df,
      pl$col("k")$sum() / nrow_df,
      pl$col("p")$sum() / nrow_df,
      pl$col("r")$sum() / nrow_df,
      pl$col("u")$sum() / nrow_df,
      pl$col("v")$sum() / nrow_df
    )$
    sort("jahr")
}

## Test cases ----

fallzahl_polars_parquet <- function(obs = obs_default, cores = max_cores, lazy = FALSE){
  input_path = here(sprintf("data/btp_obs%d/data.parquet", obs))
  # Set polars thread count
  pl$set_polars_options(table_width = NULL, n_threads = cores)
  
  if(lazy) {
    df <- pl$scan_parquet(input_path)
  } else {
    df <- pl$read_parquet(input_path)
  }
  
  nrow_df <- if(lazy) df$select(pl$len())$collect()$item() else df$height
  
  res <- df$select(c("jahr", "verk"))$
    with_columns(
      pl$col("verk")$str$contains("e")$alias("e"),
      pl$col("verk")$str$contains("g")$alias("g"),
      pl$col("verk")$str$contains("k")$alias("k"),
      pl$col("verk")$str$contains("p")$alias("p"),
      pl$col("verk")$str$contains("r")$alias("r"),
      pl$col("verk")$str$contains("u")$alias("u"),
      pl$col("verk")$str$contains("v")$alias("v")
    )$
    group_by("jahr")$
    agg(
      pl$col("e")$sum() / nrow_df,
      pl$col("g")$sum() / nrow_df,
      pl$col("k")$sum() / nrow_df,
      pl$col("p")$sum() / nrow_df,
      pl$col("r")$sum() / nrow_df,
      pl$col("u")$sum() / nrow_df,
      pl$col("v")$sum() / nrow_df
    )$
    sort("jahr")
  
  if(lazy) {
    res <- res$collect()
  }
  
  return(res)
}
