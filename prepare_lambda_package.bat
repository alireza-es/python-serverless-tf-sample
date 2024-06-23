@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Step 1: Create a virtual environment outside the src folder
python -m venv lambda_env

:: Step 2: Activate the virtual environment
call lambda_env\Scripts\activate

:: Step 3: Install dependencies from the requirements.txt file in the src directory
pip install -r src\requirements.txt

:: Step 5: Use PowerShell to compress the site-packages (dependencies) directly from the virtual environment and the src directory into a zip file
:: This approach flattens the directory structure, placing all files at the root of the zip file
powershell -Command "& { $src = 'src\*'; $deps = 'lambda_env\Lib\site-packages\*'; Compress-Archive -Path $src, $deps -DestinationPath lambda_package.zip -Force }"

:: Note: This PowerShell command ensures that both the dependencies from the site-packages directory and the src directory content are placed at the root of the zip file.
:: Adjust paths as necessary based on your directory structure.