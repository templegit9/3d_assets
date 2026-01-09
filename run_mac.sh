#!/bin/bash

echo "============================================"
echo "Starting Hunyuan3D-2.1 Gradio Web Interface"
echo "============================================"
echo ""
echo "Running on Apple Silicon (M5) with MPS backend"
echo "Note: This will be slower than NVIDIA GPUs"
echo ""
echo "The interface will be accessible at: http://localhost:7860"
echo ""
echo "Press Ctrl+C to stop the server when done."
echo ""

# Set environment variables for Apple Silicon
export PYTORCH_ENABLE_MPS_FALLBACK=1

# Run with CPU/MPS backend (no CUDA)
python3.10 gradio_app.py \
  --model_path tencent/Hunyuan3D-2.1 \
  --subfolder hunyuan3d-dit-v2-1 \
  --texgen_model_path tencent/Hunyuan3D-2.1

# Note: Removed --low_vram_mode as it's CUDA-specific
# MPS memory management is handled differently by PyTorch

if [ $? -ne 0 ]; then
    echo ""
    echo "============================================"
    echo "ERROR: Failed to start Gradio app"
    echo "============================================"
    echo ""
    echo "Possible issues:"
    echo "1. Setup not completed - run ./setup_mac.sh first"
    echo "2. Missing model files - they will download automatically on first run"
    echo "3. Python 3.10 not found - check installation"
    echo ""
    echo "For more help, see SETUP_GUIDE_MAC.md"
    exit 1
fi
