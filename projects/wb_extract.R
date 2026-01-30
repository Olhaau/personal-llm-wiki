# todo: idea function that gets a wb_dim and finds content and styling of that cell to recreate the style

# style id
wb$get_cell_style(dims=wb_dims(2,1))
#A2 
#"16" 

sm <- wb$styles_mgr

sm$cellStyle %>% .[.$id == 16,]
#typ id           name
#17 cellStyle 16 Standard 4 2 3

sm$styles$cellStyles %>% .[grepl("\"Standard 4 2 3\"", .)]
#"<cellStyle name=\"Standard 4 2 3\" xfId=\"17\" xr:uid=\"{00000000-0005-0000-0000-000010000000}\"/>"

sm$styles$cellStyleXfs[17+1] # shift, xfId starts at 0
#[1] "<xf numFmtId=\"0\" fontId=\"9\" fillId=\"0\" borderId=\"0\"/>"
sm$styles$cellXfs[17+1]
#[1] "<xf numFmtId=\"0\" fontId=\"4\" fillId=\"0\" borderId=\"1\" xfId=\"0\" applyFont=\"1\" applyFill=\"1\" applyBorder=\"1\" applyAlignment=\"1\"><alignment horizontal=\"centerContinuous\" vertical=\"center\"/></xf>"

sm$styles$numFmts[0+1]
#[1] "<numFmt numFmtId=\"164\" formatCode=\"###,##0\"/>"
sm$styles$fonts[4+1]
#[1] "<font><sz val=\"9\"/><color rgb=\"FF000000\"/><name val=\"MetaNormalLF-Roman\"/><family val=\"2\"/></font>"
sm$styles$fills[0+1]
#[1] "<fill><patternFill patternType=\"none\"/></fill>"
sm$styles$borders[1+1]
#[1] "<border><left style=\"thin\"><color rgb=\"FF000000\"/></left><right/><top style=\"thin\"><color rgb=\"FF000000\"/></top><bottom style=\"thin\"><color rgb=\"FF000000\"/></bottom><diagonal/></border>"
