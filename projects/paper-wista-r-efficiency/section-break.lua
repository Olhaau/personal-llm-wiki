-- Lua filter to handle section breaks for DOCX
-- Converts special div to section break that switches column layout

function Div(el)
  if el.classes:includes("section-break-twocol") then
    -- Insert a section break that switches to two columns after title page
    local openxml = [[
<w:p>
  <w:pPr>
    <w:sectPr>
      <w:type w:val="nextPage"/>
      <w:pgSz w:w="11906" w:h="16838"/>
      <w:pgMar w:top="1418" w:right="1134" w:bottom="1418" w:left="1134" w:header="709" w:footer="709" w:gutter="0"/>
      <w:cols w:num="1" w:space="708"/>
    </w:sectPr>
  </w:pPr>
</w:p>
]]
    return pandoc.RawBlock("openxml", openxml)
  end
  return el
end
