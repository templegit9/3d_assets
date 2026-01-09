@echo off
echo ============================================
echo Hunyuan3D-2.1 Setup Script
echo ============================================
echo.

echo Step 1: Installing PyTorch with CUDA support...
pip install torch==2.5.1 torchvision==0.20.1 torchaudio==2.5.1 --index-url https://download.pytorch.org/whl/cu124
if %errorlevel% neq 0 (
    echo Failed to install PyTorch
    pause
    exit /b %errorlevel%
)
echo.

echo Step 2: Installing project requirements...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Failed to install requirements
    pause
    exit /b %errorlevel%
)
echo.

echo Step 3: Building custom rasterizer...
cd hy3dpaint\custom_rasterizer
pip install -e .
if %errorlevel% neq 0 (
    echo Failed to install custom rasterizer
    cd ..\..
    pause
    exit /b %errorlevel%
)
cd ..\..
echo.

echo Step 4: Compiling mesh painter...
cd hy3dpaint\DifferentiableRenderer
call compile_mesh_painter.bat
if %errorlevel% neq 0 (
    echo Failed to compile mesh painter
    cd ..\..
    pause
    exit /b %errorlevel%
)
cd ..\..
echo.

echo Step 5: Downloading RealESRGAN upscaling model...
if not exist "hy3dpaint\ckpt" mkdir hy3dpaint\ckpt
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth' -OutFile 'hy3dpaint\ckpt\RealESRGAN_x4plus.pth'}"
if %errorlevel% neq 0 (
    echo Failed to download RealESRGAN model
    echo You can download it manually from: https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth
    echo And place it in: hy3dpaint\ckpt\
    pause
    exit /b %errorlevel%
)
echo.

echo ============================================
echo Setup completed successfully!
echo ============================================
echo.
echo Next steps:
echo 1. Run 'run.bat' to start the Gradio web interface
echo 2. Open your browser to the URL shown in the console
echo 3. Upload an image to generate 3D assets
echo.
pause
