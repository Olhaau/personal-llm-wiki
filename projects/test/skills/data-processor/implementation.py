"""
DataProcessor Skill Implementation

This module demonstrates an exemplary skill for opencode.ai, showcasing modular,
reusable data processing capabilities with comprehensive functionality.
"""

import pandas as pd
import numpy as np
import json
import yaml
from typing import Dict, List, Optional, Any, Union
from dataclasses import dataclass, field
from pathlib import Path
import logging
from abc import ABC, abstractmethod


@dataclass
class ProcessingResult:
    """Result of data processing operation."""

    success: bool
    data: Optional[Any] = None
    metadata: Dict[str, Any] = field(default_factory=dict)
    metrics: Dict[str, Any] = field(default_factory=dict)
    errors: List[str] = field(default_factory=list)
    warnings: List[str] = field(default_factory=list)


@dataclass
class ProcessingConfig:
    """Configuration for data processing operations."""

    strict_mode: bool = True
    null_handling: str = "drop"  # drop, fill, raise
    type_coercion: bool = True
    chunk_size: int = 10000
    parallel_processing: bool = True
    memory_optimization: bool = True
    decimal_places: int = 2
    date_format: str = "YYYY-MM-DD"
    include_metadata: bool = True


class DataProcessor:
    """
    Exemplary skill demonstrating comprehensive data processing capabilities.

    This skill showcases the power of modular, reusable components in opencode.ai
    through intelligent data transformation, validation, and analysis.
    """

    def __init__(self, config: Optional[ProcessingConfig] = None):
        """Initialize the DataProcessor skill with configuration."""
        self.config = config or ProcessingConfig()
        self.logger = self._setup_logging()
        self.processors = self._initialize_processors()

    def _setup_logging(self) -> logging.Logger:
        """Setup logging for the skill."""
        logger = logging.getLogger(f"{__name__}.DataProcessor")
        logger.setLevel(logging.INFO)
        if not logger.handlers:
            handler = logging.StreamHandler()
            formatter = logging.Formatter(
                "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
            )
            handler.setFormatter(formatter)
            logger.addHandler(handler)
        return logger

    def _initialize_processors(self) -> Dict[str, Any]:
        """Initialize specialized processing components."""
        return {
            "csv": CSVProcessor(self.config),
            "json": JSONProcessor(self.config),
            "excel": ExcelProcessor(self.config),
            "validator": DataValidator(self.config),
            "analyzer": DataAnalyzer(self.config),
            "transformer": DataTransformer(self.config),
        }

    def load_data(
        self, source: Union[str, Path], format_type: Optional[str] = None
    ) -> ProcessingResult:
        """
        Load data from various sources and formats.

        Args:
            source: Path to data file or URL
            format_type: Explicit format type (csv, json, excel, etc.)

        Returns:
            ProcessingResult with loaded data and metadata
        """
        try:
            source_path = Path(source) if isinstance(source, str) else source

            # Auto-detect format if not specified
            if format_type is None:
                format_type = self._detect_format(source_path)

            self.logger.info(f"Loading {format_type} data from {source}")

            # Use appropriate processor
            if format_type in self.processors:
                processor = self.processors[format_type]
                result = processor.load(source_path)
            else:
                raise ValueError(f"Unsupported format: {format_type}")

            if result.success:
                self.logger.info(f"Successfully loaded {len(result.data)} records")
                result.metadata.update(
                    {
                        "source": str(source),
                        "format": format_type,
                        "load_timestamp": pd.Timestamp.now().isoformat(),
                        "record_count": len(result.data)
                        if hasattr(result.data, "__len__")
                        else None,
                    }
                )

            return result

        except Exception as e:
            self.logger.error(f"Failed to load data: {str(e)}")
            return ProcessingResult(success=False, errors=[f"Load error: {str(e)}"])

    def validate_data(
        self, data: pd.DataFrame, rules: Optional[Dict[str, Any]] = None
    ) -> ProcessingResult:
        """
        Validate data quality and integrity.

        Args:
            data: DataFrame to validate
            rules: Custom validation rules

        Returns:
            ProcessingResult with validation results
        """
        try:
            self.logger.info("Starting data validation")

            validator = self.processors["validator"]
            result = validator.validate(data, rules)

            if result.success:
                self.logger.info("Data validation completed successfully")
            else:
                self.logger.warning(f"Validation issues found: {len(result.errors)}")

            return result

        except Exception as e:
            self.logger.error(f"Validation failed: {str(e)}")
            return ProcessingResult(
                success=False, errors=[f"Validation error: {str(e)}"]
            )

    def clean_data(
        self, data: pd.DataFrame, operations: Optional[List[str]] = None
    ) -> ProcessingResult:
        """
        Clean and preprocess data.

        Args:
            data: DataFrame to clean
            operations: List of cleaning operations to perform

        Returns:
            ProcessingResult with cleaned data
        """
        try:
            self.logger.info("Starting data cleaning")

            transformer = self.processors["transformer"]
            result = transformer.clean(data, operations)

            if result.success:
                original_rows = len(data)
                cleaned_rows = len(result.data)
                self.logger.info(
                    f"Cleaning complete: {original_rows} -> {cleaned_rows} rows"
                )

                result.metrics.update(
                    {
                        "original_rows": original_rows,
                        "cleaned_rows": cleaned_rows,
                        "rows_removed": original_rows - cleaned_rows,
                        "removal_rate": (original_rows - cleaned_rows) / original_rows,
                    }
                )

            return result

        except Exception as e:
            self.logger.error(f"Data cleaning failed: {str(e)}")
            return ProcessingResult(success=False, errors=[f"Cleaning error: {str(e)}"])

    def transform_data(
        self, data: pd.DataFrame, transformations: Dict[str, Any]
    ) -> ProcessingResult:
        """
        Apply transformations to data.

        Args:
            data: DataFrame to transform
            transformations: Dictionary of transformation specifications

        Returns:
            ProcessingResult with transformed data
        """
        try:
            self.logger.info("Applying data transformations")

            transformer = self.processors["transformer"]
            result = transformer.transform(data, transformations)

            if result.success:
                self.logger.info("Transformations applied successfully")
                result.metadata["transformations_applied"] = list(
                    transformations.keys()
                )

            return result

        except Exception as e:
            self.logger.error(f"Transformation failed: {str(e)}")
            return ProcessingResult(
                success=False, errors=[f"Transformation error: {str(e)}"]
            )

    def analyze_data(
        self, data: pd.DataFrame, analysis_type: str = "comprehensive"
    ) -> ProcessingResult:
        """
        Perform statistical analysis on data.

        Args:
            data: DataFrame to analyze
            analysis_type: Type of analysis (basic, comprehensive, custom)

        Returns:
            ProcessingResult with analysis results
        """
        try:
            self.logger.info(f"Starting {analysis_type} data analysis")

            analyzer = self.processors["analyzer"]
            result = analyzer.analyze(data, analysis_type)

            if result.success:
                self.logger.info("Analysis completed successfully")

            return result

        except Exception as e:
            self.logger.error(f"Analysis failed: {str(e)}")
            return ProcessingResult(success=False, errors=[f"Analysis error: {str(e)}"])

    def export_data(
        self, data: pd.DataFrame, formats: List[str], destination: Union[str, Path]
    ) -> ProcessingResult:
        """
        Export data to multiple formats.

        Args:
            data: DataFrame to export
            formats: List of export formats (csv, xlsx, json, parquet)
            destination: Output directory or file path

        Returns:
            ProcessingResult with export information
        """
        try:
            self.logger.info(f"Exporting data to {len(formats)} formats")

            destination_path = Path(destination)
            destination_path.mkdir(parents=True, exist_ok=True)

            exported_files = []

            for format_type in formats:
                if format_type == "csv":
                    file_path = destination_path / "data.csv"
                    data.to_csv(file_path, index=False)
                elif format_type == "xlsx":
                    file_path = destination_path / "data.xlsx"
                    data.to_excel(file_path, index=False)
                elif format_type == "json":
                    file_path = destination_path / "data.json"
                    data.to_json(file_path, orient="records", indent=2)
                elif format_type == "parquet":
                    file_path = destination_path / "data.parquet"
                    data.to_parquet(file_path, index=False)
                else:
                    self.logger.warning(f"Unsupported export format: {format_type}")
                    continue

                exported_files.append(str(file_path))
                self.logger.info(f"Exported {format_type} to {file_path}")

            return ProcessingResult(
                success=True,
                data=exported_files,
                metadata={
                    "export_timestamp": pd.Timestamp.now().isoformat(),
                    "formats_exported": formats,
                    "total_files": len(exported_files),
                },
            )

        except Exception as e:
            self.logger.error(f"Export failed: {str(e)}")
            return ProcessingResult(success=False, errors=[f"Export error: {str(e)}"])

    def process_pipeline(
        self, source: Union[str, Path], pipeline: List[Dict[str, Any]]
    ) -> ProcessingResult:
        """
        Execute a complete data processing pipeline.

        Args:
            source: Data source path
            pipeline: List of processing steps with parameters

        Returns:
            ProcessingResult with final processed data
        """
        try:
            self.logger.info(f"Starting processing pipeline with {len(pipeline)} steps")

            # Load initial data
            current_result = self.load_data(source)
            if not current_result.success:
                return current_result

            data = current_result.data
            pipeline_metadata = []

            # Execute each pipeline step
            for i, step in enumerate(pipeline):
                step_name = step.get("operation", f"step_{i}")
                self.logger.info(f"Executing step {i + 1}/{len(pipeline)}: {step_name}")

                if step_name == "validate":
                    result = self.validate_data(data, step.get("parameters", {}))
                elif step_name == "clean":
                    result = self.clean_data(data, step.get("operations"))
                elif step_name == "transform":
                    result = self.transform_data(data, step.get("transformations", {}))
                elif step_name == "analyze":
                    result = self.analyze_data(data, step.get("analysis_type", "basic"))
                else:
                    raise ValueError(f"Unknown pipeline step: {step_name}")

                if not result.success:
                    self.logger.error(f"Pipeline failed at step {step_name}")
                    return result

                # Update data for next step (if applicable)
                if hasattr(result, "data") and result.data is not None:
                    data = result.data

                pipeline_metadata.append(
                    {
                        "step": step_name,
                        "parameters": step.get("parameters", {}),
                        "metrics": result.metrics,
                    }
                )

            self.logger.info("Processing pipeline completed successfully")

            return ProcessingResult(
                success=True,
                data=data,
                metadata={
                    "pipeline_steps": len(pipeline),
                    "execution_timestamp": pd.Timestamp.now().isoformat(),
                    "step_details": pipeline_metadata,
                },
            )

        except Exception as e:
            self.logger.error(f"Pipeline execution failed: {str(e)}")
            return ProcessingResult(success=False, errors=[f"Pipeline error: {str(e)}"])

    def get_capabilities(self) -> Dict[str, Any]:
        """Return skill capabilities and configuration."""
        return {
            "name": "DataProcessor",
            "version": "1.0.0",
            "capabilities": [
                "data_loading",
                "data_validation",
                "data_cleaning",
                "data_transformation",
                "data_analysis",
                "multi_format_export",
                "pipeline_processing",
            ],
            "supported_formats": ["csv", "json", "excel", "parquet"],
            "configuration": {
                "strict_mode": self.config.strict_mode,
                "null_handling": self.config.null_handling,
                "chunk_size": self.config.chunk_size,
                "parallel_processing": self.config.parallel_processing,
            },
        }

    # Private helper methods

    def _detect_format(self, file_path: Path) -> str:
        """Auto-detect file format from extension."""
        extension = file_path.suffix.lower()
        format_map = {
            ".csv": "csv",
            ".json": "json",
            ".xlsx": "excel",
            ".xls": "excel",
            ".parquet": "parquet",
        }
        return format_map.get(extension, "unknown")


