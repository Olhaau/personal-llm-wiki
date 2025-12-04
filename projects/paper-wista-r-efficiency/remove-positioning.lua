function RawBlock(el)
  if el.format == "latex" or el.format == "tex" then
    -- Remove lines that are just [t], [h], or [b]
    el.text = el.text:gsub("\n%[t%]\n", "\n")
    el.text = el.text:gsub("\n%[h%]\n", "\n")
    el.text = el.text:gsub("\n%[b%]\n", "\n")
  end
  return el
end
