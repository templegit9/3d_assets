# 🚀 Quick Start - Hunyuan3D-2.1 for Mac (Apple Silicon)

## ⚠️ Before You Start

**Performance Note**: This runs on Apple Silicon (MPS/CPU), not CUDA GPUs.
- 📊 Expected: **5-10 minutes per model** (vs 2-3 min on NVIDIA GPU)
- 💡 For production: Use Windows version with RTX 5070 Ti
- ✅ For learning/testing: Mac version works great!

---

## TL;DR - 3 Steps to 3D Magic

### 1. Setup (One-Time, ~15-25 minutes)
```bash
cd /Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1
./setup_mac.sh
```

### 2. Run
```bash
./run_mac.sh
```
First run downloads models (~5GB, takes 5-10 minutes).

### 3. Create
Open browser: **http://localhost:7860**

Upload an image → Click "Generate" → Wait 5-10 min → Get your 3D model! 🎉

---

## Prerequisites Checklist

Before running setup, you need:

### Essential
```bash
# 1. Xcode Command Line Tools
xcode-select --install

# 2. Python 3.10
brew install python@3.10

# Verify:
python3.10 --version
```

### Optional but Recommended
```bash
# Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## First Time Setup

```bash
# Navigate to the repository
cd /Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1

# Make scripts executable (if needed)
chmod +x setup_mac.sh run_mac.sh

# Run setup
./setup_mac.sh
```

Wait for "Setup completed!" message (15-25 minutes).

---

## Running the App

```bash
./run_mac.sh
```

**First run only**: Models download automatically (~5-10 minutes)

Open: **http://localhost:7860**

---

## What You Get

✅ **Image-to-3D**: Turn photos into 3D models
✅ **Text-to-3D**: Describe it, generate it
✅ **PBR Materials**: Production-ready textures
✅ **Interactive Viewer**: Rotate, zoom, inspect
✅ **Multiple Formats**: GLB, OBJ, FBX export

⚠️ **Slower on Mac**: 5-10 minutes per model (be patient!)

---

## Settings for Mac Users

### Recommended Starting Settings

**For Testing** (2-3 minutes):
- Resolution: **256**
- Use simple images

**For Previews** (5-7 minutes):
- Resolution: **512**
- Good balance

**For Final Output** (10-15 minutes):
- Resolution: **1024**
- Best quality

### Memory-Saving Tips

1. **Close other apps** before generating
2. **Monitor memory** in Activity Monitor
3. **Start with low resolution** (256-512)
4. **Use simple images** first

---

## Tips for Best Results

🎯 **For Images**:
- Clear, well-lit photos work best
- Simple backgrounds preferred
- Single objects easier to process

🎯 **For Text**:
- Be specific and detailed
- Include materials, colors, style
- Keep under 100 words

🎯 **Performance**:
- Start with resolution 256 or 512
- Be patient (5-10 min is normal)
- Keep Activity Monitor open
- Ensure good Mac ventilation

---

## Common Issues

### "Python 3.10 not found"
```bash
brew install python@3.10
```

### "xcode-select not found"
```bash
xcode-select --install
```

### "Out of memory"
- Close other applications
- Lower resolution to 256 or 512
- Restart Mac to free memory

### "Too slow!"
- This is expected on Apple Silicon
- Use Windows version for production
- Or run overnight for best quality

### "Failed to compile mesh painter"
- Usually safe to ignore
- App may still work
- Check Xcode Command Line Tools installed

---

## Quick Comparison

| Feature | Mac M5 | Windows RTX 5070 Ti |
|---------|--------|---------------------|
| Speed | 5-10 min ⏱️ | 2-3 min ⚡ |
| Quality | Same ✨ | Same ✨ |
| Best For | Testing 🧪 | Production 🏭 |

**Pro Tip**: Develop on Mac, produce on Windows!

---

## Monitoring Your Mac

### Watch Performance
```bash
# Open Activity Monitor
open -a "Activity Monitor"

# Watch CPU tab for usage
# Watch Memory tab for pressure (keep green!)
# Watch GPU History for Metal usage
```

### Temperature Check
```bash
# Install istats
brew install osx-cpu-temp

# Monitor temperature
istats
```

Keep temperature below 90°C for sustained workloads.

---

## Stopping the Server

Press `Ctrl+C` in the terminal window.

---

## Need Help?

📖 Full guide: See `SETUP_GUIDE_MAC.md`
🐛 Bugs: https://github.com/Tencent-Hunyuan/Hunyuan3D-2.1/issues
💬 Community: https://discord.gg/dNBrdrGGMa
🪟 Better performance: Use Windows version!

---

## File Structure

```
Hunyuan3D-2.1/
├── setup_mac.sh          ← Run this first
├── run_mac.sh            ← Run this to start
├── QUICKSTART_MAC.md     ← You are here
├── SETUP_GUIDE_MAC.md    ← Detailed guide
└── outputs/              ← Your 3D models appear here
```

---

## What to Expect

### Timeline
- Setup: 15-25 minutes (one time)
- First run: +5-10 minutes (model download)
- Each generation: 5-10 minutes

### Quality
- Same quality as Windows version ✨
- Just slower due to Apple Silicon vs CUDA

### Use Cases
- ✅ Learning and experimentation
- ✅ Prototyping and testing
- ✅ Occasional 3D generation
- ⚠️ Production (use Windows instead)

---

**Ready to create 3D assets on your Mac? Let's go!** 🚀✨

*(Remember: Patience is key on Apple Silicon!)* ⏰
