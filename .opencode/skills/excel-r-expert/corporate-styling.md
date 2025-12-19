# Corporate Styling and German Formatting

## German Statistical Report Standards

### Destatis Corporate Design

The Federal Statistical Office (Destatis) follows specific design guidelines:

#### Color Scheme
- **Primary Blue**: #004B76 (Destatis dark blue)
- **Secondary Blue**: #0080C8 (Destatis light blue)  
- **Background**: #E6F2F8 (Light blue background)
- **Headers**: #D9D9D9 (Light grey)
- **Alternating rows**: #F8F8F8 (Very light grey)

#### Typography
- **Font Family**: Arial (required for accessibility)
- **Title**: 16pt, bold, white text on blue background
- **Headers**: 11pt, bold, black text on grey background
- **Data**: 10pt, regular, black text

#### Number Formatting
German number formatting uses:
- **Thousands separator**: Space (` `)
- **Decimal separator**: Comma (`,`)
- **Format code**: `"# ### ##0,00"`

Example: `1 234 567,89` instead of `1,234,567.89`

### BMF Corporate Design

Federal Ministry of Finance styling:

#### Color Scheme
- **Primary**: #1f3a93 (BMF blue)
- **Secondary**: #2e5bba (Light BMF blue)
- **Background**: #f0f3ff (Very light blue)
- **Headers**: #e6ebff (Light blue headers)

### Implementation Examples

#### Basic Destatis Styling
```r
create_destatis_styles <- function() {
  list(
    title = create_cell_style(
      font_name = "Arial",
      font_size = 16,
      text_bold = TRUE,
      font_color = wb_color(hex = "FFFFFF"),
      fill_color = wb_color(hex = "004B76"),  # Destatis blue
      horizontal = "center",
      vertical = "center"
    ),
    
    header = create_cell_style(
      font_name = "Arial",
      font_size = 11,
      text_bold = TRUE,
      font_color = wb_color(hex = "000000"),
      fill_color = wb_color(hex = "D9D9D9"),  # Light grey
      border = "TopBottomLeftRight",
      border_color = wb_color(hex = "808080")
    ),
    
    data = create_cell_style(
      font_name = "Arial",
      font_size = 10,
      border = "TopBottomLeftRight",
      border_color = wb_color(hex = "D9D9D9"),
      num_fmt = "# ### ##0,00"  # German number format
    )
  )
}
```

#### Advanced Corporate Report
```r
create_corporate_report <- function(data, filename, organization = "destatis") {
  # Load appropriate color scheme
  colors <- switch(organization,
    "destatis" = list(
      primary = "004B76",
      secondary = "0080C8",
      background = "E6F2F8",
      header = "D9D9D9"
    ),
    "bmf" = list(
      primary = "1f3a93", 
      secondary = "2e5bba",
      background = "f0f3ff",
      header = "e6ebff"
    )
  )
  
  wb <- wb_workbook()
  wb$add_worksheet("Report")
  
  # Set document properties for corporate compliance
  wb$set_properties(
    title = "Statistischer Bericht",
    subject = if (organization == "destatis") "Statistisches Bundesamt" else "Bundesministerium der Finanzen",
    creator = if (organization == "destatis") "Statistisches Bundesamt" else "BMF",
    category = "Amtliche Statistik"
  )
  
  # Corporate title with proper formatting
  title_text <- switch(organization,
    "destatis" = "Statistischer Bericht",
    "bmf" = "Bericht des Bundesministeriums der Finanzen"
  )
  
  wb$add_data(sheet = "Report", x = title_text, start_col = 1, start_row = 1)
  
  # Apply corporate styling
  title_style <- create_cell_style(
    font_name = "Arial",
    font_size = 16,
    text_bold = TRUE,
    font_color = wb_color(hex = "FFFFFF"),
    fill_color = wb_color(hex = colors$primary),
    horizontal = "center"
  )
  
  # Merge title across all columns
  n_cols <- ncol(data)
  end_col <- LETTERS[n_cols]
  wb$merge_cells(sheet = "Report", dims = paste0("A1:", end_col, "1"))
  wb$add_cell_style(sheet = "Report", dims = paste0("A1:", end_col, "1"), style = title_style)
  
  # Add reporting period
  period <- paste("Berichtszeitraum:", format(Sys.Date(), "%B %Y"))
  wb$add_data(sheet = "Report", x = period, start_col = 1, start_row = 2)
  
  # Add data starting from row 4
  wb$add_data(sheet = "Report", x = data, start_col = 1, start_row = 4)
  
  # Apply German formatting to all numeric columns
  for (col in 1:n_cols) {
    if (is.numeric(data[[col]])) {
      range <- paste0(LETTERS[col], "5:", LETTERS[col], nrow(data) + 4)
      wb$add_numfmt(sheet = "Report", dims = range, numfmt = "# ### ##0,00")
    }
  }
  
  # Style headers with corporate colors
  header_style <- create_cell_style(
    font_name = "Arial",
    font_size = 11,
    text_bold = TRUE,
    font_color = wb_color(hex = "000000"),
    fill_color = wb_color(hex = colors$header),
    border = "TopBottomLeftRight"
  )
  
  for (col in 1:n_cols) {
    cell <- paste0(LETTERS[col], "4")
    wb$add_cell_style(sheet = "Report", dims = cell, style = header_style)
  }
  
  # Apply alternating row colors
  for (row in 1:nrow(data)) {
    for (col in 1:n_cols) {
      actual_row <- row + 4
      cell <- paste0(LETTERS[col], actual_row)
      
      if (row %% 2 == 0) {
        alt_style <- create_cell_style(
          font_name = "Arial",
          font_size = 10,
          fill_color = wb_color(hex = "F8F8F8"),  # Light grey for alternating rows
          border = "TopBottomLeftRight",
          border_color = wb_color(hex = "D9D9D9"),
          num_fmt = "# ### ##0,00"
        )
        wb$add_cell_style(sheet = "Report", dims = cell, style = alt_style)
      } else {
        data_style <- create_cell_style(
          font_name = "Arial",
          font_size = 10,
          border = "TopBottomLeftRight",
          border_color = wb_color(hex = "D9D9D9"),
          num_fmt = "# ### ##0,00"
        )
        wb$add_cell_style(sheet = "Report", dims = cell, style = data_style)
      }
    }
  }
  
  # Set appropriate row heights
  wb$set_row_heights(sheet = "Report", rows = 1, heights = 25)  # Title row
  wb$set_row_heights(sheet = "Report", rows = 4, heights = 20)  # Header row
  
  # Auto-size columns for optimal display
  for (col in 1:n_cols) {
    wb$set_col_widths(sheet = "Report", cols = col, widths = "auto")
  }
  
  # Freeze panes for navigation
  wb$freeze_pane(sheet = "Report", first_active_row = 5, first_active_col = 2)
  
  wb$save(filename)
  return(filename)
}
```

