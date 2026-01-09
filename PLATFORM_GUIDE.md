# Platform Selection Guide - Hunyuan3D-2.1

## Which Version Should You Use?

You have **two machines** available to run Hunyuan3D-2.1. This guide helps you choose the right one for your needs.

---

## Your Hardware

### 🪟 Windows Desktop
- **GPU**: NVIDIA RTX 5070 Ti (16GB VRAM)
- **RAM**: 64GB
- **Backend**: CUDA (optimized for ML/AI)

### 🍎 Mac M5 MacBook Pro
- **Chip**: Apple M5 (16GB unified memory)
- **RAM**: 16GB (shared with GPU)
- **Backend**: MPS (Metal Performance Shaders) / CPU

---

## Quick Comparison

| Feature | Windows (RTX 5070 Ti) | Mac (M5) |
|---------|----------------------|----------|
| **Speed** | ⚡ Fast (2-3 min) | ⏱️ Slow (5-10 min) |
| **Backend** | CUDA | MPS/CPU |
| **Optimization** | Full | Partial |
| **VRAM/Memory** | 16GB dedicated | 16GB shared |
| **Setup Difficulty** | Medium | Easy |
| **Best For** | Production | Learning/Testing |
| **Recommended** | ✅ Primary | ✅ Secondary |

---

## Detailed Comparison

### Performance

**Windows (RTX 5070 Ti)**
- Generation time: **2-3 minutes** per model
- CUDA acceleration fully supported
- Low VRAM mode available for 16GB GPU
- All optimizations enabled
- Best for iterative workflows

**Mac (M5)**
- Generation time: **5-10 minutes** per model
- MPS/CPU fallback (no CUDA)
- 5-10x slower than NVIDIA GPU
- Some optimizations disabled
- Good for occasional use

### Quality

**Both platforms produce identical quality output!** ✨
- Same model weights
- Same PBR materials
- Same export formats
- Speed is the only difference

### Memory Management

**Windows**
- 16GB dedicated VRAM for GPU
- 64GB system RAM separately
- Can handle complex models easily
- Low VRAM mode if needed

**Mac**
- 16GB unified memory (shared CPU/GPU)
- May struggle with very complex models
- Lower resolution settings recommended
- Close other apps during generation

---

## Use Case Recommendations

### 🏆 Use Windows When:

✅ **Production work**
- Client projects
- Commercial 3D assets
- High-volume generation

✅ **Fast iteration**
- Testing multiple variations
- Rapid prototyping
- Time-sensitive projects

✅ **Complex models**
- High resolution (1024+)
- Detailed textures
- Multiple objects

✅ **Best performance**
- You need results in 2-3 minutes
- Running batch generations
- Maximum quality and speed

---

### 🍎 Use Mac When:

✅ **Learning & experimentation**
- First time trying the tool
- Exploring features
- Tutorial following

✅ **Mobile/portable work**
- Working away from desktop
- Coffee shop / travel
- No access to Windows PC

✅ **Simple projects**
- Single object generation
- Lower resolution previews
- Testing prompts and settings

✅ **You don't mind waiting**
- Overnight generations
- Background processing
- Not time-sensitive

---

## Setup Instructions

### Windows Setup
```bash
cd Hunyuan3D-2.1
setup.bat          # Run setup
run.bat            # Start app
```
📖 See: `SETUP_GUIDE.md` and `QUICKSTART.md`

### Mac Setup
```bash
cd /Users/Temple/Documents/SelfProjects/3D_Assets/Hunyuan3D-2.1
./setup_mac.sh     # Run setup
./run_mac.sh       # Start app
```
📖 See: `SETUP_GUIDE_MAC.md` and `QUICKSTART_MAC.md`

---

## Workflow Recommendations

### 🎯 Hybrid Workflow (Recommended)

**Use both machines for optimal productivity:**

1. **Prototype on Mac** 🍎
   - Test ideas and prompts
   - Low-res previews (256-512)
   - Experiment with settings
   - Work on-the-go

