# .Rprofile for r-export-excel project
# Automatically sourced when R starts in this directory

cat("\n")
cat("====================================\n")
cat("  Excel Export with Destatis Style\n")
cat("====================================\n\n")

cat("Quick commands:\n")
cat("  source('R/excelize.R')           - Load excelize function\n")
cat("  source('examples/example_usage.R') - Run examples\n")
cat("  source('test_excelize.R')        - Run tests\n\n")

# Automatically load the excelize function if available
if (file.exists("R/excelize.R")) {
  cat("Loading excelize function...\n")
  tryCatch({
    source("R/excelize.R")
    cat("✓ excelize() function ready to use!\n\n")
  }, error = function(e) {
    cat("✗ Error loading excelize function\n\n")
  })
}
