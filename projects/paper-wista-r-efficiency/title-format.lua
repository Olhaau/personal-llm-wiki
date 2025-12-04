-- Lua filter to format section titles for DOCX with number, newline, hline, title, hline
-- Mimics the PDF formatting: number on separate line with horizontal rules above and below title

function Header(el)
  -- Only process level 2 headers (sections in the document)
  if el.level == 2 and FORMAT:match 'docx' then
    local content_str = pandoc.utils.stringify(el.content)
    local number = content_str:match("^(%d+)")
    
    if number then
      -- Remove the number from the title to get clean title text
      local title_text = content_str:gsub("^%d+%s+", "")
      
      -- Create custom formatted blocks:
      -- 1. Paragraph with section number (blue, bold, larger)
      -- 2. Paragraph with top horizontal line
      -- 3. Paragraph with title text (dark gray, bold)
      -- 4. Paragraph with bottom horizontal line
      
      local openxml = string.format([[
<w:p>
  <w:pPr>
    <w:pStyle w:val="Heading2"/>
    <w:jc w:val="left"/>
  </w:pPr>
  <w:r>
    <w:rPr>
      <w:b/>
      <w:sz w:val="32"/>
      <w:color w:val="417DB4"/>
    </w:rPr>
    <w:t>%s</w:t>
  </w:r>
</w:p>
<w:p>
  <w:pPr>
    <w:pBdr>
      <w:top w:val="single" w:sz="12" w:space="1" w:color="417DB4"/>
    </w:pBdr>
  </w:pPr>
</w:p>
<w:p>
  <w:pPr>
    <w:pStyle w:val="Heading2"/>
    <w:jc w:val="left"/>
  </w:pPr>
  <w:r>
    <w:rPr>
      <w:b/>
      <w:sz w:val="24"/>
      <w:color w:val="404040"/>
    </w:rPr>
    <w:t>%s</w:t>
  </w:r>
</w:p>
<w:p>
  <w:pPr>
    <w:pBdr>
      <w:bottom w:val="single" w:sz="12" w:space="1" w:color="417DB4"/>
    </w:pBdr>
  </w:pPr>
</w:p>
]], number, title_text)
      
      return pandoc.RawBlock('openxml', openxml)
    end
  end
  
  return el
end
