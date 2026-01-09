# 🚀 Mac Deployment Guide - Step by Step

Complete deployment instructions for Hunyuan3D-2.1 on your M5 MacBook Pro (16GB RAM).

---

## 📋 Pre-Deployment Checklist

Before you start, ensure you have:
- ✅ M5 MacBook Pro with 16GB RAM (you have this!)
- ✅ macOS 12.0 (Monterey) or later
- ✅ Stable internet connection (for downloading ~5-6GB of models)
- ✅ At least 20GB free disk space
- ⏰ About 30-45 minutes total time

---

## 🎯 Deployment Steps

### Step 1: Install Xcode Command Line Tools (5 minutes)

Open Terminal and run:

```bash
xcode-select --install
```

**What happens:**
- A popup window will appear
- Click "Install"
- Wait for download and installation to complete
- This provides essential build tools (gcc, clang, make)

**Verify installation:**
```bash
xcode-select -p
```

Should output: `/Library/Developer/CommandLineTools` or similar

**Troubleshooting:**
- If already installed: "command line tools are already installed"
- If popup doesn't appear: Update macOS first

---

### Step 2: Install Python 3.10 (5-10 minutes)

#### Option A: Using Homebrew (Recommended)

First, install Homebrew if you don't have it:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install Python 3.10:
```bash
brew install python@3.10
```

#### Option B: Direct Download

1. Go to https://www.python.org/downloads/
2. Download Python 3.10.x for macOS
3. Run the installer
4. Follow the installation wizard

**Verify installation:**
```bash
python3.10 --version
```

Should output: `Python 3.10.x`

**Troubleshooting:**
- If `python3.10` not found: Restart Terminal
- Check PATH: `echo $PATH | grep python`
- Try `python3 --version` (might be 3.10)

---

### Step 3: Navigate to Repository (1 minute)

```bash
cd /Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1
```

**Verify you're in the right place:**
```bash
ls -la setup_mac.sh
```

Should show the setup script file.

---

### Step 4: Make Scripts Executable (1 minute)

```bash
chmod +x setup_mac.sh run_mac.sh
chmod +x hy3dpaint/DifferentiableRenderer/compile_mesh_painter_mac.sh
```

**What this does:**
- Gives execute permissions to the shell scripts
- Allows you to run them with `./script_name.sh`

**Verify:**
```bash
ls -la *.sh
```

Should show `-rwxr-xr-x` (x means executable)

---

### Step 5: Run Setup Script (15-25 minutes)

```bash
./setup_mac.sh
```

**What happens (in order):**

1. **PyTorch Installation** (~5 minutes)
   - Downloads and installs PyTorch with MPS support
   - ~2GB download
   - Watch for: "Successfully installed torch..."

2. **Dependencies Installation** (~5-10 minutes)
   - Installs ~40 Python packages
   - Some may show warnings (CUDA packages) - this is normal
   - Watch for: Package installation progress

3. **Custom Rasterizer Build** (~2 minutes)
   - Compiles custom 3D rendering code
   - May show compilation warnings - usually safe to ignore
   - Watch for: "Successfully installed" or "Finished"

4. **Mesh Painter Compilation** (~2 minutes)
   - Compiles C++ extension for mesh processing
   - Watch for: "✅ Compilation successful!"
   - If fails: App may still work (feature is optional)

5. **Model Download** (~3-5 minutes)
   - Downloads RealESRGAN upscaling model (~65MB)
   - Watch for: Download progress bar

**Success message:**
```
============================================
Setup completed!
============================================
```

**If you see errors:**
- Python package conflicts: Usually safe, continue
- Compilation failures: Note them, but try running anyway
- Download failures: Check internet connection

**Common Issues:**

**"Python 3.10 not found"**
```bash
# Check if it's installed as python3
python3 --version

# If 3.10.x, use python3 instead:
# Edit setup_mac.sh and replace "python3.10" with "python3"
```

**"pybind11 not found during compilation"**
- This means custom rasterizer failed
- App should still work, continue to next step

**"No space left on device"**
- Free up disk space (need ~20GB)
- Delete unnecessary files
- Empty Trash

---

### Step 6: Run the Application (First time: 5-10 minutes)

```bash
./run_mac.sh
```

**What happens on first run:**

1. **Environment Setup** (~10 seconds)
   - Sets MPS fallback environment variable
   - Initializes PyTorch

