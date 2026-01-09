#!/bin/bash

echo "============================================"
echo "Hunyuan3D-2.1 Setup Script for macOS"
echo "============================================"
echo ""

# Check if Python 3.10 is available
if ! command -v python3.10 &> /dev/null; then
    echo "ERROR: Python 3.10 not found!"
    echo "Please install Python 3.10 from python.org or using Homebrew:"
    echo "  brew install python@3.10"
    exit 1
fi

echo "Using Python version:"
python3.10 --version
echo ""

echo "Step 1: Installing PyTorch with MPS (Metal) support..."
echo "Note: This is CPU/MPS version for Apple Silicon (no CUDA)"
pip3.10 install torch torchvision torchaudio
if [ $? -ne 0 ]; then
    echo "Failed to install PyTorch"
    exit 1
fi
echo ""

echo "Step 2: Installing project requirements..."
# Filter out CUDA-specific packages that won't work on Mac
grep -v "cupy-cuda12x" requirements.txt | grep -v "bpy==" > requirements_mac.txt
pip3.10 install -r requirements_mac.txt
if [ $? -ne 0 ]; then
    echo "Warning: Some packages may have failed to install"
    echo "This is expected for CUDA-specific packages"
fi
echo ""

echo "Step 3: Building custom rasterizer..."
cd hy3dpaint/custom_rasterizer
pip3.10 install -e .
if [ $? -ne 0 ]; then
    echo "Warning: Custom rasterizer installation failed"
    echo "The app may still work with reduced functionality"
fi
cd ../..
echo ""

echo "Step 4: Compiling mesh painter..."
cd hy3dpaint/DifferentiableRenderer
chmod +x compile_mesh_painter_mac.sh
bash compile_mesh_painter_mac.sh
if [ $? -ne 0 ]; then
    echo "Warning: Mesh painter compilation failed"
    echo "The app may still work with reduced functionality"
fi
cd ../..
echo ""

echo "Step 5: Downloading RealESRGAN upscaling model..."
mkdir -p hy3dpaint/ckpt
if [ ! -f "hy3dpaint/ckpt/RealESRGAN_x4plus.pth" ]; then
    curl -L "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth" \
         -o "hy3dpaint/ckpt/RealESRGAN_x4plus.pth"
    if [ $? -ne 0 ]; then
        echo "Failed to download RealESRGAN model"
        echo "You can download it manually from:"
        echo "https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth"
        echo "And place it in: hy3dpaint/ckpt/"
    fi
else
    echo "RealESRGAN model already exists, skipping download"
fi
echo ""

echo "============================================"
echo "Setup completed!"
echo "============================================"
echo ""
echo "IMPORTANT NOTES FOR APPLE SILICON:"
echo "1. This uses MPS (Metal) backend, not CUDA"
echo "2. Performance will be slower than NVIDIA GPUs"
echo "3. Some CUDA-specific optimizations are disabled"
echo "4. Generation may take 5-10 minutes per model"
echo ""
echo "Next steps:"
echo "1. Run './run_mac.sh' to start the Gradio web interface"
echo "2. Open your browser to the URL shown in the console"
echo "3. Upload an image to generate 3D assets"
echo ""
echo "For troubleshooting, see SETUP_GUIDE_MAC.md"
echo ""
