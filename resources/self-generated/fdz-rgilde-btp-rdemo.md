---
title: "Effizientes Programmieren mit R"
subtitle: Anhand des Business Tax Panel (BTP)
author: "Oliver Hauke (StBA - Referat C31)"
date: "08.07.2025"
output:
  html_document:
    toc: yes
    toc_float:
      collapsed: no
      smooth_scroll: no
    code_fold: show
    keep_md: yes
  pdf_document:
    toc: yes
---



## 1 Vorbereitung

### 1.1 Pakete laden


``` r
library(arrow)     # Effizienz, R-nativ
library(duckdb)    # Effizienz, SQL-artig
library(dplyr)     # Datenverarbeitung
library(tidyr)     # Datenverarbeitung
library(ggplot2)   # Plots
library(lobstr)    # Speichermessung
  
arrow::set_cpu_count(16) 
```

### 1.2 Verbindung zu Daten herstellen


``` r
system.time({
  da <- open_dataset("/posit_share/home/hauke-o/nest/daten/btp/parquet_schema")
}) 
obj_size(da)
```

```
#>    user  system elapsed 
#>   0.303   0.063   0.391 
#> 263.67 kB
```

Es wird nur ein Pointer auf das Dateisystem erzeugt, sodass weder Zeit noch RAM beansprucht wird.


``` r
system.time({
  da |> 
    dim() |>
    print()
})
```

```
#> [1] 174469051      2266
#>    user  system elapsed 
#>  21.753   6.088  27.965
```

Erst Ansichten der Daten erzeugen Last. Dazu zählt auch die Ansicht der Datendimension.

## 2 Datenübersicht

- Datenansichten (filter+select) können in Sekunden betrachtet werden. 
- Die Operationen werden nicht direkt ausgeführt (Lazy-Computation). 
- Erst der Aufruf `collect()` stößt die Berechnung an und liefert das Ergebnis.


``` r
system.time({
  da |> 
    select(3 + 1:100) |>
    head(100) |>
    collect() |>
    str() 
})
```

```
#> tibble [100 × 100] (S3: tbl_df/tbl/data.frame)
#>  $ g_ef4  : int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_fef14: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_fef17: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_fef19: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_fef20: chr [1:100] NA NA NA NA ...
#>  $ g_fef21: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_fef25: logi [1:100] NA NA NA NA NA NA ...
#>  $ g_fef26: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_fef27: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_fef28: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2110: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2114: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2116: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2117: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2119: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2121: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2122: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2126: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2127: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2128: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2131: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2132: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2133: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2134: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2135: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2137: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2141: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2142: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2143: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2144: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2145: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2146: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2147: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2150: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2210: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2212: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2213: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2216: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2218: logi [1:100] NA NA NA NA NA NA ...
#>  $ g_k2220: logi [1:100] NA NA NA NA NA NA ...
#>  $ g_k2223: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2224: logi [1:100] NA NA NA NA NA NA ...
#>  $ g_k2225: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2227: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2228: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2229: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2230: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2232: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2233: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2236: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2237: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2240: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2241: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2243: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2244: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2245: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2247: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2248: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2249: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2251: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2253: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2257: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2260: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2261: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2262: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2263: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2271: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2272: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2273: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2274: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2275: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2277: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2278: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2279: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2281: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2282: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2284: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2286: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2287: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2288: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k2289: logi [1:100] NA NA NA NA NA NA ...
#>  $ g_k6510: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6511: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6514: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6515: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6516: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6517: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6520: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6522: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6524: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6526: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6528: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6541: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6543: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6546: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6550: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6551: logi [1:100] NA NA NA NA NA NA ...
#>  $ g_k6552: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>  $ g_k6553: int [1:100] NA NA NA NA NA NA NA NA NA NA ...
#>   [list output truncated]
#>    user  system elapsed 
#>   4.210   1.723   1.165
```

### 2.1 Fallzahlen pro Statistik und Jahr

