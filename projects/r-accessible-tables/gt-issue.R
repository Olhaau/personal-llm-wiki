library(gt)

df <- data.frame(
  `married_low income` = c(30, 2),
  `married_high income` = c(30, 4),
  `single_low income` = c(20, 1),
  `single_high income` = c(20, 2),
  col = c("age", "hsize"),
  check.names = F
)

# Fixed: Define the separator character (was undefined in original script)
table <- gt(df, rowname_col = "col") |> tab_spanner_delim(delim = "_")

html <- table |> as_raw_html(inline_css = F)

writeLines(html, "gt-issue.html")
