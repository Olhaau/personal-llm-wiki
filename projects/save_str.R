output <- capture.output(  
  str(  
    <R Object>,  
    max.level = Inf,   # show all nesting levels  
    vec.len   = Inf,   # show full vectors (no ...)  
    list.len  = Inf,   # show full lists  
    digits.d  = NULL   # avoid truncating numbers  
  )  
)  
  
writeLines(output, "./dev/beispiel_wohnen/object-str.txt")  