- Es lässt sich die `dplyr`-Syntax verwenden (die an natürliche Sprache angelehnt ist).
- Wie hier "Gruppiere (`group_by`) nach Statistik und Jahr und zähle (`count`) die Fälle pro Gruppe"
- `pivot_wider` formatiert den Output (im long Format) in die bekannte Tabelle des Metadatenreports (MDR)



``` r
system.time({
  fallzahlen_stat <- da |> 
    group_by(stat, Jahr) |>
    count() |> 
    ungroup() |>
    collect()
})

pivot_wider(fallzahlen_stat, names_from = stat, values_from = n)
```

```
#>    user  system elapsed 
#>  20.540   0.228  11.443 
#> # A tibble: 7 × 8
#>    Jahr       e       g       k       p       r       u       v
#>   <int>   <int>   <int>   <int>   <int>   <int>   <int>   <int>
#> 1  2013 3703982 3633451 1210838 1205110 3474431 3243538 6435280
#> 2  2014 3720318 3714176 1236129 1220521 3550775 3240221 6446620
#> 3  2015 4230871 3819938 1264717 1234537 3634643 3255537 6535948
#> 4  2016 4581982 3887556 1293431 1247699 3674354 3266429 6550960
#> 5  2017 5685661 3981853 1316520 1220067 3708949 3266806 6664535
#> 6  2018 6310028 4050674 1350837 1284121 3736550 3279136 6831036
#> 7  2019 6501292 4099690 1388679 1294898 3723169 3288306 6972252
```

{ggplot2} bietet in `R` viele schöne Visualisierungen für den MDR.


``` r
fallzahlen_stat |>
  mutate(Jahr = factor(Jahr), Fallzahl = n / 1e6) |>
  ggplot(aes(x = Jahr, y = Fallzahl, fill = stat)) + 
  geom_bar(stat="identity") +
  ylab("Fallzahl (in Mio.)") +
  ggtitle("BTP - Fallzahlen nach Jahr und Statistik")
```

<img src="fdz-rgilde-btp-rdemo_files/figure-html/ov-n_cases-plot-1.png" style="display: block; margin: auto;" />

### 2.2 Numerische Kennzahlen

Eine weitere Anwendung erzeugt eine Reihe populärer Kennzahlen (Mittelwert, Median, ...) für alle numerischen Variablen in einer Subgruppe (hier: nur EF-Variablen der Personengesellschaftsstatistik).



``` r
system.time({
  overview <- function(da){
  
  select(da, where(is.numeric)) |>
  
  summarize(
      across(.fns= ~ sum(!is.na(.x)), .names = "{.col}-obs"),
      across(.fns= ~ sum( is.na(.x)), .names = "{.col}-nna"),
      across(.fns= ~ min(.x, na.rm = TRUE), .names = "{.col}-min"),
      across(.fns= ~ mean(.x, na.rm = TRUE), .names = "{.col}-mean"),
      across(.fns= ~ median(.x, na.rm = TRUE), .names = "{.col}-median"),
      across(.fns= ~ max(.x, na.rm = TRUE), .names = "{.col}-max"),
      across(.fns= ~ sd(.x, na.rm = TRUE), .names = "{.col}-sd")
      )
}

# Uebersicht ausrechnen
descr <- da |> 
  filter(stat == "p") |>           # Personengesellschaften
  select(starts_with("p_ef")) |>   # Nur ef-Variablen
  overview() |>
  collect()

})

# schoenere Darstellung
descr |>
  mutate(across(everything(), as.numeric)) |>
  pivot_longer(cols = everything(), names_to = "key", values_to = "value") |>
  separate(key, into = c("Variable", "metrik"), sep = "-") |>
  pivot_wider(names_from = metrik, values_from = value) |>
  slice(10:20)
```

