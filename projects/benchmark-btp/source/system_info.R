# system_info.R
# Collect system specifications and software versions for benchmarking
# ----

#' Collect System Information and Software Versions
#'
#' Gathers comprehensive system information including hardware specs,
#' OS details, R version, and installed package versions.
#'
#' @return A list containing:
#'   \item{timestamp}{ISO 8601 timestamp when info was collected}
#'   \item{system}{System information (OS, architecture, etc.)}
#'   \item{hardware}{Hardware specs (CPU, cores, memory)}
#'   \item{r_version}{R version and platform details}
#'   \item{packages}{Versions of key packages}
#'
#' @export
collect_system_info <- function() {
  # Get system information
  sys_info <- Sys.info()
  
  # Get CPU information (Linux-specific)
  cpu_info <- tryCatch({
    if (file.exists("/proc/cpuinfo")) {
      cpuinfo <- readLines("/proc/cpuinfo")
      model_line <- grep("model name", cpuinfo, value = TRUE)[1]
      cpu_model <- sub(".*: ", "", model_line)
      cpu_cores <- parallel::detectCores(logical = FALSE)
      cpu_threads <- parallel::detectCores(logical = TRUE)
      
      list(
        model = cpu_model,
        physical_cores = cpu_cores,
        logical_cores = cpu_threads
      )
    } else {
      list(
        model = "Unknown",
        physical_cores = parallel::detectCores(logical = FALSE),
        logical_cores = parallel::detectCores(logical = TRUE)
      )
    }
  }, error = function(e) {
    list(
      model = "Unknown",
      physical_cores = NA,
      logical_cores = parallel::detectCores(logical = TRUE)
    )
  })
  
  # Get memory information (Linux-specific)
  memory_info <- tryCatch({
    if (file.exists("/proc/meminfo")) {
      meminfo <- readLines("/proc/meminfo")
      total_line <- grep("^MemTotal:", meminfo, value = TRUE)
      total_kb <- as.numeric(sub(".*: *([0-9]+).*", "\\1", total_line))
      total_gb <- round(total_kb / (1024^2), 2)
      
      list(
        total_gb = total_gb,
        total_kb = total_kb
      )
    } else {
      list(
        total_gb = NA,
        total_kb = NA
      )
    }
  }, error = function(e) {
    list(
      total_gb = NA,
      total_kb = NA
    )
  })
  
  # Get CPU frequency (Linux-specific)
  cpu_freq <- tryCatch({
    if (file.exists("/proc/cpuinfo")) {
      cpuinfo <- readLines("/proc/cpuinfo")
      freq_line <- grep("cpu MHz", cpuinfo, value = TRUE)[1]
      freq_mhz <- as.numeric(sub(".*: ", "", freq_line))
      freq_ghz <- round(freq_mhz / 1000, 2)
      
      list(
        mhz = freq_mhz,
        ghz = freq_ghz
      )
    } else {
      list(mhz = NA, ghz = NA)
    }
  }, error = function(e) {
    list(mhz = NA, ghz = NA)
  })
  
  # Get R version details
  r_version <- list(
    version = paste(R.version$major, R.version$minor, sep = "."),
    platform = R.version$platform,
    arch = R.version$arch,
    os = R.version$os,
    version_string = R.version.string
  )
  
  # Get key package versions
  packages <- list(
    base = as.character(packageVersion("base")),
    utils = as.character(packageVersion("utils")),
    stats = as.character(packageVersion("stats"))
  )
  
  # Add bench if available
  if (requireNamespace("bench", quietly = TRUE)) {
    packages$bench <- as.character(packageVersion("bench"))
  }
  
  # Add jsonlite if available
  if (requireNamespace("jsonlite", quietly = TRUE)) {
    packages$jsonlite <- as.character(packageVersion("jsonlite"))
  }
  
  # Add here if available
  if (requireNamespace("here", quietly = TRUE)) {
    packages$here <- as.character(packageVersion("here"))
  }
  
  # Compile all information
  system_info <- list(
    timestamp = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"),
    system = list(
      os = as.character(sys_info["sysname"]),
      release = as.character(sys_info["release"]),
      version = as.character(sys_info["version"]),
      nodename = as.character(sys_info["nodename"]),
      machine = as.character(sys_info["machine"])
    ),
    hardware = list(
      cpu = cpu_info,
      cpu_frequency = cpu_freq,
      memory = memory_info
    ),
    r_version = r_version,
    packages = packages
  )
  
  return(system_info)
}


#' Save System Information to JSON
#'
#' Collects and saves system information to a JSON file.
#'
#' @param output_path Character string. Path to save the JSON file.
#'   Default is here("results", "system_info.json")
#'
#' @export
save_system_info <- function(output_path = NULL) {
  # Load required packages
  if (!requireNamespace("jsonlite", quietly = TRUE)) {
    stop("Package 'jsonlite' is required. Install with: install.packages('jsonlite')")
  }
  if (!requireNamespace("here", quietly = TRUE)) {
    stop("Package 'here' is required. Install with: install.packages('here')")
  }
  
  # Set default output path using here
  if (is.null(output_path)) {
    output_path <- here::here("results", "system_info.json")
  }
  
  # Collect system information
  sys_info <- collect_system_info()
  
  # Ensure output directory exists
  output_dir <- dirname(output_path)
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  # Save to JSON
  jsonlite::write_json(
    sys_info,
    output_path,
    pretty = TRUE,
    auto_unbox = TRUE
  )
  
  message("System information saved to: ", output_path)
  
  return(sys_info)
}
