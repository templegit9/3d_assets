#!/bin/bash

echo "Compiling mesh inpaint processor for macOS..."
echo ""

# Check if pybind11 is available
python3.10 -c "import pybind11; print('pybind11 found at:', pybind11.get_include())" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "ERROR: pybind11 not found. Please ensure requirements are installed."
    exit 1
fi

# Get Python includes and extension suffix
PYTHON_INCLUDES=$(python3.10 -m pybind11 --includes)
EXTENSION_SUFFIX=$(python3.10-config --extension-suffix)

echo "Python includes: $PYTHON_INCLUDES"
echo "Extension suffix: $EXTENSION_SUFFIX"
echo ""

# Compile using clang (default on macOS)
echo "Compiling with clang..."
c++ -O3 -Wall -shared -std=c++11 -fPIC \
    $PYTHON_INCLUDES \
    mesh_inpaint_processor.cpp \
    -o mesh_inpaint_processor${EXTENSION_SUFFIX} \
    -undefined dynamic_lookup

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Compilation successful!"
    echo "Created: mesh_inpaint_processor${EXTENSION_SUFFIX}"
else
    echo ""
    echo "⚠️  Compilation failed!"
    echo ""
    echo "Troubleshooting:"
    echo "1. Make sure Xcode Command Line Tools are installed:"
    echo "   xcode-select --install"
    echo "2. Check that pybind11 is properly installed"
    echo "3. The app might still work if this component isn't critical"
    exit 1
fi