2. **Model Download** (~5-10 minutes, FIRST RUN ONLY)
   - Downloads Hunyuan3D-2.1 models (~5-6GB)
   - Shows progress: "Downloading hunyuan3d-dit-v2-1..."
   - Models cache to: `~/.cache/huggingface/`
   - **Be patient! This is a one-time download**

3. **Server Startup** (~30 seconds)
   - Initializes Gradio web server
   - Loads models into memory
   - Watch for: "Running on local URL: http://127.0.0.1:7860"

**Success looks like:**
```
============================================
Starting Hunyuan3D-2.1 Gradio Web Interface
============================================

Running on Apple Silicon (M5) with MPS backend
Note: This will be slower than NVIDIA GPUs

The interface will be accessible at: http://localhost:7860

Running on local URL:  http://127.0.0.1:7860

To create a public link, set `share=True` in `launch()`.
```

**Troubleshooting:**

**"ModuleNotFoundError: No module named 'torch'"**
- Setup didn't complete properly
- Run `./setup_mac.sh` again

**"MPS backend not available"**
- macOS version too old (need 12.0+)
- Will fallback to CPU automatically
- Still works, just slower

**Models downloading forever**
- Check internet speed
- Use wifi instead of VPN if slow
- Can take 10-15 minutes on slow connections

**"Address already in use"**
- Port 7860 is busy
- Kill previous instance: `pkill -f gradio_app`
- Or use different port: Edit run_mac.sh, add `--server-port 7861`

---

### Step 7: Access the Web Interface (1 minute)

Open your web browser and go to:

```
http://localhost:7860
```

**Or:**
```
http://127.0.0.1:7860
```

**What you should see:**
- Gradio web interface with tabs
- "Image to 3D" tab (default)
- "Text to 3D" tab
- Upload area for images
- Generation settings
- 3D viewer area

**If browser doesn't load:**
- Check Terminal for errors
- Verify URL is exactly `http://localhost:7860`
- Try different browser (Safari, Chrome, Firefox)
- Check firewall settings

---

### Step 8: Generate Your First 3D Model (5-10 minutes)

#### Image-to-3D (Recommended for first try)

1. **Upload Image**
   - Click "Click to Upload" area
   - Choose a clear image (single object, plain background works best)
   - Good test image: Photo of a coffee mug, toy, shoe

2. **Configure Settings** (Use these for first test)
   - **Resolution**: 512 (good balance)
   - **Guidance Scale**: 7.5 (default)
   - **Seed**: 42 (for reproducibility)
   - **Generate Texture**: ✅ Checked

3. **Click "Generate"**
   - Progress bar appears
   - Watch Terminal for progress logs
   - **Expected time: 5-10 minutes total**
     - Shape generation: 3-5 minutes
     - Texture generation: 3-5 minutes

4. **View Result**
   - 3D model appears in viewer
   - Click and drag to rotate
   - Scroll to zoom
   - Model auto-rotates

5. **Download**
   - Click "Download GLB" for web-ready format
   - Or "Download OBJ" for editing in Blender
   - Files save to Downloads folder

**Progress indicators:**
```
Terminal output:
- "Loading model..."
- "Generating shape..."
- "Shape generation complete"
- "Applying textures..."
- "Texture generation complete"
- "Saving output..."
```

---

## 📊 Performance Expectations

### Generation Times (M5 MacBook Pro, 16GB)

| Task | Time | Notes |
|------|------|-------|
| Shape generation | 3-5 min | Can't be faster (no CUDA) |
| Texture generation | 3-5 min | Memory intensive |
| Full pipeline | 5-10 min | Shape + Texture |
| Low res (256) | 2-3 min | Faster, lower quality |
| High res (1024) | 10-15 min | Slower, best quality |

### Resource Usage

Monitor in Activity Monitor:
- **CPU**: 80-100% during generation (normal)
- **Memory**: 8-12GB (watch for memory pressure)
- **GPU**: Metal GPU active
- **Temperature**: 60-90°C (normal for ML workload)

---

## 🎛️ Recommended Settings for Mac

### Quick Test (2-3 minutes)
```
Resolution: 256
Guidance Scale: 7.5
Generate Texture: ✅
```

### Preview Quality (5-7 minutes)
```
Resolution: 512
Guidance Scale: 7.5
Generate Texture: ✅
```

### Production Quality (10-15 minutes)
```
Resolution: 1024
Guidance Scale: 7.5-10.0
Generate Texture: ✅
```

---

## 🔄 Daily Usage

After initial deployment, starting the app is simple:

