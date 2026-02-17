---
name: lg-demo-recorder
description: Capture screenshots, screen recordings, and GIFs for documentation
---

# LG Demo Recorder

Captures visual evidence of app functionality for documentation and GSoC submissions.

## Phase 1: Prepare Asset Directories
```bash
mkdir -p docs/screenshots docs/recordings docs/gifs
```

## Phase 2: Screenshot Checklist
Capture screenshots of ALL mandatory screens:
1. Splash Screen (app loading)
2. Connection Screen (SSH form)
3. Main Screen (LG control panel)
4. Settings Screen (connection + theme)
5. Help Screen (usage guide)
6. Any custom visualization screens

```bash
# Android emulator
adb exec-out screencap -p > docs/screenshots/<screen_name>.png
```

## Phase 3: Screen Recording
Record full demo flow:
1. App launch → splash
2. Connection screen → tap "Skip" for demo mode
3. Main screen → demonstrate each action button
4. Settings → change theme
5. Help → scroll through guide

```bash
adb shell screenrecord --time-limit 60 /sdcard/full_demo.mp4
adb pull /sdcard/full_demo.mp4 docs/recordings/full_demo.mp4
```

## Phase 4: GIF Conversion
```bash
# Using ffmpeg
ffmpeg -i docs/recordings/full_demo.mp4 -vf "fps=10,scale=360:-1" docs/gifs/demo_preview.gif

# Using gifski (higher quality)
ffmpeg -i docs/recordings/full_demo.mp4 -vf "fps=15,scale=480:-1" /tmp/frames%04d.png
gifski --fps 15 --quality 80 -o docs/gifs/demo_preview.gif /tmp/frames*.png
```

## Phase 5: README Integration
Add screenshots to README:
```markdown
## Screenshots
| Screen | Preview |
|--------|---------|
| Splash | ![Splash](docs/screenshots/splash.png) |
| Connection | ![Connection](docs/screenshots/connection.png) |
| Main | ![Main](docs/screenshots/main.png) |
```

## Demo

![App Demo](docs/gifs/demo_preview.gif)

Full demo video: `docs/recordings/full_demo.mp4`

## Phase 5: LG Rig Evidence (if available)
- Screenshot of app controlling physical LG rig
- Video of KML displaying on Google Earth
- Multi-screen panoramic screenshot

## Phase 6: GSoC Submission Checklist
- [ ] All mandatory screen screenshots in `docs/screenshots/`
- [ ] Full demo recording in `docs/recordings/`
- [ ] GIF preview in `docs/gifs/`
- [ ] README updated with screenshot table
- [ ] LG rig evidence (if available)
- [ ] GitHub Release with APK attached