```
#>    user  system elapsed 
#>  24.661   0.580   9.896 
#> # A tibble: 11 × 8
#>    Variable     obs     nna         min    mean      median        max        sd
#>    <chr>      <dbl>   <dbl>       <dbl>   <dbl>       <dbl>      <dbl>     <dbl>
#>  1 p_ef15   2265272 6441681           0 1.93e+0        3             5   1.60e+0
#>  2 p_ef16   8706953       0           1 1.20e+0        1             3   4.65e-1
#>  3 p_ef17    327919 8379034           2 6.18e+6  1078331.     31122019   8.67e+6
#>  4 p_ef18    325510 8381443     1012013 2.94e+7 31121982.     31122019   5.47e+6
#>  5 p_ef28   8706952       1           0 5.60e-3        0             1   7.46e-2
#>  6 p_ef29   8706953       0           1 7.06e+0        7.03         16   3.39e+0
#>  7 p_ef30   8706953       0        2014 2.02e+3     2018.         2023   2.14e+0
#>  8 p_ef32   8706953       0     1001000 7.38e+6  7268711.     16077055   3.38e+6
#>  9 p_ef33    399545 8307408    -3119240 4.41e+4     8110.     37782090   1.91e+5
#> 10 p_ef34   3840730 4866223 -3368741387 2.19e+5    11525.   8168898821   7.23e+6
#> 11 p_ef35     13860 8693093  -648222190 6.28e+6    79906.   6815308372   7.32e+7
```


## 3 Auswertung

### 3.1 Lorenzkurve (Verlustvorträge der Körperschaften)

- Berechung einer Lorenzkurve (`ineq:Lc`) der Verlustvorträge im Jahr 2019
- `Lc` ist nicht in {arrow} implementiert, aber {arrow} merkt smart, dass die Inputs klein sind und führt die Berechnung unbemerkt im Arbeitsspeicher aus.



``` r
system.time({
  var_lc <- da |> 
    filter(stat == "k", Jahr == 2019) |> # nur Koerperschaftsteuerstat. in 2019
    pull(k_k65270)                       # Verlustvortraege

  lc <-  ineq::Lc(var_lc)

  plot(lc)
})
```

```
#>    user  system elapsed 
#>   1.347   0.026   1.186
```

<img src="fdz-rgilde-btp-rdemo_files/figure-html/aus-lc-1.png" style="display: block; margin: auto;" />



### 3.2 Verknüpfung und Logit (Einflüsse auf positive Verlustvorträge)

- Abschließend eine exemplarische End-to-End Auswertung
- Ein Schätzmodell herangezogen, um Einflussfaktoren auf Verlustvorträge zu identifizieren.
- zunächst werden relevante Variablen der Körperschaftsstatistik mit dem URS verknüpft
- Dummys werden erzeugt und WZ's extrahiert
- Logit-Modell untersucht die Einflüsse auf positive Verlustvorträge


``` r
system.time({
  # Verknuepfung ----
  da_ku <- inner_join(
    
  # Variablen der Koerperschaftstatatistik
  da |> filter(stat == "k") |>
    select(
      ID, Jahr,
      k_k65270,  # Verlustvorträge
      k_k65823,  # Gesamtbetrag der Einkünfte
      k_c15018,  # Summe der Umsätze/Löhne/Gehälter
      k_ef20,    # für WZ
      k_k65172,  # Spende 
    ),

  # Variablen des Unternehmensregister
  da |> filter(stat == "u") |>
    select(ID, Jahr,
       urs_we_tp_stichtag,  # Tätige Personen
       urs_rt_gruppen_kennz # Statuskennzeichen, = 3/6 heißt "auslandskontrolliert"
    )
  )
  # Datenbereinigung ----
  da_cl <- da_ku |> collect() |> 
  
    mutate(
    
    # Positiver Verlustvortrag vorhanden?
    vl_dummy    = ifelse(k_k65270 > 0 & !is.na(k_k65270) , 1, 0),
    
    # International taetig?
    ifats_dummy = ifelse(urs_rt_gruppen_kennz %in% c(3,6), 1, 0),
    
    # Wirtschaftszweig
    key = as.numeric(substr(k_ef20,1,2)),
    wz = case_when(
      key %in% 1:3 ~ "A",
      key %in% 5:9 ~ "B",
      key %in% 10:33 ~ "C",
      key %in% 35 ~ "D",
      key %in% 36:39 ~ "E",
      key %in% 41:43 ~ "F",
      key %in% 45:47 ~ "G",
      key %in% 49:53 ~ "H",
      key %in% 55:56 ~ "I",
      key %in% 58:63 ~ "J",
      key %in% 64:66 ~ "K",
      key %in% 68    ~ "L",
      key %in% 69:75 ~ "M",
      key %in% 77:82 ~ "N",
      key %in% 84    ~ "O",
      key %in% 85    ~ "P",
      key %in% 86:88 ~ "Q",
      key %in% 90:93 ~ "R",
      key %in% 99    ~ "U",
      .default = NA)
    
    , .keep="unused"

  )  |> select(-key) |> 
    collect() |>
    mutate(across(where(is.numeric), as.numeric))
    

  # Logit ----
  mod <- da_cl %>%
    # Shift der erklaerenden Variablen um ein Jahr
    left_join(
      mutate(da_cl, Jahr = Jahr + 1),
      by = c("ID", "Jahr"), suffix = c("", "_t1")
    ) |>
    
    select(vl_dummy, Jahr, wz, contains("_t1"), -wz_t1, -vl_dummy_t1) %>%
    {glm("vl_dummy ~ .", data = ., family = binomial)}
})
summary(mod)
```

