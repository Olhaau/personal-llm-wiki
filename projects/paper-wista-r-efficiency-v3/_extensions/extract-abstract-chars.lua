-- Extract character counts from title.tex abstracts
function Meta(meta)
  -- Read title.tex and extract abstract text
  local title_file = io.open("title.tex", "r")
  if not title_file then
    return meta
  end
  
  local content = title_file:read("*all")
  title_file:close()
  
  -- Extract Zusammenfassung (German abstract)
  local zusammenfassung = content:match("\\MakeUppercase{Zusammenfassung}.-\n(.-)\\vspace")
  if zusammenfassung then
    -- Remove LaTeX commands for character counting
    local cleaned = zusammenfassung:gsub("\\[%a]+%b{}", "")
    cleaned = cleaned:gsub("\\[%a]+", "")
    cleaned = cleaned:gsub("%s+", " ")
    cleaned = cleaned:gsub("^%s+", "")
    cleaned = cleaned:gsub("%s+$", "")
    meta['zusammenfassung-chars'] = #cleaned
  else
    meta['zusammenfassung-chars'] = 0
  end
  
  -- Extract Abstract (English abstract)
  local abstract = content:match("\\MakeUppercase{Abstract}.-\n(.-)\\end{minipage}")
  if abstract then
    -- Remove LaTeX commands for character counting
    local cleaned = abstract:gsub("\\[%a]+%b{}", "")
    cleaned = cleaned:gsub("\\[%a]+", "")
    cleaned = cleaned:gsub("%s+", " ")
    cleaned = cleaned:gsub("^%s+", "")
    cleaned = cleaned:gsub("%s+$", "")
    meta['abstract-chars'] = #cleaned
  else
    meta['abstract-chars'] = 0
  end
  
  return meta
end

return {{Meta = Meta}}
