# Hunyuan3D-2.1 Local Setup Guide

## Overview

This guide will help you set up and run Hunyuan3D-2.1 locally on your Windows machine with RTX 5070 Ti. Hunyuan3D-2.1 generates high-fidelity 3D assets with production-ready PBR materials from images or text.

## Features

- **Image-to-3D**: Upload an image and generate a 3D model
- **Text-to-3D**: Create 3D models from text descriptions
- **PBR Materials**: Physically-based rendering with realistic textures
- **Interactive 3D Viewer**: Rotate and inspect generated models
- **Export Options**: Download models in various formats (GLB, OBJ, etc.)

## System Requirements

### Hardware
- **GPU**: NVIDIA RTX 5070 Ti (16GB VRAM) - ✅ You have this!
- **RAM**: 64GB - ✅ You have this!
- **Storage**: At least 20GB free space for models and dependencies

### Software Prerequisites
- **Windows 10/11**
- **Python 3.10** (required version)
- **CUDA 12.4** compatible NVIDIA drivers
- **Git** (already installed)
- **Microsoft Visual C++ Build Tools** (for compiling C++ extensions)
  - Download from: https://visualstudio.microsoft.com/visual-cpp-build-tools/
  - During installation, select "Desktop development with C++"

## Installation Steps

### 1. Verify Python Version

```bash
python --version
```

Should show Python 3.10.x. If not, download Python 3.10 from python.org.

### 2. Run Setup Script

The setup script will install all dependencies and build required components:

```bash
setup.bat
```

This will:
- Install PyTorch with CUDA 12.4 support
- Install all Python dependencies
- Build custom rasterizer
- Compile mesh painter (C++ extension)
- Download RealESRGAN upscaling model

**Note**: The setup may take 10-20 minutes depending on your internet speed.

### 3. Verify Installation

After setup completes, you should see:
```
Setup completed successfully!
```

## Running the Web App

### Start the Gradio Interface

Simply run:

```bash
run.bat
```

This starts the web interface with **low VRAM mode** optimized for your RTX 5070 Ti (16GB VRAM).

### First Run Notes

On the first run:
- **Model weights will download automatically** (about 5-6GB)
- This may take 5-10 minutes depending on your internet speed
- Models are cached locally, so subsequent runs will be much faster

### Access the Web Interface

Once the server starts, open your browser and go to:
```
http://localhost:7860
```

## Using the Web App

### Image-to-3D Generation

1. Click the "Image" tab
2. Upload an image (JPG, PNG)
3. Adjust settings:
   - **Resolution**: Higher = better quality but slower (512-1024)
   - **Guidance Scale**: Controls how closely the model follows the image
4. Click "Generate 3D Model"
5. Wait for generation (1-3 minutes for both shape and texture)
6. View the 3D model in the interactive viewer
7. Download the model (GLB, OBJ, or FBX format)

### Text-to-3D Generation

1. Click the "Text" tab
2. Enter a detailed text description (e.g., "a red sports car with chrome wheels")
3. Adjust settings similar to image-to-3D
4. Click "Generate 3D Model"
5. Wait for generation
6. View and download your model

### Tips for Best Results

- **Images**: Use clear, well-lit images with good contrast
- **Text Prompts**: Be specific and descriptive
- **Resolution**: Start with 512 for faster previews, use 1024 for final quality
- **Patience**: High-quality 3D generation takes time (1-3 minutes per model)

## Performance Notes

### VRAM Usage
- Shape generation: ~10GB VRAM
- Texture generation: ~21GB VRAM
- **Low VRAM mode** splits these operations to stay within your 16GB limit
- Expect slightly longer generation times with low VRAM mode

### Generation Times (Estimated)
- Shape only: 30-60 seconds
- Texture only: 60-90 seconds
- Full pipeline (shape + texture): 2-3 minutes

## Troubleshooting

### Setup Issues

**"Failed to install PyTorch"**
- Check your internet connection
- Try running setup.bat again
- Manually install: `pip install torch==2.5.1 torchvision==0.20.1 --index-url https://download.pytorch.org/whl/cu124`

**"Failed to compile mesh painter"**
- Install Visual C++ Build Tools from the link above
- Make sure to select "Desktop development with C++"
- Run setup.bat again

### Runtime Issues

**"CUDA out of memory"**
- Make sure you're using `run.bat` which enables low VRAM mode
- Close other GPU-intensive applications
- Reduce resolution settings in the web interface

**"Models not downloading"**
- Check your internet connection
- Models download from HuggingFace - ensure it's not blocked
- Manually download from: https://huggingface.co/tencent/Hunyuan3D-2.1

**"Generation is very slow"**
- This is normal for the first run while models cache
- Low VRAM mode is slightly slower but necessary for 16GB GPU
- Ensure no other applications are using the GPU

## File Locations

- **Generated models**: `outputs/` directory
- **Model cache**: `~/.cache/huggingface/`
- **Temporary files**: `temp/` directory

## Advanced Usage

### API Server

For programmatic access, you can run the API server:

```bash
python api_server.py --low_vram_mode
```

See `API_DOCUMENTATION.md` for details on API endpoints.

### Custom Python Scripts

```python
import sys
sys.path.insert(0, './hy3dshape')
sys.path.insert(0, './hy3dpaint')

from hy3dshape.pipelines import Hunyuan3DDiTFlowMatchingPipeline
from textureGenPipeline import Hunyuan3DPaintPipeline, Hunyuan3DPaintConfig

# Generate mesh from image
shape_pipeline = Hunyuan3DDiTFlowMatchingPipeline.from_pretrained('tencent/Hunyuan3D-2.1')
mesh_untextured = shape_pipeline(image='path/to/image.png')[0]

# Apply textures
paint_pipeline = Hunyuan3DPaintPipeline(Hunyuan3DPaintConfig(max_num_view=6, resolution=512))
mesh_textured = paint_pipeline(mesh_path, image_path='path/to/image.png')
```

## Stopping the Server

Press `Ctrl+C` in the command window to stop the Gradio server.

## Additional Resources

- **Official Documentation**: [Hunyuan3D README](README.md)
- **HuggingFace**: https://huggingface.co/tencent/Hunyuan3D-2.1
- **GitHub**: https://github.com/Tencent-Hunyuan/Hunyuan3D-2.1
- **Discord Community**: https://discord.gg/dNBrdrGGMa

## Support

If you encounter issues:
1. Check this guide's Troubleshooting section
2. Review the official README.md
3. Join the Discord community for help
4. Open an issue on GitHub

---

**Enjoy creating amazing 3D assets with Hunyuan3D-2.1!** 🎨✨
