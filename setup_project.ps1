# Create base project directory
New-Item -Path "property-document-api" -ItemType Directory
Set-Location property-document-api

# Create virtual environment
python -m venv venv
.\venv\Scripts\Activate.ps1

# Install required packages
pip install fastapi uvicorn python-multipart python-dotenv supabase pydantic pydantic-settings pytest pytest-asyncio httpx

# Create project structure
New-Item -Path "src" -ItemType Directory
Set-Location src

# Create main directories
$directories = @(
    "api",
    "api/routes",
    "api/middlewares",
    "core",
    "domain",
    "domain/models",
    "domain/entities",
    "infrastructure",
    "infrastructure/database",
    "infrastructure/document_processing",
    "services",
    "utils",
    "tests",
    "tests/unit",
    "tests/integration",
    "tests/e2e",
    "logs"
)

foreach ($dir in $directories) {
    New-Item -Path $dir -ItemType Directory
}

# Create empty Python files
$pythonFiles = @(
    "api/__init__.py",
    "api/dependencies.py",
    "api/routes/__init__.py",
    "api/routes/health.py",
    "api/routes/document_processing.py",
    "core/__init__.py",
    "core/config.py",
    "core/logging.py",
    "domain/__init__.py",
    "domain/models/__init__.py",
    "domain/models/document.py",
    "domain/models/batch.py",
    "domain/entities/__init__.py",
    "domain/entities/contracts.py",
    "infrastructure/__init__.py",
    "infrastructure/database/__init__.py",
    "infrastructure/database/supabase_client.py",
    "infrastructure/document_processing/__init__.py",
    "infrastructure/document_processing/extractors.py",
    "infrastructure/document_processing/processors.py",
    "services/__init__.py",
    "services/document_service.py",
    "services/batch_service.py",
    "utils/__init__.py",
    "utils/address_standardizer.py",
    "tests/__init__.py",
    "tests/unit/__init__.py",
    "tests/unit/test_document_service.py",
    "tests/integration/__init__.py",
    "tests/integration/test_api_routes.py",
    "tests/e2e/__init__.py",
    "tests/e2e/test_document_processing.py",
    "main.py"
)

foreach ($file in $pythonFiles) {
    New-Item -Path $file -ItemType File
}

# Create requirements files
Set-Location ..
@"
fastapi==0.109.2
uvicorn==0.27.1
python-multipart==0.0.9
python-dotenv==1.0.1
supabase==2.3.1
pydantic==2.6.1
pydantic-settings==2.1.0
pytest==8.0.0
pytest-asyncio==0.23.5
httpx==0.26.0
"@ | Out-File -FilePath "requirements.txt" -Encoding utf8

@"
pytest==8.0.0
pytest-asyncio==0.23.5
black==24.1.1
flake8==7.0.0
mypy==1.8.0
isort==5.13.2
"@ | Out-File -FilePath "requirements-dev.txt" -Encoding utf8

# Create environment file template
@"
SUPABASE_URL=your_supabase_url
SUPABASE_KEY=your_supabase_key
TESSERACT_PATH=C:\Program Files\Tesseract-OCR\tesseract.exe
"@ | Out-File -FilePath ".env.example" -Encoding utf8

# Create gitignore
@"
venv/
__pycache__/
*.pyc
.env
.pytest_cache/
.coverage
htmlcov/
logs/
.idea/
.vscode/
"@ | Out-File -FilePath ".gitignore" -Encoding utf8

# Initialize git repository
git init
git add .
git commit -m "Initial project structure"