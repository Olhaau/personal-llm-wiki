-- Add metadata page to DOCX output
-- This filter runs after charcount.lua and uses the same data

local function add_metadata_page(doc)
  -- Only add metadata page for DOCX format
  if FORMAT ~= "docx" then
    return doc
  end
  
  -- Read title.tex to extract metadata
  local title_file = io.open("title.tex", "r")
  if not title_file then
    return doc
  end
  
  local content = title_file:read("*all")
  title_file:close()
  
  -- Extract Schlüsselwörter
  local schluss_line = content:match("{\\bfseries Schlüsselwörter:}%s*([^}]+)}")
  local schlusselworter = {}
  if schluss_line then
    for keyword in schluss_line:gmatch("([^,]+)") do
      keyword = keyword:match("^%s*(.-)%s*$")
      table.insert(schlusselworter, keyword)
    end
  end
  
  -- Extract Keywords
  local key_line = content:match("{\\bfseries Keywords:}%s*([^}]+)}")
  local keywords = {}
  if key_line then
    for keyword in key_line:gmatch("([^%-%-]+)") do
      keyword = keyword:match("^%s*(.-)%s*$")
      if keyword ~= "" then
        table.insert(keywords, keyword)
      end
    end
  end
  
  -- Get metadata from Pandoc
  local title = pandoc.utils.stringify(doc.meta.title or "EFFIZIENTE AUSWERTUNG DES BUSINESS-TAX-PANELS MITHILFE VON R")
  local authors = pandoc.utils.stringify(doc.meta["author-short"] or "Oliver Hauke, Annette Kristiansen")
  local publication = pandoc.utils.stringify(doc.meta.publication or "WISTA")
  local publication_issue = pandoc.utils.stringify(doc.meta["publication-issue"] or "01/2026")
  local date = pandoc.utils.stringify(doc.meta.date or os.date("%Y-%m-%d"))
  
  -- Create metadata page content
  local metadata_blocks = {}
  
  -- Title
  table.insert(metadata_blocks, pandoc.Header(1, {pandoc.Str("Dokument-Metadaten")}))
  
  -- Metadata table
  table.insert(metadata_blocks, pandoc.Para({
    pandoc.Strong({pandoc.Str("Titel:")}),
    pandoc.Space(),
    pandoc.Str(title)
  }))
  table.insert(metadata_blocks, pandoc.Para({
    pandoc.Strong({pandoc.Str("Autoren:")}),
    pandoc.Space(),
    pandoc.Str(authors)
  }))
  table.insert(metadata_blocks, pandoc.Para({
    pandoc.Strong({pandoc.Str("Veröffentlichung:")}),
    pandoc.Space(),
    pandoc.Str(publication .. " " .. publication_issue)
  }))
  table.insert(metadata_blocks, pandoc.Para({
    pandoc.Strong({pandoc.Str("Erstellungsdatum:")}),
    pandoc.Space(),
    pandoc.Str(date)
  }))
  
  table.insert(metadata_blocks, pandoc.HorizontalRule())
  
  -- Schlüsselwörter and Keywords section as a two-column table
  table.insert(metadata_blocks, pandoc.Header(2, {pandoc.Str("Schlüsselwörter & Keywords")}))
  
  -- Create table with two columns
  local keyword_headers = {
    {pandoc.Plain({pandoc.Strong({pandoc.Str("Schlüsselwörter")})})},
    {pandoc.Plain({pandoc.Strong({pandoc.Str("Keywords")})})}
  }
  
  -- Determine maximum number of rows needed
  local max_rows = math.max(#schlusselworter, #keywords)
  
  local keyword_data = {}
  for i = 1, max_rows do
    local row = {
      {pandoc.Plain({pandoc.Str(schlusselworter[i] or "")})},
      {pandoc.Plain({pandoc.Str(keywords[i] or "")})}
    }
    table.insert(keyword_data, row)
  end
  
  -- Create keywords table
  if max_rows > 0 then
    local keywords_table = pandoc.utils.from_simple_table(
      pandoc.SimpleTable(
        {},  -- caption (empty)
        {pandoc.AlignDefault, pandoc.AlignDefault},
        {0, 0},  -- column widths (0 = default)
        keyword_headers,
        keyword_data
      )
    )
    table.insert(metadata_blocks, keywords_table)
  end
  
  -- Tables section
  table.insert(metadata_blocks, pandoc.Header(2, {pandoc.Str("Tabellen")}))
  local table_list = {
    {label = "tbl-pkg-versions", caption = "Versionen verfügbarer R-Packages"},
    {label = "tbl-baseline", caption = "Baselines in SAS und Stata (anhand 1% des simuliertes BTP)"},
    {label = "tbl-benchmark-small", caption = "Performanz Messungen für die Fallzahlberechnung anhand 1% des BTP"},
    {label = "tbl-benchmark-regr-small", caption = "Performanz Messungen für die Regressionsberechnung anhand 1% des BTP"},
    {label = "tbl-benchmark", caption = "Performanz Messungen für die Fallzahlberechnung anhand 10% des BTP"},
    {label = "tbl-benchmark-regr", caption = "Performanz Messungen für die Regressionsberechnung anhand 10% des BTP"},
    {label = "tbl-bm-cnt-small", caption = "Benchmarkergebnisse für Fallzahlen (kleine Stichproben des BTP)"},
    {label = "tbl-bm-reg-small", caption = "Benchmarkergebnisse für Regression (kleine Stichproben des BTP)"}
  }
  
  -- Create simple table using SimpleTable
  local table_headers = {
    {pandoc.Plain({pandoc.Strong({pandoc.Str("Nr.")})})},
    {pandoc.Plain({pandoc.Strong({pandoc.Str("Beschreibung")})})}
  }
  
  local table_data = {}
  for i, tbl in ipairs(table_list) do
    table.insert(table_data, {
      {pandoc.Plain({pandoc.Str("Tabelle " .. i)})},
      {pandoc.Plain({pandoc.Str(tbl.caption)})}
    })
  end
  
  -- Create table using pandoc.utils.from_simple_table
  local tables_table = pandoc.utils.from_simple_table(
    pandoc.SimpleTable(
      {},  -- caption (empty)
      {pandoc.AlignDefault, pandoc.AlignDefault},
      {0, 0},  -- column widths (0 = default)
      table_headers,
      table_data
    )
  )
  table.insert(metadata_blocks, tables_table)
  
  -- Figures section
  table.insert(metadata_blocks, pandoc.Header(2, {pandoc.Str("Abbildungen")}))
  local figure_list = {
    {label = "fig-optimization-strategies", caption = "Strategien zur Performanz-Optimierung im FDZ-Bund"}
  }
  
  -- Create simple table for figures
  local figure_headers = {
    {pandoc.Plain({pandoc.Strong({pandoc.Str("Nr.")})})},
    {pandoc.Plain({pandoc.Strong({pandoc.Str("Beschreibung")})})}
  }
  
  local figure_data = {}
  for i, fig in ipairs(figure_list) do
    table.insert(figure_data, {
      {pandoc.Plain({pandoc.Str("Abbildung " .. i)})},
      {pandoc.Plain({pandoc.Str(fig.caption)})}
    })
  end
  
  -- Create table using pandoc.utils.from_simple_table
  local figures_table = pandoc.utils.from_simple_table(
    pandoc.SimpleTable(
      {},  -- caption (empty)
      {pandoc.AlignDefault, pandoc.AlignDefault},
      {0, 0},  -- column widths (0 = default)
      figure_headers,
      figure_data
    )
  )
  table.insert(metadata_blocks, figures_table)
  
  -- Add page break
  table.insert(metadata_blocks, pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>'))
  
  -- Insert metadata blocks at the beginning of the document
  for i = #metadata_blocks, 1, -1 do
    table.insert(doc.blocks, 1, metadata_blocks[i])
  end
  
  return doc
end

return {
  {Pandoc = add_metadata_page}
}
