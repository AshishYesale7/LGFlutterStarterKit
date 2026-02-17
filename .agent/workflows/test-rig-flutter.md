# Test Rig Flutter Workflow

Three methods for testing LG Flutter apps with the Liquid Galaxy rig.

## Method 1: Physical LG Rig
**Prerequisites**: Physical LG rig with 3+ screens, SSH access configured.

1. Connect Android device to same network as LG rig
2. Configure app settings: Host = LG master IP, Port = 22
3. Launch app → Connection screen → Enter credentials → Connect
4. Test flyTo: Should move Google Earth camera
5. Test KML: Should display placemark on Earth
6. Test logo: Should appear on left slave screen
7. Test reboot: All machines should restart

## Method 2: VM/Docker Mock
**Prerequisites**: VirtualBox or Docker installed.

### VirtualBox Setup
1. Import LG VM image
2. Configure network: Host-only adapter → 192.168.56.101
3. Start VM → verify Google Earth launches
4. Connect app to VM IP

### Docker Mock
```bash
docker-compose -f docker-compose.yml up -d
# Provides SSH on port 2222
# Configure app: Host = localhost, Port = 2222
```

## Method 3: Google Earth Pro (Desktop)
For KML testing without a rig:
1. Install Google Earth Pro on desktop
2. Generate KML from app
3. Open KML file in Google Earth Pro
4. Verify placemarks, tours, overlays render correctly

## Test Checklist
- [ ] SSH connection established
- [ ] flyTo command moves camera
- [ ] KML placemark appears on Earth
- [ ] Screen overlay displays on correct slave
- [ ] Clean KML removes all overlays
- [ ] Reboot command works (use caution!)
- [ ] App handles disconnection gracefully
