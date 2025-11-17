---
title: "HTML Tables Reference - W3C HTML 4.01 Specification"
type: "specification"
category: "html"
subcategory: "tables"
tags: ["html", "tables", "w3c", "specification", "reference"]
language: "HTML"
project: "html"
source_type: "official"
maintainer: "w3c"
created_date: "2024-11-17"
last_updated: "2024-11-17"
status: "archived"
scope: "html-tables"
target_audience: ["web-developers", "html-authors", "accessibility-experts"]
technical_level: "intermediate"
coverage: ["table-structure", "accessibility", "formatting", "elements", "attributes"]
related_technologies: ["css", "accessibility", "web-standards"]
source_urls: ["https://www.w3.org/TR/html401/struct/tables.html"]
version: "HTML 4.01"
standard_body: "W3C"
---

# HTML Tables Reference - W3C HTML 4.01 Specification

*Source: [W3C HTML 4.01 Tables Specification](https://www.w3.org/TR/html401/struct/tables.html)*

## Overview

HTML tables allow authors to arrange data into rows and columns of cells. The HTML table model supports complex structures including:

- Table captions and summaries for accessibility
- Row groups (header, body, footer)
- Column groups for structural organization
- Cell spanning across multiple rows/columns
- Rich formatting and alignment options

## Core Table Elements

### TABLE Element
```html
<TABLE summary="Table description for accessibility">
  <!-- Table content -->
</TABLE>
```

**Key Attributes:**
- `summary`: Describes table's purpose and structure for non-visual users
- `width`: Table width (pixels or percentage)
- `border`: Frame width in pixels
- `cellspacing`: Space between cells
- `cellpadding`: Space within cells

### Row Structure Elements

#### CAPTION - Table Caption
```html
<CAPTION>Table Title</CAPTION>
```
Provides a short description visible to all users.

#### Row Groups
```html
<THEAD>  <!-- Table header -->
  <TR>...</TR>
</THEAD>
<TFOOT>  <!-- Table footer -->
  <TR>...</TR>
</TFOOT>
<TBODY>  <!-- Table body -->
  <TR>...</TR>
  <TR>...</TR>
</TBODY>
```

**Benefits:**
- Enables scrolling body independently of header/footer
- Supports repeated headers/footers when printing
- Better semantic structure

#### TR - Table Row
```html
<TR>
  <TD>Cell 1</TD>
  <TD>Cell 2</TD>
</TR>
```

### Cell Elements

#### TH - Header Cell
```html
<TH scope="col">Column Header</TH>
<TH scope="row">Row Header</TH>
```

#### TD - Data Cell
```html
<TD>Data content</TD>
```

**Cell Spanning:**
```html
<TD colspan="2">Spans 2 columns</TD>
<TD rowspan="3">Spans 3 rows</TD>
```

## Column Structure

### COLGROUP and COL
```html
<COLGROUP span="2" width="100">
  <COL width="50">
  <COL width="150">
</COLGROUP>
```

**Benefits:**
- Define column properties before table data arrives
- Enable incremental rendering
- Group columns semantically

## Accessibility Features

### Associating Headers with Data
```html
<!-- Method 1: scope attribute -->
<TH scope="col">Name</TH>
<TH scope="col">Age</TH>

<!-- Method 2: headers attribute -->
<TH id="name-header">Name</TH>
<TD headers="name-header">John</TD>
```

### Cell Categorization
```html
<TH axis="location">San Jose</TH>
<TH axis="expenses">Meals</TH>
<TD headers="location expenses">37.74</TD>
```

## Formatting and Alignment

### Horizontal Alignment
- `align="left|center|right|justify|char"`
- `char="."` - Character to align on
- `charoff="5"` - Offset from alignment character

### Vertical Alignment
- `valign="top|middle|bottom|baseline"`

### Inheritance Order (highest to lowest priority)
1. Element within cell data
2. Cell (TH/TD)
3. Column group (COL/COLGROUP)
4. Row/row group (TR/THEAD/TBODY/TFOOT)
5. Table (TABLE)
6. Default values

## Borders and Rules

### Frame Attribute
Controls which sides of table frame are visible:
- `void`: No sides (default)
- `above`: Top only
- `below`: Bottom only
- `hsides`: Top and bottom
- `vsides`: Left and right
- `box|border`: All sides

### Rules Attribute
Controls internal rules between cells:
- `none`: No rules (default)
- `groups`: Between row/column groups only
- `rows`: Between rows only
- `cols`: Between columns only
- `all`: Between all rows and columns

## Best Practices

### Accessibility
1. Always provide meaningful `summary` attribute
2. Use `CAPTION` for visible table titles
3. Associate headers with data using `scope` or `headers`
4. Use `abbr` attribute for abbreviated header text
5. Use TH for headers, TD for data

### Performance
1. Specify column widths for incremental rendering
2. Use COLGROUP/COL to define column properties early
3. Avoid percentage widths without fixed table width

### Structure
1. Use row groups (THEAD/TBODY/TFOOT) for logical organization
2. Group related columns with COLGROUP
3. Use semantic markup (TH vs TD) correctly

## Common Patterns

### Simple Data Table
```html
<TABLE summary="Employee information">
  <CAPTION>Employee Directory</CAPTION>
  <THEAD>
    <TR>
      <TH scope="col">Name</TH>
      <TH scope="col">Department</TH>
      <TH scope="col">Email</TH>
    </TR>
  </THEAD>
  <TBODY>
    <TR>
      <TD>John Doe</TD>
      <TD>Engineering</TD>
      <TD>john@example.com</TD>
    </TR>
  </TBODY>
</TABLE>
```

### Complex Table with Groups
```html
<TABLE border="1" summary="Quarterly sales by region and product">
  <CAPTION>Q1 Sales Report</CAPTION>
  <COLGROUP>
    <COL width="100">
  </COLGROUP>
  <COLGROUP span="3" width="80">
  </COLGROUP>
  <THEAD>
    <TR>
      <TH scope="col">Region</TH>
      <TH scope="col">Product A</TH>
      <TH scope="col">Product B</TH>
      <TH scope="col">Total</TH>
    </TR>
  </THEAD>
  <TBODY>
    <TR>
      <TH scope="row">North</TH>
      <TD>$1,000</TD>
      <TD>$1,500</TD>
      <TD>$2,500</TD>
    </TR>
  </TBODY>
</TABLE>
```

## Notes

- Tables should not be used purely for layout purposes
- Use CSS for visual formatting when possible
- The `border` attribute is not deprecated but CSS is recommended
- User agents may handle overlapping cells differently
- TFOOT must appear before TBODY in markup but renders at bottom

---

*This reference summarizes key concepts from the W3C HTML 4.01 Tables specification. For complete details, refer to the original W3C documentation.*