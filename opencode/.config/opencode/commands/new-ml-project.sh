#!/usr/bin/env bash
# Scaffold a new ML project with best practices
# Usage: ./new-ml-project.sh [project_name]

PROJECT_NAME="${1:-.}"

if [[ "$PROJECT_NAME" == "." ]]; then
    PROJECT_NAME=$(basename "$PWD")
fi

echo "📁 Creating ML project: $PROJECT_NAME"

# Create directory structure
mkdir -p "$PROJECT_NAME"/{data,src,notebooks,configs,tests,logs}

# Create main Python package
mkdir -p "$PROJECT_NAME/src/$PROJECT_NAME"
touch "$PROJECT_NAME/src/$PROJECT_NAME/__init__.py"

# Create pyproject.toml
cat > "$PROJECT_NAME/pyproject.toml" << 'EOF'
[build-system]
requires = ["setuptools>=65", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "PROJECT_NAME_HERE"
version = "0.1.0"
description = "ML project"
dependencies = [
    "torch>=2.0",
    "numpy>=1.24",
    "pandas>=2.0",
    "scikit-learn>=1.3",
    "hydra-core>=1.3",
    "wandb>=0.15",
    "tqdm>=4.65",
]

[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = "test_*.py"

[tool.black]
line-length = 100
target-version = ['py310']

[tool.isort]
profile = "black"
line_length = 100
EOF

# Create README
cat > "$PROJECT_NAME/README.md" << 'EOF'
# PROJECT_NAME_HERE

ML project template with PyTorch, Hydra, and W&B.

## Setup

```bash
pip install -e .
```

## Structure

- `data/` - Raw and processed data
- `src/` - Source code
- `notebooks/` - Jupyter notebooks for exploration
- `configs/` - Hydra configuration files
- `tests/` - Unit tests
EOF

# Create requirements.txt
cat > "$PROJECT_NAME/requirements.txt" << 'EOF'
torch>=2.0.0
numpy>=1.24.0
pandas>=2.0.0
scikit-learn>=1.3.0
hydra-core>=1.3.0
wandb>=0.15.0
pytest>=7.0.0
pytest-cov>=4.0.0
black>=23.0.0
isort>=5.12.0
ruff>=0.1.0
EOF

# Create .gitignore
cat > "$PROJECT_NAME/.gitignore" << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.egg-info/
dist/
build/
.eggs/

# Virtual environments
venv/
env/
.venv/

# IDEs
.vscode/
.idea/
*.swp
*.swo
*~

# Jupyter
.ipynb_checkpoints/
.jupyter/

# Data and logs
data/raw/*
data/processed/*
logs/
outputs/
wandb/

# OS
.DS_Store
.env
EOF

echo "✓ ML project created at: $PROJECT_NAME"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  python -m venv venv"
echo "  source venv/bin/activate"
echo "  pip install -e ."
