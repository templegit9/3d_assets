@echo off
echo ============================================
echo Starting Hunyuan3D-2.1 Gradio Web Interface
echo ============================================
echo.
echo This will start a local web server with the 3D asset generation interface.
echo Low VRAM mode is enabled for RTX 5070 Ti (16GB VRAM).
echo.
echo The interface will be accessible at: http://localhost:7860
echo.
echo Press Ctrl+C to stop the server when done.
echo.

python gradio_app.py --model_path tencent/Hunyuan3D-2.1 --subfolder hunyuan3d-dit-v2-1 --texgen_model_path tencent/Hunyuan3D-2.1 --low_vram_mode

if %errorlevel% neq 0 (
    echo.
    echo ============================================
    echo ERROR: Failed to start Gradio app
    echo ============================================
    echo.
    echo Possible issues:
    echo 1. Setup not completed - run setup.bat first
    echo 2. Missing model files - they will download automatically on first run
    echo 3. CUDA/GPU not available - check NVIDIA drivers
    echo.
    pause
    exit /b %errorlevel%
)