# Specialized processor classes


class BaseProcessor(ABC):
    """Base class for all data processors."""

    def __init__(self, config: ProcessingConfig):
        self.config = config

    @abstractmethod
    def load(self, source: Path) -> ProcessingResult:
        """Load data from source."""
        pass


class CSVProcessor(BaseProcessor):
    """Processor for CSV files."""

    def load(self, source: Path) -> ProcessingResult:
        """Load CSV data."""
        try:
            data = pd.read_csv(source, encoding="utf-8")
            return ProcessingResult(
                success=True, data=data, metadata={"format": "csv", "encoding": "utf-8"}
            )
        except Exception as e:
            return ProcessingResult(success=False, errors=[f"CSV load error: {str(e)}"])


class JSONProcessor(BaseProcessor):
    """Processor for JSON files."""

    def load(self, source: Path) -> ProcessingResult:
        """Load JSON data."""
        try:
            with open(source, "r", encoding="utf-8") as f:
                json_data = json.load(f)

            # Convert to DataFrame if possible
            if isinstance(json_data, list):
                data = pd.DataFrame(json_data)
            elif isinstance(json_data, dict):
                data = pd.DataFrame([json_data])
            else:
                data = json_data

            return ProcessingResult(
                success=True,
                data=data,
                metadata={"format": "json", "original_type": type(json_data).__name__},
            )
        except Exception as e:
            return ProcessingResult(
                success=False, errors=[f"JSON load error: {str(e)}"]
            )