## Configuration Files

### Destatis Style Configuration
The configuration file approach allows consistent styling:

```yaml
# destatis-style.yaml
font:
  family: "Arial"
  size: 10

colors:
  primary: "004B76"      # Destatis blue
  secondary: "0080C8"    # Light blue
  background: "E6F2F8"   # Very light blue
  header: "D9D9D9"       # Light grey
  border: "808080"       # Dark grey
  alt_row: "F8F8F8"      # Alternating row color

heading:
  font_size: 16
  font_bold: true
  font_color: "FFFFFF"
  fill_color: "004B76"
  row_height: 25

column_header:
  font_size: 11
  font_bold: true
  font_color: "000000"
  fill_color: "D9D9D9"
  border: true

data_cell:
  font_size: 10
  number_format: "# ### ##0,00"
  border_color: "D9D9D9"

alternating_rows:
  enabled: true
  even_color: "F8F8F8"

freeze_panes:
  rows: 2
  cols: 1
```

### Loading Configuration
```r
apply_config_styling <- function(wb, sheet_name, data, config_file) {
  config <- yaml::read_yaml(config_file)
  
  # Create styles from configuration
  styles <- list(
    title = create_cell_style(
      font_name = config$font$family,
      font_size = config$heading$font_size,
      text_bold = config$heading$font_bold,
      font_color = wb_color(hex = config$heading$font_color),
      fill_color = wb_color(hex = config$heading$fill_color)
    ),
    
    header = create_cell_style(
      font_name = config$font$family,
      font_size = config$column_header$font_size,
      text_bold = config$column_header$font_bold,
      font_color = wb_color(hex = config$column_header$font_color),
      fill_color = wb_color(hex = config$column_header$fill_color),
      border = if (config$column_header$border) "TopBottomLeftRight" else "none"
    )
  )
  
  # Apply configuration-based formatting
  # ... implementation details
}
```

## Multi-Language Support

### German Text Elements
Standard German phrases for statistical reports:

```r
german_labels <- list(
  title = "Statistischer Bericht",
  period = "Berichtszeitraum",
  table = "Tabelle",
  page = "Seite", 
  index = "Inhaltsverzeichnis",
  back_to_index = "← Zurück zum Inhaltsverzeichnis",
  data_source = "Datenquelle",
  methodology = "Erläuterungen zur Methodik",
  notes = "Anmerkungen",
  total = "Insgesamt",
  average = "Durchschnitt",
  median = "Median"
)

add_german_labels <- function(wb, sheet_name, data) {
  # Add standard German labels to the report
  wb$add_data(sheet = sheet_name, x = german_labels$period, start_col = 1, start_row = 2)
  # ... additional label implementations
}
```

## Print Layout Optimization

### Page Setup for Professional Printing
```r
setup_print_layout <- function(wb, sheet_name) {
  # Set page orientation and margins
  wb$page_setup(
    sheet = sheet_name,
    orientation = "landscape",  # Better for wide tables
    paper_size = "A4",
    left_margin = 2.5,
    right_margin = 2.5,
    top_margin = 2.5,
    bottom_margin = 2.5
  )
  
  # Set headers and footers
  wb$set_header_footer(
    sheet = sheet_name,
    header = c("", "Statistischer Bericht", ""),
    footer = c("Statistisches Bundesamt", "", "&P")  # Page number
  )
  
  # Configure print options
  wb$sheet_view(
    sheet = sheet_name,
    show_grid_lines = FALSE,  # Clean look for printing
    show_row_col_headers = FALSE
  )
}
```

This corporate styling approach ensures that Excel outputs meet professional German statistical reporting standards while maintaining flexibility for different organizations and use cases.