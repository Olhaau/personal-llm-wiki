-- Lua filter to remove tables from DOCX output
-- Tables are exported to Excel instead

function Table(el)
  if FORMAT:match 'docx' then
    -- Replace table with a note pointing to Excel file
    return pandoc.Para({
      pandoc.Strong(pandoc.Str("→")),
      pandoc.Space(),
      pandoc.Emph(pandoc.Str("Tabelle ausgelagert in Excel-Datei")),
      pandoc.Space(),
      pandoc.Str("(siehe Tabellen-Effiziente-Analyse-Forschungsdaten-R.xlsx)")
    })
  end
  return el
end

-- Also handle R code chunks that produce tables
function CodeBlock(el)
  if FORMAT:match 'docx' then
    -- Check if this is a table-generating code chunk
    if el.classes:includes('cell') and 
       (el.text:find('format_.*_table') or 
        el.text:find('tbl%-cap:') or
        el.text:find('kable')) then
      return pandoc.Para({
        pandoc.Strong(pandoc.Str("→")),
        pandoc.Space(),
        pandoc.Emph(pandoc.Str("Tabelle ausgelagert in Excel-Datei"))
      })
    end
  end
  return el
end

-- Handle table captions separately
function Caption(el)
  if FORMAT:match 'docx' then
    return pandoc.Para({
      pandoc.Strong(el.long[1]),
      pandoc.Space(),
      pandoc.Str("→ siehe Excel-Datei")
    })
  end
  return el
end
