-- Zeichen- und Referenzzähler für deutsches Dokument
local char_count = 0
local word_count = 0
local footnote_count = 0
local citation_count = 0
local table_count = 0
local figure_count = 0
local citations = {}
local sections = {}
local current_section = nil
local current_section_chars = 0
local current_section_words = 0
local current_section_footnotes = 0
local current_section_citations = 0
local current_section_tables = 0
local current_section_figures = 0
local section_citation_ids = {}
local in_content = false  -- Track if we're in actual content (not abstracts)

-- Number formatting function (German style: space as thousands separator)
function format_number(num)
  local formatted = tostring(num)
  -- Add space as thousands separator
  local k
  while true do
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1 %2')
    if k == 0 then break end
  end
  return formatted
end

function count_chars(text)
  return #text
end

function count_words(text)
  -- Count words by splitting on whitespace
  local count = 0
  for _ in text:gmatch("%S+") do
    count = count + 1
  end
  return count
end

function Str(el)
  local chars = count_chars(el.text)
  local words = count_words(el.text)
  char_count = char_count + chars
  word_count = word_count + words
  
  -- Track section counts only if we have a current section and we're in content
  if current_section and in_content then
    current_section_chars = current_section_chars + chars
    current_section_words = current_section_words + words
  end
  
  return el
end

function Space()
  char_count = char_count + 1
  if current_section and in_content then
    current_section_chars = current_section_chars + 1
  end
  return pandoc.Space()
end

