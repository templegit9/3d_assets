@echo off
echo Compiling mesh inpaint processor...
echo.
echo NOTE: This requires Microsoft Visual C++ Build Tools installed
echo If compilation fails, you may need to install Visual Studio Build Tools from:
echo https://visualstudio.microsoft.com/visual-cpp-build-tools/
echo.

REM Try to compile using the Python build system
python -c "import pybind11; print('pybind11 found')" 2>nul
if %errorlevel% neq 0 (
    echo ERROR: pybind11 not found. Please ensure requirements.txt is installed.
    exit /b 1
)

REM For Windows, we'll use setuptools to compile
python -c "import setuptools; from setuptools import setup, Extension; import pybind11; ext = Extension('mesh_inpaint_processor', sources=['mesh_inpaint_processor.cpp'], include_dirs=[pybind11.get_include()], language='c++', extra_compile_args=['/O2', '/std:c++11']); setup(name='mesh_inpaint_processor', ext_modules=[ext])" build_ext --inplace

if %errorlevel% equ 0 (
    echo Compilation successful!
) else (
    echo.
    echo WARNING: Compilation may have failed. If you encounter errors when running the app,
    echo you may need to install Microsoft Visual C++ Build Tools and try again.
    echo.
    echo The app might still work if pre-compiled binaries are available.
)
