-- Lua filter to replace table cross-references with "Tabelle X" in DOCX output

function Cite(el)
  if FORMAT:match 'docx' then
    -- Map of table labels to numbers
    local table_map = {
      ["tbl-stba-rserver"] = 1,
      ["tbl-fdz-server"] = 2,
      ["tbl-dplyr-syntax"] = 3,
      ["tbl-baseline"] = 4,
      ["tbl-benchmark-small"] = 5,
      ["tbl-benchmark-regr-small"] = 6,
      ["tbl-benchmark"] = 7,
      ["tbl-benchmark-regr"] = 8
    }
    
    -- Check each citation
    for _, citation in ipairs(el.citations) do
      local id = citation.id
      
      -- If it's a table reference, replace it
      if table_map[id] then
        local table_num = table_map[id]
        return pandoc.Str("Tabelle " .. table_num)
      end
    end
  end
  
  return el
end