class ExcelProcessor(BaseProcessor):
    """Processor for Excel files."""

    def load(self, source: Path) -> ProcessingResult:
        """Load Excel data."""
        try:
            # Load first sheet by default
            data = pd.read_excel(source, sheet_name=0)

            # Get all sheet names for metadata
            with pd.ExcelFile(source) as xl:
                sheet_names = xl.sheet_names

            return ProcessingResult(
                success=True,
                data=data,
                metadata={
                    "format": "excel",
                    "sheet_names": sheet_names,
                    "loaded_sheet": sheet_names[0] if sheet_names else None,
                },
            )
        except Exception as e:
            return ProcessingResult(
                success=False, errors=[f"Excel load error: {str(e)}"]
            )


class DataValidator:
    """Data validation component."""

    def __init__(self, config: ProcessingConfig):
        self.config = config

    def validate(
        self, data: pd.DataFrame, rules: Optional[Dict[str, Any]] = None
    ) -> ProcessingResult:
        """Validate data quality."""
        try:
            errors = []
            warnings = []
            metrics = {}

            # Basic validation
            metrics["total_rows"] = len(data)
            metrics["total_columns"] = len(data.columns)
            metrics["null_count"] = data.isnull().sum().sum()
            metrics["null_percentage"] = (
                metrics["null_count"] / (len(data) * len(data.columns))
            ) * 100

            # Check for empty DataFrame
            if data.empty:
                errors.append("DataFrame is empty")

            # Check null values
            if metrics["null_percentage"] > 50:
                warnings.append(
                    f"High null percentage: {metrics['null_percentage']:.2f}%"
                )

            # Custom validation rules
            if rules:
                for rule_name, rule_config in rules.items():
                    # Implement custom rules here
                    pass

            return ProcessingResult(
                success=len(errors) == 0,
                data=data,
                metrics=metrics,
                errors=errors,
                warnings=warnings,
            )

        except Exception as e:
            return ProcessingResult(
                success=False, errors=[f"Validation error: {str(e)}"]
            )