```bash
# 1. Open Terminal

# 2. Navigate to directory
cd /Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1

# 3. Run app
./run_mac.sh

# 4. Open browser
# http://localhost:7860

# 5. Generate models!
```

**Startup time: ~30 seconds** (models are cached)

---

## 🛑 Stopping the Application

When you're done:

1. Go to Terminal window running the app
2. Press `Ctrl + C`
3. Wait for "Shutting down..."
4. Terminal returns to prompt

**Or force quit:**
```bash
pkill -f gradio_app
```

---

## 🔧 Troubleshooting Deployment Issues

### Issue: Setup script fails immediately

**Check Python version:**
```bash
python3.10 --version
```

**If not found, install Python 3.10:**
```bash
brew install python@3.10
```

### Issue: Compilation errors during setup

**Install Xcode Command Line Tools:**
```bash
xcode-select --install
```

**Update existing tools:**
```bash
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

### Issue: Out of memory during generation

**Free up RAM:**
1. Close other apps (Chrome, Slack, etc.)
2. Restart Mac
3. Lower resolution to 256 or 512
4. Generate shape and texture separately

**Check memory pressure:**
```bash
vm_stat
```

### Issue: Generation takes forever (>20 minutes)

**This might be normal:**
- High resolution (1024) can take 15+ minutes
- Complex images take longer
- CPU fallback (if MPS fails) is very slow

**Check if using MPS:**
```python
python3.10 -c "import torch; print(torch.backends.mps.is_available())"
```

Should return `True`

### Issue: Can't access localhost:7860

**Check if server started:**
```bash
lsof -i :7860
```

Should show Python process.

**Check firewall:**
System Preferences → Security & Privacy → Firewall → Allow Python

**Try different port:**
Edit `run_mac.sh`, change to different port

---

## 📁 File Locations

### Generated Models
```
/Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1/outputs/
```

### Model Cache
```
~/.cache/huggingface/hub/models--tencent--Hunyuan3D-2.1/
```

### Logs
```
/Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1/logs/
```

### Temporary Files
```
/Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1/temp/
```

---

## 🎯 Quick Reference Commands

```bash
# Navigate to app
cd /Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1

# Start app
./run_mac.sh

# Stop app
# Press Ctrl+C in Terminal

# Check if running
lsof -i :7860

# Force stop
pkill -f gradio_app

# Check Python version
python3.10 --version

# Check disk space
df -h

# Check memory
vm_stat | grep "Pages free"

# Monitor CPU/Memory
top -l 1 | head -n 10

# View logs
tail -f logs/gradio.log
```

---

## ✅ Deployment Checklist

Use this to track your deployment progress:

- [ ] Install Xcode Command Line Tools
- [ ] Install Python 3.10
- [ ] Navigate to repository directory
- [ ] Make scripts executable (`chmod +x`)
- [ ] Run setup script (`./setup_mac.sh`)
- [ ] Wait for setup completion (~15-25 min)
- [ ] Run application (`./run_mac.sh`)
- [ ] Wait for model download (first run, ~5-10 min)
- [ ] Open browser to localhost:7860
- [ ] Upload test image
- [ ] Generate first 3D model
- [ ] Download and verify output
- [ ] Bookmark localhost:7860 for future use
- [ ] Note: Stop server with Ctrl+C when done

---

## 🚀 What's Next?

After successful deployment:

1. **Experiment with settings**
   - Try different resolutions
   - Test various images
   - Adjust guidance scale

2. **Learn the interface**
   - Explore text-to-3D
   - Try different export formats
   - Test the 3D viewer controls

3. **Optimize workflow**
   - Start with low resolution for testing
   - Use high resolution for finals
   - Keep Activity Monitor open

4. **Compare with Windows**
   - Deploy Windows version too
   - Use Mac for prototyping
   - Use Windows for production

---

## 📞 Support

If you get stuck:

1. Check `SETUP_GUIDE_MAC.md` for detailed troubleshooting
2. Review Terminal output for specific errors
3. Join Discord: https://discord.gg/dNBrdrGGMa
4. GitHub Issues: https://github.com/Tencent-Hunyuan/Hunyuan3D-2.1/issues

---

## 🎉 Success!

Once you see the Gradio interface and generate your first model, you've successfully deployed Hunyuan3D-2.1 on your Mac!

**Remember:**
- First model takes 5-10 minutes (be patient!)
- Quality is same as Windows, just slower
- Perfect for learning and testing
- Use Windows version for production

**Happy 3D generating!** 🚀✨