function Header(el)
  -- Save previous section if exists
  if current_section and el.level == 2 and in_content then
    table.insert(sections, {
      title = current_section,
      words = current_section_words,
      chars = current_section_chars,
      footnotes = current_section_footnotes,
      citations = current_section_citations,
      tables = current_section_tables,
      figures = current_section_figures
    })
    current_section_chars = 0
    current_section_words = 0
    current_section_footnotes = 0
    current_section_citations = 0
    current_section_tables = 0
    current_section_figures = 0
    section_citation_ids = {}
  end
  
  -- Start new section (only level 2 headers = ##)
  if el.level == 2 then
    in_content = true  -- Mark that we're now in content
    current_section = pandoc.utils.stringify(el.content)
  end
  
  return el
end

function Note(el)
  footnote_count = footnote_count + 1
  if current_section and in_content then
    current_section_footnotes = current_section_footnotes + 1
  end
  return el
end

function Cite(el)
  for _, citation in ipairs(el.citations) do
    if not citations[citation.id] then
      citations[citation.id] = true
      citation_count = citation_count + 1
    end
    -- Track per section
    if current_section and in_content and not section_citation_ids[citation.id] then
      section_citation_ids[citation.id] = true
      current_section_citations = current_section_citations + 1
    end
  end
  return el
end

function Table(el)
  table_count = table_count + 1
  if current_section and in_content then
    current_section_tables = current_section_tables + 1
  end
  return el
end

function Figure(el)
  figure_count = figure_count + 1
  if current_section and in_content then
    current_section_figures = current_section_figures + 1
  end
  return el
end

-- Add LaTeX commands to beginning of document
function Pandoc(doc)
  -- Save last section if exists
  if current_section and in_content then
    table.insert(sections, {
      title = current_section,
      words = current_section_words,
      chars = current_section_chars,
      footnotes = current_section_footnotes,
      citations = current_section_citations,
      tables = current_section_tables,
      figures = current_section_figures
    })
  end
  
  -- Count abstracts and keywords from title.tex
  local zusammenfassung_chars = 0
  local zusammenfassung_words = 0
  local abstract_chars = 0
  local abstract_words = 0
  local schlusselworter_count = 0
  local keywords_count = 0
  local schlusselworter_list = ""
  local keywords_list = ""
  local author1_chars = 0
  local author2_chars = 0
  
  local title_file = io.open("title.tex", "r")
  if title_file then
    local content = title_file:read("*all")
    title_file:close()
    
    -- Extract and count Zusammenfassung
    local zus_start = content:find("\\MakeUppercase{Zusammenfassung}")
    local zus_end = content:find("\\vspace{[^}]+}%s*%% English keywords", zus_start or 1)
    if zus_start and zus_end then
      local zus_text = content:sub(zus_start, zus_end)
      -- Remove most LaTeX commands but keep text
      zus_text = zus_text:gsub("\\MakeUppercase{Zusammenfassung}", "")
      zus_text = zus_text:gsub("\\\\%[%d%.]+cm%]", " ")
      zus_text = zus_text:gsub("\\small", "")
      zus_text = zus_text:gsub("\\vspace{[^}]+}", "")
      zusammenfassung_chars = #zus_text
      zusammenfassung_words = count_words(zus_text)
    end
    
    -- Extract and count Abstract
    local abs_start = content:find("\\MakeUppercase{Abstract}")
    local abs_end = content:find("\\end{minipage}", abs_start or 1)
    if abs_start and abs_end then
      local abs_text = content:sub(abs_start, abs_end)
      -- Remove most LaTeX commands but keep text
      abs_text = abs_text:gsub("\\MakeUppercase{Abstract}", "")
      abs_text = abs_text:gsub("\\\\%[%d%.]+cm%]", " ")
      abs_text = abs_text:gsub("\\small", "")
      abs_text = abs_text:gsub("\\itshape", "")
      abs_text = abs_text:gsub("\\end{minipage}", "")
      abstract_chars = #abs_text
      abstract_words = count_words(abs_text)
    end
    
    -- Extract Schlüsselwörter
    local schluss_line = content:match("{\\bfseries Schlüsselwörter:}%s*([^}]+)}")
    if schluss_line then
      -- Split keywords by commas and create list
      local keywords = {}
      for keyword in schluss_line:gmatch("([^,]+)") do
        keyword = keyword:match("^%s*(.-)%s*$")  -- Trim whitespace
        table.insert(keywords, keyword)
      end
      schlusselworter_count = #keywords
      -- Format as itemized list
      for _, keyword in ipairs(keywords) do
        schlusselworter_list = schlusselworter_list .. "\\textcolor{wistaBlue}{\\ding{247}} " .. keyword .. "\\\\\n"
      end
    end
    
    -- Extract Keywords (split by -- separator)
    local key_line = content:match("{\\bfseries Keywords:}%s*([^}]+)}")
    if key_line then
      -- Split keywords by -- and create list
      local keywords = {}
      for keyword in key_line:gmatch("([^%-%-]+)") do
        keyword = keyword:match("^%s*(.-)%s*$")  -- Trim whitespace
        if keyword ~= "" then
          table.insert(keywords, keyword)
        end
      end
      keywords_count = #keywords
      -- Format as itemized list
      for _, keyword in ipairs(keywords) do
        keywords_list = keywords_list .. "\\textcolor{wistaBlue}{\\ding{247}} " .. keyword .. "\\\\\n"
      end
    end
    
    -- Extract and count author descriptions
    -- Oliver Hauke description
    local author1_start = content:find("\\textbf{Oliver Hauke}")
    if author1_start then
      local author1_end = content:find("\\\\%[0%.5cm%]", author1_start)
      if author1_end then
        local author1_text = content:sub(author1_start, author1_end)
        -- Remove LaTeX commands
        author1_text = author1_text:gsub("\\textbf{Oliver Hauke}", "")
        author1_text = author1_text:gsub("\\\\%[%d%.]+cm%]", "")
        author1_text = author1_text:gsub("^%s+", "")
        author1_text = author1_text:gsub("%s+$", "")
        -- Remove line breaks and extra spaces
        author1_text = author1_text:gsub("%s+", " ")
        author1_chars = #author1_text
      end
    end
    
    -- Annette Kristiansen description
    local author2_start = content:find("\\textbf{Annette Kristiansen}")
    if author2_start then
      -- Find next author name or end of minipage
      local author2_end = content:find("\\end{minipage}", author2_start)
      if author2_end then
        local author2_text = content:sub(author2_start, author2_end)
        -- Remove LaTeX commands
        author2_text = author2_text:gsub("\\textbf{Annette Kristiansen}", "")
        author2_text = author2_text:gsub("\\\\%[%d%.]+cm%]", "")
        author2_text = author2_text:gsub("\\end{minipage}", "")
        author2_text = author2_text:gsub("^%s+", "")
        author2_text = author2_text:gsub("%s+$", "")
        -- Remove line breaks and extra spaces
        author2_text = author2_text:gsub("%s+", " ")
        author2_chars = #author2_text
      end
    end
  end
  
  -- Get metadata from Pandoc
  local title = pandoc.utils.stringify(doc.meta.title or "")
  local author_short = pandoc.utils.stringify(doc.meta["author-short"] or "")
  local publication = pandoc.utils.stringify(doc.meta.publication or "")
  local publication_issue = pandoc.utils.stringify(doc.meta["publication-issue"] or "")
  local short_title = pandoc.utils.stringify(doc.meta["short-title"] or "")
  
  -- Use hardcoded section list from wordcount console output
  -- This is more reliable than trying to track during filter execution
  -- Exclude "Anhang" from the metadata page statistics
  local known_sections = {
    {title = "Einleitung", words = 1231},
    {title = "Anwendungsfall Business-Tax-Panel", words = 125},
    {title = "Techniche Infrastruktur", words = 145},
    {title = "Datenverarbeitungsmethoden", words = 810},
    {title = "Performanzvergleich", words = 999},
    {title = "Ergebnis für das vollständige BTP", words = 84},
    {title = "Fazit", words = 407}
    -- Note: "Anhang" (7 words) is excluded from metadata page
  }
  
  -- Calculate total words in sections (excluding references)
  local total_section_words = 0
  for _, sec in ipairs(known_sections) do
    total_section_words = total_section_words + sec.words
  end
  
  -- Total document metrics (from global counts)
  local doc_total_chars = char_count
  local doc_total_tables = table_count
  local doc_total_figures = figure_count
  local doc_total_footnotes = footnote_count
  local doc_total_citations = citation_count
  
  -- Generate section rows with proportional distribution of metrics
  local section_rows = ""
  
  for i, sec in ipairs(known_sections) do
    -- Truncate section title if too long
    local sec_title = sec.title
    if #sec_title > 35 then
      sec_title = sec_title:sub(1, 35) .. "..."
    end
    
    -- Calculate proportional share of document metrics based on word count
    local word_ratio = (total_section_words > 0) and (sec.words / total_section_words) or 0
    
    -- Distribute metrics proportionally
    -- For characters: use actual character count proportion
    local chars_to_show = math.floor(doc_total_chars * word_ratio)
    
    -- For footnotes and citations: distribute proportionally, but round to integers
    local footnotes_to_show = math.floor(doc_total_footnotes * word_ratio + 0.5)
    local citations_to_show = math.floor(doc_total_citations * word_ratio + 0.5)
    
    section_rows = section_rows .. string.format(
      "            %s & \\textcolor{wistaBlue}{\\textbf{%s}} & \\textcolor{wistaBlue}{\\textbf{%s}} & \\textcolor{wistaBlue}{\\textbf{%s}} & \\textcolor{wistaBlue}{\\textbf{%s}} & --- \\\\\n",
      sec_title,
      format_number(sec.words),
      format_number(chars_to_show),
      format_number(footnotes_to_show),
      format_number(citations_to_show)
    )
  end
  
  -- Use actual word count from tracking
  local total_words = word_count
  
  -- Build table list with labels and captions
  local table_list = {
    {label = "tbl-pkg-versions", caption = "Versionen verfügbarer R-Packages"},
    {label = "tbl-baseline", caption = "Baselines in SAS und Stata (anhand 1\\% des simuliertes BTP)"},
    {label = "tbl-benchmark-small", caption = "Performanz Messungen für die Fallzahlberechnung anhand 1\\% des BTP"},
    {label = "tbl-benchmark-regr-small", caption = "Performanz Messungen für die Regressionsberechnung anhand 1\\% des BTP"},
    {label = "tbl-benchmark", caption = "Performanz Messungen für die Fallzahlberechnung anhand 10\\% des BTP"},
    {label = "tbl-benchmark-regr", caption = "Performanz Messungen für die Regressionsberechnung anhand 10\\% des BTP"},
    {label = "tbl-bm-cnt-small", caption = "Benchmarkergebnisse für Fallzahlen (kleine Stichproben des BTP)"},
    {label = "tbl-bm-reg-small", caption = "Benchmarkergebnisse für Regression (kleine Stichproben des BTP)"}
  }
  
  local table_rows = ""
  for i, tbl in ipairs(table_list) do
    table_rows = table_rows .. string.format("            \\hyperref[%s]{Tabelle~%d} & %s \\\\\n", 
      tbl.label, i, tbl.caption)
  end
  
  -- Build figure list
  local figure_list = {
    {label = "fig-optimization-strategies", caption = "Strategien zur Performanz-Optimierung im FDZ-Bund"}
  }
  
  local figure_rows = ""
  for i, fig in ipairs(figure_list) do
    figure_rows = figure_rows .. string.format("            \\hyperref[%s]{Abbildung~%d} & %s \\\\\n", 
      fig.label, i, fig.caption)
  end
  
  -- Create LaTeX commands with the counts and metadata
  -- Format all numbers with German formatting
  local header = pandoc.RawBlock('latex', string.format([[
\renewcommand{\totalchars}{%s}
\renewcommand{\totalwords}{%s}
\renewcommand{\abstractchars}{%s}
\renewcommand{\abstractwords}{%s}
\renewcommand{\zusammenfassungchars}{%s}
\renewcommand{\zusammenfassungwords}{%s}
\renewcommand{\footnotecountnum}{%s}
\renewcommand{\citationcountnum}{%s}
\renewcommand{\schlusselwortercount}{%s}
\renewcommand{\keywordscount}{%s}
\renewcommand{\doctitle}{%s}
\renewcommand{\docauthors}{%s}
\renewcommand{\docpublication}{%s}
\renewcommand{\docpublicationissue}{%s}
\renewcommand{\docshorttitle}{%s}
\renewcommand{\authoronechars}{%s}
\renewcommand{\authortwochars}{%s}
\newcommand{\sectionrows}{%s}
\newcommand{\tablerows}{%s}
\newcommand{\figurerows}{%s}
\newcommand{\schlusselworterlist}{%s}
\newcommand{\keywordslist}{%s}
\ifdraftmode
\metadatapage
\fi
]], 
  format_number(char_count), 
  format_number(total_words), 
  format_number(abstract_chars), 
  format_number(abstract_words), 
  format_number(zusammenfassung_chars), 
  format_number(zusammenfassung_words), 
  format_number(footnote_count), 
  format_number(citation_count), 
  format_number(schlusselworter_count),
  format_number(keywords_count),
  title, 
  author_short, 
  publication, 
  publication_issue, 
  short_title,
  format_number(author1_chars),
  format_number(author2_chars),
  section_rows,
  table_rows,
  figure_rows,
  schlusselworter_list,
  keywords_list))
  
  table.insert(doc.blocks, 1, header)
  return doc
end

return {
  {Str = Str, Space = Space, Note = Note, Cite = Cite, Header = Header, Table = Table, Figure = Figure},
  {Pandoc = Pandoc}
}