2. **Produce on Windows** 🪟
   - Final high-res generation (1024)
   - Batch processing
   - Client deliverables
   - Fast iteration

### 💡 Example Workflow

```
Day 1 (Mac - Coffee Shop):
├── Test 10 different image inputs (512 res)
├── Experiment with prompts
└── Identify 3 best candidates

Day 2 (Windows - Home Office):
├── Generate final versions (1024 res)
├── Create variations of winners
└── Export for client (15 models in 30 min)
```

---

## Cost-Benefit Analysis

### Windows
- **Setup time**: 20-30 minutes
- **Per model**: 2-3 minutes
- **10 models**: 20-30 minutes
- **Best for**: Productivity

### Mac
- **Setup time**: 25-35 minutes
- **Per model**: 5-10 minutes
- **10 models**: 50-100 minutes
- **Best for**: Flexibility

---

## Technical Differences

### Windows (CUDA)
```bash
# Uses NVIDIA CUDA backend
--low_vram_mode              # Enabled for 16GB
torch.cuda.is_available()    # True
Backend: CUDA 12.4
```

### Mac (MPS)
```bash
# Uses Apple Metal backend
export PYTORCH_ENABLE_MPS_FALLBACK=1
torch.backends.mps.is_available()  # True
Backend: MPS / CPU fallback
```

---

## File Compatibility

✅ **Models are 100% compatible across platforms**
- Generate on Mac, refine on Windows
- Generate on Windows, view on Mac
- Same export formats (GLB, OBJ, FBX)
- Share via cloud storage seamlessly

---

## Decision Matrix

Answer these questions to decide:

1. **Do you need results in under 3 minutes?**
   - Yes → Windows ✅
   - No → Either ✅

2. **Are you doing production work?**
   - Yes → Windows ✅
   - No → Either ✅

3. **Working away from desktop?**
   - Yes → Mac ✅
   - No → Windows ✅

4. **Just learning the tool?**
   - Yes → Mac ✅ (easier setup)
   - No → Windows ✅ (better performance)

5. **Need to generate many models?**
   - Yes → Windows ✅
   - No → Either ✅

---

## Our Recommendation

### Primary Setup: Windows 🪟
**Set up Windows first for best experience:**
- Fastest performance
- Full feature support
- Production-ready
- Main workstation

### Secondary Setup: Mac 🍎
**Set up Mac for portability:**
- On-the-go work
- Learning and testing
- Backup option
- Experimentation

### Best Practice
**Install on both** and use each for its strengths! 💪

---

## Getting Started

### New to Hunyuan3D?
**Start with Mac:**
1. Easier setup (no MSVC)
2. Learn the interface
3. Test with low-res
4. Once comfortable → Switch to Windows for production

### Experienced User?
**Start with Windows:**
1. Best performance
2. Full features
3. Production-ready
4. Add Mac later for portability

---

## Summary

| Scenario | Choose |
|----------|--------|
| Client work | 🪟 Windows |
| Learning | 🍎 Mac |
| Fast results | 🪟 Windows |
| Portability | 🍎 Mac |
| High volume | 🪟 Windows |
| Experimenting | 🍎 Mac |
| Best quality | 🪟 Windows (same quality, faster) |
| Travel | 🍎 Mac |

**Ideal**: Set up both! Use Mac for prototyping, Windows for production. 🎯

---

## Additional Resources

### Windows Docs
- `SETUP_GUIDE.md` - Full Windows setup
- `QUICKSTART.md` - Quick start guide
- `setup.bat` - Installation script
- `run.bat` - Run script

### Mac Docs
- `SETUP_GUIDE_MAC.md` - Full Mac setup
- `QUICKSTART_MAC.md` - Quick start guide
- `setup_mac.sh` - Installation script
- `run_mac.sh` - Run script

### Universal
- `README.md` - Official documentation
- `API_DOCUMENTATION.md` - API reference
- HuggingFace: https://huggingface.co/tencent/Hunyuan3D-2.1
- Discord: https://discord.gg/dNBrdrGGMa

---

**Happy 3D generating on your platform of choice!** 🚀✨
