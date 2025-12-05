-- Bridge filter to capture wordcount data and make it available to other filters
-- This should run immediately after wordcount

local section_data = {}

function Pandoc(doc)
  -- Access the wordcount extension's global data if available
  if _G.section_order and _G.words_by_section then
    for i, sec in ipairs(_G.section_order) do
      local title = sec.title
      local words = _G.words_by_section[title] or 0
      table.insert(section_data, {
        title = title,
        level = sec.level,
        words = words
      })
    end
    
    -- Store in metadata for other filters to access
    doc.meta['wordcount-sections'] = pandoc.MetaList(section_data)
  end
  
  return doc
end
