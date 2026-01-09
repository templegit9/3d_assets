# Hunyuan3D-2.1 Setup Guide for macOS (Apple Silicon)

## Overview

This guide will help you set up and run Hunyuan3D-2.1 on your M5 MacBook Pro (16GB RAM). Hunyuan3D-2.1 generates high-fidelity 3D assets with production-ready PBR materials from images or text.

## ⚠️ Important Limitations on Apple Silicon

**Performance Considerations:**
- Hunyuan3D-2.1 is optimized for NVIDIA CUDA GPUs
- On Apple Silicon, it runs on **MPS (Metal Performance Shaders)** or **CPU**
- **Expected performance**: 5-10x slower than NVIDIA GPUs
- Generation time: **5-10 minutes per model** (vs 2-3 minutes on GPU)
- Some CUDA-specific optimizations will be disabled

**Memory Constraints:**
- Your M5 MacBook has 16GB unified memory (shared between CPU and GPU)
- The model requires significant memory for both shape and texture generation
- You may need to generate shape and texture separately for complex models

**Recommendation:**
- For production use, consider using the Windows version with your RTX 5070 Ti
- For experimentation and prototyping, the Mac version works fine

## Features

- **Image-to-3D**: Upload an image and generate a 3D model
- **Text-to-3D**: Create 3D models from text descriptions
- **PBR Materials**: Physically-based rendering with realistic textures
- **Interactive 3D Viewer**: Rotate and inspect generated models
- **Export Options**: Download models in various formats (GLB, OBJ, etc.)

## System Requirements

### Hardware
- ✅ **Mac**: M1, M2, M3, M4, or M5 (Apple Silicon)
- ✅ **RAM**: 16GB minimum (you have this!)
- **Storage**: At least 20GB free space

### Software Prerequisites
- **macOS**: 12.0 (Monterey) or later
- **Python 3.10** (required version)
- **Xcode Command Line Tools**
- **Homebrew** (recommended)

## Installation Steps

### 1. Install Xcode Command Line Tools

```bash
xcode-select --install
```

### 2. Install Python 3.10

Using Homebrew (recommended):
```bash
brew install python@3.10
```

Or download from python.org.

Verify installation:
```bash
python3.10 --version
```

### 3. Navigate to the Repository

```bash
cd /Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1
```

### 4. Run Setup Script

```bash
./setup_mac.sh
```

This will:
- Install PyTorch with MPS (Metal) support
- Install all compatible Python dependencies
- Build custom rasterizer (if possible)
- Compile mesh painter C++ extension
- Download RealESRGAN upscaling model

**Note**: The setup may take 15-25 minutes depending on your internet speed.

### 5. Verify Installation

After setup completes, you should see:
```
Setup completed!
```

## Running the Web App

### Start the Gradio Interface

```bash
./run_mac.sh
```

### First Run Notes

On the first run:
- **Model weights will download automatically** (about 5-6GB)
- This may take 5-10 minutes depending on your internet speed
- Models are cached locally, so subsequent runs will be faster

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
   - **Resolution**: Start with 512 (higher = slower on Mac)
   - **Guidance Scale**: Controls how closely the model follows the image
4. Click "Generate 3D Model"
5. **Wait patiently** (5-10 minutes for full generation on Apple Silicon)
6. View the 3D model in the interactive viewer
7. Download the model (GLB, OBJ, or FBX format)

### Text-to-3D Generation

1. Click the "Text" tab
2. Enter a detailed text description
3. Adjust settings (start with lower resolution for faster results)
4. Click "Generate 3D Model"
5. Wait for generation
6. View and download your model

### Tips for Best Results on Mac

- **Start with lower resolution** (256-512) to test, then use 1024 for final
- **Be patient**: Generation is significantly slower on Apple Silicon
- **Monitor Activity Monitor**: Watch memory usage and temperature
- **Close other apps**: Free up RAM for the model
- **Use clear, simple images**: Complex images may take longer or fail
- **Generate during off-hours**: Long generation times make this suitable for overnight runs

## Performance Optimization

### Memory Management