class DataTransformer:
    """Data transformation component."""

    def __init__(self, config: ProcessingConfig):
        self.config = config

    def clean(
        self, data: pd.DataFrame, operations: Optional[List[str]] = None
    ) -> ProcessingResult:
        """Clean data using specified operations."""
        try:
            cleaned_data = data.copy()
            applied_operations = []

            # Default cleaning operations
            if operations is None:
                operations = ["remove_duplicates", "handle_nulls", "trim_strings"]

            for operation in operations:
                if operation == "remove_duplicates":
                    before_count = len(cleaned_data)
                    cleaned_data = cleaned_data.drop_duplicates()
                    applied_operations.append(
                        f"Removed {before_count - len(cleaned_data)} duplicates"
                    )

                elif operation == "handle_nulls":
                    if self.config.null_handling == "drop":
                        before_count = len(cleaned_data)
                        cleaned_data = cleaned_data.dropna()
                        applied_operations.append(
                            f"Dropped {before_count - len(cleaned_data)} rows with nulls"
                        )
                    elif self.config.null_handling == "fill":
                        # Fill with appropriate values based on data type
                        for col in cleaned_data.columns:
                            if cleaned_data[col].dtype == "object":
                                cleaned_data[col].fillna("Unknown", inplace=True)
                            else:
                                cleaned_data[col].fillna(
                                    cleaned_data[col].mean(), inplace=True
                                )
                        applied_operations.append("Filled null values")

                elif operation == "trim_strings":
                    for col in cleaned_data.select_dtypes(include=["object"]).columns:
                        cleaned_data[col] = cleaned_data[col].astype(str).str.strip()
                    applied_operations.append("Trimmed string columns")

            return ProcessingResult(
                success=True,
                data=cleaned_data,
                metadata={"operations_applied": applied_operations},
            )

        except Exception as e:
            return ProcessingResult(success=False, errors=[f"Cleaning error: {str(e)}"])

    def transform(
        self, data: pd.DataFrame, transformations: Dict[str, Any]
    ) -> ProcessingResult:
        """Apply transformations to data."""
        try:
            transformed_data = data.copy()
            applied_transformations = []

            for transform_type, params in transformations.items():
                if transform_type == "normalize":
                    # Normalize numeric columns
                    numeric_cols = transformed_data.select_dtypes(
                        include=[np.number]
                    ).columns
                    transformed_data[numeric_cols] = (
                        transformed_data[numeric_cols]
                        - transformed_data[numeric_cols].mean()
                    ) / transformed_data[numeric_cols].std()
                    applied_transformations.append("Normalized numeric columns")

                elif transform_type == "encode_categorical":
                    # One-hot encode categorical columns
                    categorical_cols = transformed_data.select_dtypes(
                        include=["object"]
                    ).columns
                    transformed_data = pd.get_dummies(
                        transformed_data, columns=categorical_cols
                    )
                    applied_transformations.append("Encoded categorical columns")

                elif transform_type == "date_parsing":
                    # Parse date columns
                    date_cols = params.get("columns", [])
                    for col in date_cols:
                        if col in transformed_data.columns:
                            transformed_data[col] = pd.to_datetime(
                                transformed_data[col]
                            )
                    applied_transformations.append(f"Parsed date columns: {date_cols}")

            return ProcessingResult(
                success=True,
                data=transformed_data,
                metadata={"transformations_applied": applied_transformations},
            )

        except Exception as e:
            return ProcessingResult(
                success=False, errors=[f"Transformation error: {str(e)}"]
            )


