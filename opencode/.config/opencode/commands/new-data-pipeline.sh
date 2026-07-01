#!/usr/bin/env bash
# Scaffold a new data engineering pipeline
# Usage: ./new-data-pipeline.sh [project_name]

PROJECT_NAME="${1:-.}"

if [[ "$PROJECT_NAME" == "." ]]; then
    PROJECT_NAME=$(basename "$PWD")
fi

echo "📊 Creating data pipeline: $PROJECT_NAME"

# Create directory structure
mkdir -p "$PROJECT_NAME"/{data,pipelines,sql,tests,config,logs}

# Create pipeline package
mkdir -p "$PROJECT_NAME/pipelines/$PROJECT_NAME"
touch "$PROJECT_NAME/pipelines/$PROJECT_NAME/__init__.py"

# Create pyproject.toml
cat > "$PROJECT_NAME/pyproject.toml" << 'EOF'
[build-system]
requires = ["setuptools>=65", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "PROJECT_NAME_HERE"
version = "0.1.0"
description = "Data pipeline"
dependencies = [
    "polars>=0.19",
    "duckdb>=0.9",
    "pydantic>=2.0",
    "prefect>=3.0",
    "great-expectations>=0.17",
    "python-dotenv>=1.0",
]
EOF

# Create config.yaml
cat > "$PROJECT_NAME/config/config.yaml" << 'EOF'
environment: development
log_level: INFO

database:
  type: duckdb
  path: ./data/warehouse.db

sources:
  - name: raw_data
    type: csv
    path: ./data/raw/

output:
  type: parquet
  path: ./data/processed/

validation:
  enabled: true
  strict: false
EOF

# Create example pipeline
cat > "$PROJECT_NAME/pipelines/$PROJECT_NAME/extract.py" << 'EOF'
"""Data extraction layer."""
from pathlib import Path
import polars as pl


def extract_csv(path: str) -> pl.DataFrame:
    """Extract data from CSV file."""
    return pl.read_csv(path)


def extract_parquet(path: str) -> pl.DataFrame:
    """Extract data from Parquet file."""
    return pl.read_parquet(path)
EOF

# Create .gitignore
cat > "$PROJECT_NAME/.gitignore" << 'EOF'
__pycache__/
*.py[cod]
*$py.class
*.egg-info/

venv/
env/
.venv/

.vscode/
.idea/

data/raw/*
data/processed/*
logs/
*.log

.DS_Store
.env
EOF

echo "✓ Data pipeline created at: $PROJECT_NAME"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  python -m venv venv"
echo "  source venv/bin/activate"
echo "  pip install -e ."
