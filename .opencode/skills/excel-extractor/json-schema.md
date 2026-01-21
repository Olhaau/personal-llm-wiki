# JSON Schema for Excel Specifications

## Coordinate-Based Layout System

The Excel extraction uses a coordinate-based layout system where all formatting and content is positioned using Excel's native coordinate system: Sheet → Row → Column. This system supports blocks, overlays, and complex formatting scenarios.

## Core Coordinate Structure

### Base Coordinate System
```json
{
  "coordinate": {
    "sheet": "Sheet1",
    "row": 5,
    "col": 3,
    "address": "C5"
  }
}
```

### Range-Based Coordinates
```json
{
  "range": {
    "sheet": "Sheet1", 
    "start": {"row": 1, "col": 1, "address": "A1"},
    "end": {"row": 10, "col": 5, "address": "E10"},
    "range_address": "A1:E10",
    "dimensions": {"rows": 10, "cols": 5, "total_cells": 50}
  }
}
```

## Layout Blocks and Overlays

### Formatting Blocks
Blocks define contiguous areas with consistent formatting:

```json
{
  "formatting_blocks": [
    {
      "block_id": "header_block_1",
      "type": "header",
      "sheet": "Sheet1",
      "range": "A1:F1",
      "coordinates": {
        "start": {"row": 1, "col": 1},
        "end": {"row": 1, "col": 6}
      },
      "formatting": {
        "font": {
          "name": "Calibri",
          "size": 14,
          "bold": true,
          "color": "#FFFFFF"
        },
        "fill": {
          "type": "solid",
          "color": "#4472C4"
        },
        "alignment": {
          "horizontal": "center",
          "vertical": "middle"
        },
        "borders": {
          "all": {"style": "medium", "color": "#000000"}
        }
      },
      "priority": 1
    },
    {
      "block_id": "data_block_1",
      "type": "data",
      "sheet": "Sheet1", 
      "range": "A2:F100",
      "coordinates": {
        "start": {"row": 2, "col": 1},
        "end": {"row": 100, "col": 6}
      },
      "formatting": {
        "font": {"name": "Calibri", "size": 11},
        "borders": {"all": {"style": "thin", "color": "#CCCCCC"}},
        "alternating_rows": {
          "enabled": true,
          "even_row_fill": "#F2F2F2",
          "odd_row_fill": "#FFFFFF"
        }
      },
      "priority": 2
    }
  ]
}
```

### Overlay System
Overlays allow formatting to be applied on top of blocks:

```json
{
  "formatting_overlays": [
    {
      "overlay_id": "highlight_overlay_1",
      "type": "conditional_highlight",
      "sheet": "Sheet1",
      "range": "C2:C100",
      "coordinates": {
        "start": {"row": 2, "col": 3},
        "end": {"row": 100, "col": 3}
      },
      "condition": {
        "type": "cell_value",
        "operator": "greater_than", 
        "value": 1000
      },
      "formatting": {
        "fill": {"type": "solid", "color": "#FF6B6B"},
        "font": {"color": "#FFFFFF", "bold": true}
      },
      "priority": 10,
      "overlay_mode": "override"
    },
    {
      "overlay_id": "formula_overlay_1", 
      "type": "formula_highlight",
      "sheet": "Sheet1",
      "cells": ["D5", "E7", "F12"],
      "coordinates": [
        {"row": 5, "col": 4, "address": "D5"},
        {"row": 7, "col": 5, "address": "E7"},
        {"row": 12, "col": 6, "address": "F12"}
      ],
      "formatting": {
        "fill": {"type": "solid", "color": "#FFEB84"},
        "borders": {"all": {"style": "thick", "color": "#FF9900"}}
      },
      "priority": 15,
      "overlay_mode": "blend"
    }
  ]
}
```

## Complete Schema Structure