class DataAnalyzer:
    """Data analysis component."""

    def __init__(self, config: ProcessingConfig):
        self.config = config

    def analyze(
        self, data: pd.DataFrame, analysis_type: str = "comprehensive"
    ) -> ProcessingResult:
        """Perform statistical analysis on data."""
        try:
            analysis_results = {}

            if analysis_type in ["basic", "comprehensive"]:
                # Basic descriptive statistics
                analysis_results["descriptive_stats"] = data.describe().to_dict()
                analysis_results["data_types"] = data.dtypes.to_dict()
                analysis_results["shape"] = data.shape
                analysis_results["null_counts"] = data.isnull().sum().to_dict()

            if analysis_type == "comprehensive":
                # Additional comprehensive analysis
                numeric_data = data.select_dtypes(include=[np.number])
                if not numeric_data.empty:
                    analysis_results["correlation_matrix"] = (
                        numeric_data.corr().to_dict()
                    )
                    analysis_results["skewness"] = numeric_data.skew().to_dict()
                    analysis_results["kurtosis"] = numeric_data.kurtosis().to_dict()

                # Categorical analysis
                categorical_data = data.select_dtypes(include=["object"])
                if not categorical_data.empty:
                    categorical_stats = {}
                    for col in categorical_data.columns:
                        categorical_stats[col] = {
                            "unique_count": data[col].nunique(),
                            "most_frequent": data[col].mode().iloc[0]
                            if not data[col].mode().empty
                            else None,
                            "value_counts": data[col].value_counts().head().to_dict(),
                        }
                    analysis_results["categorical_stats"] = categorical_stats

            return ProcessingResult(
                success=True,
                data=analysis_results,
                metadata={"analysis_type": analysis_type},
            )

        except Exception as e:
            return ProcessingResult(success=False, errors=[f"Analysis error: {str(e)}"])


# Example usage and demonstration
if __name__ == "__main__":
    # Initialize the skill
    config = ProcessingConfig(strict_mode=True, null_handling="drop", chunk_size=5000)

    processor = DataProcessor(config)

    # Display capabilities
    print("DataProcessor Skill Capabilities:")
    capabilities = processor.get_capabilities()
    for key, value in capabilities.items():
        print(f"  {key}: {value}")

    # Example processing pipeline
    pipeline = [
        {"operation": "validate", "parameters": {}},
        {"operation": "clean", "operations": ["remove_duplicates", "handle_nulls"]},
        {"operation": "analyze", "analysis_type": "comprehensive"},
    ]

    print(f"\nExample processing pipeline with {len(pipeline)} steps:")
    for i, step in enumerate(pipeline):
        print(f"  {i + 1}. {step['operation']}")

    print("\nDataProcessor skill ready for integration with opencode.ai agents!")
