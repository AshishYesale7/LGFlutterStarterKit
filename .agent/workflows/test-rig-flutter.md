---
name: Test Rig (Flutter)
description: How to test the Liquid Galaxy Flutter controller app with or without a physical rig.
---

# Test Rig Workflow (Flutter)

> **Context**: Gemini Summer of Code 2026 — Task 2 requires a working LG app with FlyTo, Orbit, SendKML, ClearKML, and Logo overlay. This workflow validates all those operations.

## Related Skills
- **lg-ssh-controller** (.agent/skills/lg-ssh-controller/SKILL.md) — SSH command patterns
- **lg-kml-writer** (.agent/skills/lg-kml-writer/SKILL.md) — KML generation
- **lg-emulator-manager** (.agent/skills/lg-emulator-manager/SKILL.md) — emulator setup
- **lg-debugger** (.agent/skills/lg-debugger/SKILL.md) — diagnosing failures
- **lg-demo-recorder** (.agent/skills/lg-demo-recorder/SKILL.md) — capturing evidence for submission

## Overview
Test your LG Flutter controller app with or without a physical Liquid Galaxy rig.

## Method 1: With a Physical LG Rig

### Connect and Test
1. Ensure your phone/tablet is on the same network as the LG rig.
2. Open the Flutter app.
3. Tap "Connect to LG Rig" and enter the LG master IP, port, username, password.
4. Test each feature:
   - Send KML placemarks (earthquake data, custom data)
   - FlyTo various locations
   - Run orbit around a city
   - Send logo to slave screen
   - Clear KML
   - Relaunch Google Earth

### Verification Checklist
- [ ] SSH connection succeeds
- [ ] KML placemarks appear on Google Earth across all screens
- [ ] FlyTo navigates to correct coordinates
- [ ] Orbit tour plays smoothly
- [ ] Logo overlay appears on the correct slave screen
- [ ] Clear KML removes all overlays
- [ ] Relaunch Google Earth restarts on all screens

## Method 2: Without a Physical Rig (Development Testing)

### Test SSH with a Local Linux VM or Docker
```bash
# Option A: Docker container with SSH (recommended for testing)
docker run -d -p 2222:22 --name lg-test lscr.io/linuxserver/openssh-server:latest
# Or use the standard ubuntu sshd:
docker run -d -p 2222:22 rastasheep/ubuntu-sshd:18.04

# Option B: Local VM
# Use VirtualBox/UTM with Ubuntu and enable SSH
```

### Test KML Output
```bash
# Run tests that verify KML string generation
cd flutter_client
flutter test

# Manually inspect generated KML
flutter run -d macos  # or linux, use the app to generate KML and check output
```

### Test API Integration
```bash
# Verify API endpoints are reachable
curl "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson" | head -100
```

## Method 3: Google Earth Pro (Desktop Verification)

1. Generate KML from your Flutter app (or from tests).
2. Open KML file in Google Earth Pro on your desktop.
3. Verify visual appearance -- placemarks, tours, balloons look correct.
4. This confirms the KML is valid before sending to the rig.

## Verification Checklist

### For All Apps
- [ ] App connects to SSH host (real rig or test server)
- [ ] KML generation produces valid XML
- [ ] FlyTo sends correct coordinates (lon,lat,alt order in KML!)
- [ ] Orbit animation generates correct heading steps
- [ ] Cleanup commands reset the state
- [ ] SSH connections are properly disposed on disconnect

### App Quality
- [ ] `flutter analyze` -- zero errors
- [ ] `flutter test` -- all passing
- [ ] UI is intuitive and clear on phone/tablet
- [ ] Error states are handled gracefully (no connection, timeout, etc.)
- [ ] Loading indicators shown during async operations

### Task 2 Required Operations (Contest Deliverable)
- [ ] **FlyTo** — sends `<LookAt>` to `/tmp/query.txt`, camera moves
- [ ] **Orbit** — sends `<gx:Tour>` orbit, smooth 360° rotation
- [ ] **SendKML** — writes KML to `/var/www/html/kml/`, placemarks appear
- [ ] **ClearKML** — empties KML files, Google Earth shows clean globe
- [ ] **Logo Overlay** — `<ScreenOverlay>` with app logo on slave screen

> After completing all checks, use **lg-demo-recorder** (.agent/skills/lg-demo-recorder/SKILL.md) to capture evidence screenshots and screen recordings for contest submission.