### Root Schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "Excel File Specifications",
  "type": "object",
  "properties": {
    "meta": {"$ref": "#/$defs/ExtractionMeta"},
    "workbook": {"$ref": "#/$defs/WorkbookSpecs"},
    "coordinate_system": {"$ref": "#/$defs/CoordinateSystem"},
    "worksheets": {"$ref": "#/$defs/WorksheetCollection"},
    "extraction_summary": {"$ref": "#/$defs/ExtractionSummary"}
  },
  "required": ["meta", "workbook", "coordinate_system", "worksheets"]
}
```

### Coordinate System Definition
```json
{
  "CoordinateSystem": {
    "type": "object",
    "properties": {
      "addressing_mode": {
        "type": "string",
        "enum": ["A1", "R1C1"],
        "default": "A1"
      },
      "sheet_indexing": {
        "type": "string", 
        "enum": ["name", "index", "both"],
        "default": "name"
      },
      "zero_based": {
        "type": "boolean",
        "default": false,
        "description": "Whether row/column indices are zero-based"
      },
      "max_dimensions": {
        "type": "object",
        "properties": {
          "max_rows": {"type": "integer", "default": 1048576},
          "max_cols": {"type": "integer", "default": 16384}
        }
      }
    }
  }
}
```

### Worksheet Specification
```json
{
  "WorksheetSpecs": {
    "type": "object",
    "properties": {
      "name": {"type": "string"},
      "index": {"type": "integer"},
      "properties": {"$ref": "#/$defs/SheetProperties"},
      "dimensions": {"$ref": "#/$defs/SheetDimensions"},
      "coordinate_grid": {"$ref": "#/$defs/CoordinateGrid"},
      "content_layers": {"$ref": "#/$defs/ContentLayers"},
      "formatting_layers": {"$ref": "#/$defs/FormattingLayers"}
    }
  }
}
```

### Coordinate Grid System
```json
{
  "CoordinateGrid": {
    "type": "object",
    "properties": {
      "used_range": {
        "type": "object",
        "properties": {
          "start": {"$ref": "#/$defs/CellCoordinate"},
          "end": {"$ref": "#/$defs/CellCoordinate"},
          "range_address": {"type": "string", "pattern": "^[A-Z]+[0-9]+:[A-Z]+[0-9]+$"}
        }
      },
      "data_regions": {
        "type": "array",
        "items": {"$ref": "#/$defs/DataRegion"}
      },
      "merged_cells": {
        "type": "array", 
        "items": {"$ref": "#/$defs/MergedCellRange"}
      },
      "row_definitions": {"$ref": "#/$defs/RowDefinitions"},
      "column_definitions": {"$ref": "#/$defs/ColumnDefinitions"}
    }
  }
}
```

### Cell Coordinate Definition
```json
{
  "CellCoordinate": {
    "type": "object",
    "properties": {
      "row": {"type": "integer", "minimum": 1},
      "col": {"type": "integer", "minimum": 1}, 
      "address": {"type": "string", "pattern": "^[A-Z]+[0-9]+$"},
      "sheet": {"type": "string"}
    },
    "required": ["row", "col", "address"]
  }
}
```

### Data Region (Block) Definition
```json
{
  "DataRegion": {
    "type": "object", 
    "properties": {
      "region_id": {"type": "string"},
      "type": {
        "type": "string",
        "enum": ["header", "data", "summary", "formula", "chart", "pivot", "custom"]
      },
      "coordinates": {
        "type": "object",
        "properties": {
          "start": {"$ref": "#/$defs/CellCoordinate"},
          "end": {"$ref": "#/$defs/CellCoordinate"},
          "range_address": {"type": "string"}
        }
      },
      "structure": {
        "type": "object",
        "properties": {
          "has_headers": {"type": "boolean"},
          "header_rows": {"type": "integer"},
          "header_cols": {"type": "integer"},
          "data_orientation": {
            "type": "string",
            "enum": ["rows", "columns", "mixed"]
          }
        }
      },
      "content": {"$ref": "#/$defs/RegionContent"}
    }
  }
}
```

## Content Layers

### Cell Content Layer
```json
{
  "ContentLayers": {
    "type": "object",
    "properties": {
      "cell_values": {
        "type": "object",
        "patternProperties": {
          "^[A-Z]+[0-9]+$": {"$ref": "#/$defs/CellContent"}
        }
      },
      "formulas": {
        "type": "object", 
        "patternProperties": {
          "^[A-Z]+[0-9]+$": {"$ref": "#/$defs/FormulaContent"}
        }
      },
      "comments": {
        "type": "object",
        "patternProperties": {
          "^[A-Z]+[0-9]+$": {"$ref": "#/$defs/CommentContent"}
        }
      },
      "hyperlinks": {
        "type": "object",
        "patternProperties": {
          "^[A-Z]+[0-9]+$": {"$ref": "#/$defs/HyperlinkContent"}
        }
      }
    }
  }
}
```

### Cell Content Definition  
```json
{
  "CellContent": {
    "type": "object",
    "properties": {
      "coordinate": {"$ref": "#/$defs/CellCoordinate"},
      "value": {"oneOf": [
        {"type": "string"},
        {"type": "number"},
        {"type": "boolean"},
        {"type": "null"}
      ]},
      "data_type": {
        "type": "string", 
        "enum": ["string", "number", "date", "datetime", "boolean", "error", "formula", "empty"]
      },
      "original_type": {"type": "string"},
      "formatted_value": {"type": "string"},
      "internal_value": {"description": "Raw Excel internal value"}
    }
  }
}
```

## Formatting Layers

### Layered Formatting System
```json
{
  "FormattingLayers": {
    "type": "object",
    "properties": {
      "base_formatting": {"$ref": "#/$defs/BaseFormattingLayer"},
      "block_formatting": {
        "type": "array",
        "items": {"$ref": "#/$defs/FormattingBlock"}
      },
      "overlay_formatting": {
        "type": "array", 
        "items": {"$ref": "#/$defs/FormattingOverlay"}
      },
      "conditional_formatting": {
        "type": "array",
        "items": {"$ref": "#/$defs/ConditionalFormattingRule"}
      },
      "priority_resolution": {"$ref": "#/$defs/PriorityResolution"}
    }
  }
}
```

### Formatting Block Definition
```json
{
  "FormattingBlock": {
    "type": "object",
    "properties": {
      "block_id": {"type": "string"},
      "coordinates": {
        "oneOf": [
          {"$ref": "#/$defs/RangeCoordinate"},
          {"type": "array", "items": {"$ref": "#/$defs/CellCoordinate"}}
        ]
      },
      "block_type": {
        "type": "string",
        "enum": ["rectangular", "irregular", "row", "column", "selection"]
      },
      "formatting": {"$ref": "#/$defs/CellFormatting"},
      "priority": {"type": "integer", "minimum": 1},
      "inheritance": {
        "type": "object",
        "properties": {
          "inherits_from": {"type": "string"},
          "override_properties": {"type": "array", "items": {"type": "string"}}
        }
      }
    }
  }
}
```

### Formatting Overlay Definition
```json
{
  "FormattingOverlay": {
    "type": "object",
    "properties": {
      "overlay_id": {"type": "string"},
      "coordinates": {"$ref": "#/$defs/RangeCoordinate"},
      "overlay_type": {
        "type": "string",
        "enum": ["conditional", "validation", "protection", "custom"]
      },
      "condition": {"$ref": "#/$defs/OverlayCondition"},
      "formatting": {"$ref": "#/$defs/CellFormatting"},
      "priority": {"type": "integer", "minimum": 1},
      "blend_mode": {
        "type": "string",
        "enum": ["override", "merge", "blend", "multiply"],
        "default": "override"
      },
      "applies_when": {"$ref": "#/$defs/ApplicationCondition"}
    }
  }
}
```

### Range Coordinate Definition
```json
{
  "RangeCoordinate": {
    "type": "object",
    "properties": {
      "sheet": {"type": "string"},
      "start": {"$ref": "#/$defs/CellCoordinate"},
      "end": {"$ref": "#/$defs/CellCoordinate"},
      "range_address": {"type": "string"},
      "named_range": {"type": "string"},
      "dimensions": {
        "type": "object",
        "properties": {
          "rows": {"type": "integer"},
          "cols": {"type": "integer"},
          "total_cells": {"type": "integer"}
        }
      }
    }
  }
}
```

## Advanced Coordinate Features

### Row and Column Definitions
```json
{
  "RowDefinitions": {
    "type": "object",
    "patternProperties": {
      "^[0-9]+$": {
        "type": "object",
        "properties": {
          "row_number": {"type": "integer"},
          "height": {"type": "number"},
          "hidden": {"type": "boolean", "default": false},
          "formatting": {"$ref": "#/$defs/RowFormatting"},
          "page_break": {"type": "boolean", "default": false},
          "outline_level": {"type": "integer", "minimum": 0, "maximum": 7}
        }
      }
    }
  },
  "ColumnDefinitions": {
    "type": "object", 
    "patternProperties": {
      "^[A-Z]+$": {
        "type": "object",
        "properties": {
          "column_letter": {"type": "string"},
          "column_number": {"type": "integer"},
          "width": {"type": "number"},
          "hidden": {"type": "boolean", "default": false},
          "formatting": {"$ref": "#/$defs/ColumnFormatting"},
          "page_break": {"type": "boolean", "default": false},
          "outline_level": {"type": "integer", "minimum": 0, "maximum": 7}
        }
      }
    }
  }
}
```

### Merged Cell Ranges
```json
{
  "MergedCellRange": {
    "type": "object",
    "properties": {
      "merge_id": {"type": "string"},
      "coordinates": {"$ref": "#/$defs/RangeCoordinate"},
      "merge_type": {
        "type": "string",
        "enum": ["across", "center", "justify"]
      },
      "master_cell": {"$ref": "#/$defs/CellCoordinate"},
      "affects_formatting": {"type": "boolean", "default": true}
    }
  }
}
```

## Priority and Resolution System

### Priority Resolution Rules
```json
{
  "PriorityResolution": {
    "type": "object",
    "properties": {
      "resolution_strategy": {
        "type": "string",
        "enum": ["highest_priority", "last_applied", "specific_wins", "blend"],
        "default": "highest_priority"
      },
      "conflict_resolution": {
        "type": "object",
        "properties": {
          "font_conflicts": {"type": "string", "enum": ["merge", "override", "ignore"]},
          "fill_conflicts": {"type": "string", "enum": ["blend", "override", "layer"]},
          "border_conflicts": {"type": "string", "enum": ["combine", "override", "strongest"]}
        }
      },
      "layer_order": {
        "type": "array",
        "items": {
          "type": "string",
          "enum": ["base", "block", "overlay", "conditional", "protection", "validation"]
        }
      }
    }
  }
}
```

This coordinate-based system provides:

1. **Native Excel Compatibility**: Uses Excel's row/column coordinate system
2. **Block Support**: Rectangular and irregular formatting blocks  
3. **Overlay Capability**: Multiple formatting layers with priority resolution
4. **Scalability**: Efficient for large spreadsheets
5. **Reconstruction Accuracy**: Perfect fidelity for recreating Excel files
6. **AI-Friendly**: Structured data that AI agents can easily understand and manipulate