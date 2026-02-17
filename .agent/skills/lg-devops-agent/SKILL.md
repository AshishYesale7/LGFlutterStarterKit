---
name: lg-devops-agent
description: DevOps automation for LG project deployment and testing
---

# LG DevOps Agent

Manages DevOps tasks for Liquid Galaxy projects.

## Docker Mock Server
For testing without a physical LG rig:
```yaml
# docker-compose.yml
version: '3.8'
services:
  lg-mock:
    image: ubuntu:22.04
    ports:
      - "2222:22"
    command: /usr/sbin/sshd -D
```

## CI/CD Pipeline
1. `flutter analyze` — static analysis
2. `dart format --set-exit-if-changed .` — code formatting
3. `flutter test --coverage` — run tests
4. `flutter build apk --release` — build APK
5. Upload APK as artifact

## Environment Management
- Development: local emulator + mock SSH server
- Staging: Docker compose LG mock
- Production: Physical LG rig

## Monitoring
- ADB logcat for runtime logs
- Flutter DevTools for performance
- SSH connection health monitoring
