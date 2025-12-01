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