```bash
# Check available memory before running
vm_stat | grep "Pages free"

# Close memory-intensive apps
# Keep Activity Monitor open to watch usage
```

### Speed vs Quality Trade-offs

| Setting | Speed | Quality | Recommended For |
|---------|-------|---------|----------------|
| Resolution: 256 | Fastest (2-3 min) | Low | Testing |
| Resolution: 512 | Fast (5-7 min) | Good | Previews |
| Resolution: 1024 | Slow (10-15 min) | Best | Final output |

### Separate Shape and Texture Generation

If you run into memory issues, generate in two steps:
1. Generate shape only (save it)
2. Generate texture separately (apply to shape)

## Troubleshooting

### Setup Issues

**"Python 3.10 not found"**
```bash
brew install python@3.10
# Or download from python.org
```

**"xcode-select: command not found"**
```bash
# Install Xcode Command Line Tools
xcode-select --install
```

**"Failed to compile mesh painter"**
- Make sure Xcode Command Line Tools are installed
- Try reinstalling: `xcode-select --install`
- The app may still work without this component

**"cupy-cuda12x installation failed"**
- This is expected on Mac (CUDA is NVIDIA-only)
- The setup script filters this out automatically
- Safe to ignore

### Runtime Issues

**"MPS backend not available"**
- Update macOS to latest version
- PyTorch MPS requires macOS 12.0+
- Fallback to CPU will be used automatically

**"Out of memory"**
- Close other applications
- Lower resolution settings (256 or 512)
- Generate shape and texture separately
- Restart your Mac to free up memory

**"Generation is very slow"**
- This is normal on Apple Silicon
- Expected: 5-10 minutes per model
- Use lower resolution for faster results
- Consider using the Windows version for production

**"Model download failed"**
- Check internet connection
- Manually download from: https://huggingface.co/tencent/Hunyuan3D-2.1
- Place in: `~/.cache/huggingface/`

**"Temperature warnings / Fan noise"**
- Normal for intensive ML workloads
- Ensure good ventilation
- Use a laptop stand
- Consider external cooling

### Known Issues on Mac

1. **No CUDA acceleration** - MPS/CPU only
2. **Slower performance** - 5-10x slower than NVIDIA GPUs
3. **Memory constraints** - 16GB shared memory may limit complex models
4. **Some features may not work** - CUDA-specific optimizations disabled

## File Locations

- **Generated models**: `outputs/` directory
- **Model cache**: `~/.cache/huggingface/`
- **Temporary files**: `temp/` directory

## Advanced Usage

### Running with Environment Variables

```bash
# Enable MPS fallback to CPU when needed
export PYTORCH_ENABLE_MPS_FALLBACK=1

# Limit memory usage (in GB)
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.8

./run_mac.sh
```

### Custom Python Scripts

```python
import sys
import os

# Enable MPS fallback
os.environ['PYTORCH_ENABLE_MPS_FALLBACK'] = '1'

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

## Monitoring Performance

### Activity Monitor

Watch these metrics:
- **CPU**: Should be near 100% during generation
- **Memory**: Watch for memory pressure (keep in green zone)
- **GPU**: Metal GPU usage
- **Temperature**: Keep below 90°C

### Command Line Monitoring

```bash
# Watch CPU and memory usage
top -pid $(pgrep -f gradio_app.py)

# Monitor temperature (requires osx-cpu-temp)
brew install osx-cpu-temp
istats
```

## Stopping the Server

Press `Ctrl+C` in the terminal window to stop the Gradio server.

## Comparison: Mac vs Windows

| Feature | M5 Mac (16GB) | Windows RTX 5070 Ti (16GB) |
|---------|---------------|----------------------------|
| Backend | MPS/CPU | CUDA |
| Generation Time | 5-10 min | 2-3 min |
| Quality | Same | Same |
| Memory | Shared 16GB | 16GB VRAM + system RAM |
| Best For | Testing, learning | Production, fast iteration |

**Recommendation**: Use Mac for learning and experimentation, use Windows for production work.

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
5. Consider using the Windows version for better performance

---

**Remember**: This is an experimental setup. For best results, use the Windows version with your RTX 5070 Ti! 🚀