```
#>    user  system elapsed 
#>  84.825 305.862  16.749 
#> 
#> Call:
#> glm(formula = "vl_dummy ~ .", family = binomial, data = .)
#> 
#> Coefficients:
#>                         Estimate Std. Error z value Pr(>|z|)    
#> (Intercept)            7.077e+01  2.787e+00  25.396  < 2e-16 ***
#> Jahr                  -3.549e-02  1.382e-03 -25.681  < 2e-16 ***
#> wzD                   -3.689e-01  2.965e-02 -12.441  < 2e-16 ***
#> wzE                   -2.790e-01  2.626e-02 -10.623  < 2e-16 ***
#> wzF                   -1.129e-01  7.936e-03 -14.229  < 2e-16 ***
#> wzG                    7.684e-03  7.257e-03   1.059 0.289718    
#> wzH                   -5.308e-02  1.409e-02  -3.768 0.000164 ***
#> wzI                    4.306e-01  1.375e-02  31.303  < 2e-16 ***
#> wzJ                    2.622e-03  1.070e-02   0.245 0.806468    
#> wzK                   -2.327e-01  2.012e-02 -11.566  < 2e-16 ***
#> wzL                    4.850e-01  1.291e-02  37.575  < 2e-16 ***
#> wzM                   -2.028e-01  8.579e-03 -23.639  < 2e-16 ***
#> wzN                   -5.393e-02  1.127e-02  -4.785 1.71e-06 ***
#> wzP                    3.743e-01  2.737e-02  13.675  < 2e-16 ***
#> wzQ                   -7.446e-02  2.848e-02  -2.614 0.008947 ** 
#> wzR                    5.465e-01  1.864e-02  29.316  < 2e-16 ***
#> wzU                   -8.841e-01  5.438e-01  -1.626 0.103970    
#> k_k65823_t1           -9.556e-08  1.812e-09 -52.746  < 2e-16 ***
#> k_c15018_t1            4.283e-11  1.619e-11   2.646 0.008138 ** 
#> k_k65172_t1            8.668e-07  5.192e-08  16.697  < 2e-16 ***
#> urs_we_tp_stichtag_t1 -3.369e-05  6.893e-06  -4.887 1.02e-06 ***
#> ifats_dummy_t1         2.920e-01  1.252e-02  23.326  < 2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> (Dispersion parameter for binomial family taken to be 1)
#> 
#>     Null deviance: 1066800  on 868816  degrees of freedom
#> Residual deviance: 1049118  on 868795  degrees of freedom
#>   (3320918 observations deleted due to missingness)
#> AIC: 1049162
#> 
#> Number of Fisher Scoring iterations: 8
```
