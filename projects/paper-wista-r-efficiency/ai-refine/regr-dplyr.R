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
      , .keep="unused"
      
    )  |> #select(-key) |> 
    
    mutate(across(where(is.numeric), as.numeric))
  
  mod <- da_clean |> 

    select(
      vl_dummy, jahr, 
      k_k65823, k_c15018, k_k65172, 
      ifats_dummy, urs_we_tp_stichtag #,wz
    ) %>%
    
    # Modell
    {glm("vl_dummy ~ .", data = ., family = binomial)}
  
  mod
}