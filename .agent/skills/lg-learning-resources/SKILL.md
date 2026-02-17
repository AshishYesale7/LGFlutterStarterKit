````skill
---
name: lg-learning-resources
description: 'Curated knowledge base of LG official sources, Flutter/Dart docs, YouTube tutorials, and community links. Maps each topic to targeted external resources so students can self-learn what they missed.'
---

# Learning Resources Hub

## Overview

This skill is the **reference library** for the entire Antigravity pipeline. When a student gets quiz questions wrong, fails to explain a concept, or asks "how does X work?", this skill maps their knowledge gap to **targeted external resources** — official LG repos, Flutter docs, YouTube tutorials, and community guides.

**Announce at start:** "Let me point you to the right resources for [topic]. These are official sources and curated tutorials that explain exactly what you need."

**GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) is active. Linking resources is NOT a substitute for understanding — the student must study and then demonstrate comprehension.

---

## 1. Liquid Galaxy Official Sources

### Core Repositories
| Resource | URL | What You'll Learn |
|----------|-----|-------------------|
| **LG Master Web App (Lucia's Guide)** | https://github.com/LiquidGalaxyLAB/LG-Master-Web-App | Complete reference LG web controller — architecture, KML patterns, SSH commands, multi-screen management |
| **Liquid Galaxy LAB GitHub** | https://github.com/LiquidGalaxyLAB | All GSoC LG projects — browse past implementations for inspiration |
| **Liquid Galaxy Core** | https://github.com/LiquidGalaxyLAB/liquid-galaxy | The LG installation scripts and rig setup — understand what runs on the master/slaves |
| **LG AI Content Generator** | https://github.com/LiquidGalaxyLAB/LG-AI-fictional-travel-itinerary-generator | Example of AI + LG integration with KML generation |
| **LG Gesture & Voice Control** | https://github.com/LiquidGalaxyLAB/LG-Gesture-And-Voice-Control | Advanced input methods for LG controller apps |

### Lucia's LG Master Web App — Key Files to Study
| File/Section | What It Teaches |
|-------------|-----------------|
| `app/services/lg_service.dart` | SSH command patterns, flyTo, orbit, KML sending |
| `app/services/kml_service.dart` | KML generation patterns (placemarks, tours, overlays) |
| Screen structure (`splash`, `main`, `connection`, `settings`, `help`) | Mandatory GSoC screen layout |
| `README.md` | Setup instructions, architecture overview, screen descriptions |

### LG Documentation
| Resource | URL |
|----------|-----|
| **LG Installation Guide** | https://github.com/LiquidGalaxyLAB/liquid-galaxy/wiki |
| **Google Summer of Code — LG Org** | https://www.liquidgalaxy.eu/ |
| **LG Community** | https://github.com/LiquidGalaxyLAB/liquid-galaxy/discussions |

---

## 2. Topic-Specific Resource Maps

### Topic: SSH & LG Communication
**When to link**: Student misses "Command Flow" quiz question, can't trace phone → SSH → GE pipeline.

| Resource | Type | URL |
|----------|------|-----|
| SSH Protocol Explained | YouTube | https://www.youtube.com/watch?v=ORcvSkgdA58 |
| DartSSH2 Package Docs | Pub.dev | https://pub.dev/packages/dartssh2 |
| How SSH Works (visual) | Article | https://www.ssh.com/academy/ssh/protocol |
| LG Master Web App — SSH Service | Code | https://github.com/LiquidGalaxyLAB/LG-Master-Web-App |
| Flutter SSH Client Tutorial | YouTube | Search: "Flutter SSH client dartssh2 tutorial" |

**Key concepts to study:**
- SSH session lifecycle (connect → authenticate → execute → disconnect)
- Port forwarding vs direct command execution
- Why SSH timeout handling matters on unreliable networks
- How `echo 'KML' > /var/www/html/kml/slave_X.kml` works on the rig

---

### Topic: KML (Keyhole Markup Language)
**When to link**: Student misses "KML Challenge" quiz question, coordinates wrong, KML doesn't render.

| Resource | Type | URL |
|----------|------|-----|
| KML Official Reference (Google) | Docs | https://developers.google.com/kml/documentation |
| KML Tutorial (Google) | Tutorial | https://developers.google.com/kml/documentation/kml_tut |
| KML Interactive Sampler | Tool | https://developers.google.com/kml/documentation/kmlelementsinmaps |
| Earth Outreach KML Guide | Course | https://www.google.com/earth/outreach/learn/ |
| KML Coordinate Order Explained | Key Fact | https://developers.google.com/kml/documentation/kmlreference#coordinates |
| Google Earth Pro (Desktop) | Download | https://www.google.com/earth/about/versions/#earth-pro |

**Key concepts to study:**
- KML uses `longitude,latitude,altitude` (NOT lat,lon!)
- Placemarks, Styles, ScreenOverlays, BalloonStyles
- NetworkLinks for dynamic content refresh
- Tours with FlyTo, Wait, AnimatedUpdate
- 3D extrusions and polygon fills
- Multi-screen KML: slave numbering = `(master + i) % total_screens`

---

### Topic: Flutter & Dart Fundamentals
**When to link**: Student struggles with Provider, widget lifecycle, async/await, state management.

| Resource | Type | URL |
|----------|------|-----|
| Flutter Official Docs | Docs | https://docs.flutter.dev/ |
| Flutter Widget of the Week | YouTube Playlist | https://www.youtube.com/playlist?list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG |
| Dart Language Tour | Docs | https://dart.dev/language |
| Provider Package Guide | Docs | https://pub.dev/packages/provider |
| Flutter State Management (official) | Tutorial | https://docs.flutter.dev/data-and-backend/state-mgmt/simple |
| Andrea Bizzotto — Flutter Tutorials | YouTube | https://www.youtube.com/@baborakm |
| Flutter Mapp (UI tutorials) | YouTube | https://www.youtube.com/@FlutterMapp |
| Reso Coder (Architecture) | YouTube | https://www.youtube.com/@ResoCoder |
| Vandad Nahavandipoor (Complete Course) | YouTube | https://www.youtube.com/@VandadNP |
| The Net Ninja — Flutter | YouTube | https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ |

**Key concepts to study:**
- Widget tree and BuildContext
- StatelessWidget vs StatefulWidget
- Provider pattern (ChangeNotifier, Consumer, context.watch/read)
- Async/Await and FutureBuilder
- Navigation and routing
- Theme data and Material 3

---

### Topic: Software Engineering Principles (SOLID, DRY, Architecture)
**When to link**: Student misses "Engineering Pillar" quiz question, violates layer boundaries.

| Resource | Type | URL |
|----------|------|-----|
| SOLID Principles Explained | YouTube | https://www.youtube.com/watch?v=_jDNAf3CzeY |
| Clean Architecture in Flutter | YouTube | https://www.youtube.com/watch?v=dc3B_mMrZ-Q |
| Flutter App Architecture (official) | Docs | https://docs.flutter.dev/app-architecture |
| Service Layer Pattern | Article | https://martinfowler.com/eaaCatalog/serviceLayer.html |
| DRY / YAGNI / KISS Explained | Article | https://www.geeksforgeeks.org/software-engineering-principles/ |
| Separation of Concerns | Article | https://en.wikipedia.org/wiki/Separation_of_concerns |

**Key concepts to study:**
- Single Responsibility: Each service does ONE thing (SSH ≠ KML ≠ API)
- Dependency Inversion: Screens depend on abstractions (Provider), not SSH details
- Layer boundaries: Presentation → Service → Transport (never backwards)
- Why KML generation must NOT live in widget files
- Why SSH must NOT live in screen files

---

### Topic: Performance & Connection Management
**When to link**: Student misses "Performance Pitfall" quiz question — connection leaks, memory issues.

| Resource | Type | URL |
|----------|------|-----|
| Flutter Performance Best Practices | Docs | https://docs.flutter.dev/perf/best-practices |
| Dart Streams & Async | Docs | https://dart.dev/libraries/async/using-streams |
| Memory Leak Prevention in Flutter | YouTube | Search: "Flutter memory leak detection devtools" |
| Flutter DevTools Profiling | Tool | https://docs.flutter.dev/tools/devtools/overview |
| Connection Pooling Concepts | Article | https://en.wikipedia.org/wiki/Connection_pool |

**Key concepts to study:**
- SSH connection lifecycle: connect once, reuse, dispose on app exit
- `dispose()` method — always clean up controllers, streams, connections
- KML cleanup: always `clearKML()` before sending new content
- Memory profiling with Flutter DevTools
- Why `split-per-abi` reduces APK size

---

### Topic: Scaling & Future Architecture
**When to link**: Student misses "Future Architect" quiz question — can't reason about scaling.

| Resource | Type | URL |
|----------|------|-----|
| LG with Multiple Screens (5, 7) | Code | https://github.com/LiquidGalaxyLAB/liquid-galaxy |
| Microservices Pattern | Article | https://microservices.io/patterns/microservices.html |
| Flutter Modular Architecture | YouTube | Search: "Flutter modular architecture clean code" |
| API Design Best Practices | Docs | https://swagger.io/resources/articles/best-practices-in-api-design/ |
| Google Earth API (historical) | Reference | https://developers.google.com/earth |

**Key concepts to study:**
- Adding a new API: create provider contract → domain model → KML generator → wire to UI
- Scaling screens: slave numbering formula `(master + i) % total`
- Adding platforms: `flutter create --platforms=ios,linux,macos .`
- Plugin architecture: each feature as a self-contained module

---

## 3. Development Environment Resources

| Resource | Type | URL |
|----------|------|-----|
| Flutter Install Guide | Docs | https://docs.flutter.dev/get-started/install |
| Android Studio Setup | Docs | https://developer.android.com/studio/install |
| VS Code Flutter Setup | Docs | https://docs.flutter.dev/tools/vs-code |
| Git Basics | Tutorial | https://git-scm.com/book/en/v2/Getting-Started-Git-Basics |
| JDK 17 (Adoptium) | Download | https://adoptium.net/temurin/releases/?version=17 |
| Node.js Download | Download | https://nodejs.org/en/download/ |
| ADB (Android Debug Bridge) | Docs | https://developer.android.com/tools/adb |

---

## 4. How to Use This Skill

### From Quiz Master (wrong answers)
When the student gets a question wrong, map the **category** to the resource section:

| Quiz Category | Resource Section |
|---------------|-----------------|
| Command Flow | §2: SSH & LG Communication |
| KML Challenge | §2: KML |
| Engineering Pillar | §2: Software Engineering Principles |
| Performance Pitfall | §2: Performance & Connection Management |
| Future Architect | §2: Scaling & Future Architecture |

Include in the quiz report:
```markdown
## 📚 Recommended Study Resources
Based on your missed questions, study these before retaking:

### [Category Name]
- 📖 Resource Name + URL — What you'll learn
- 🎥 YouTube Video + URL — What it covers
- 💻 Code Reference + URL — What to look at

### Liquid Galaxy Official References
- 🏠 [LG Master Web App](https://github.com/LiquidGalaxyLAB/LG-Master-Web-App) — Study Lucia's implementation
- 📋 [LG LAB GitHub](https://github.com/LiquidGalaxyLAB) — Browse past GSoC projects
```

### From Critical Advisor (understanding gaps)
When the advisor pauses execution due to a knowledge gap, link the relevant section:
```
"Before we continue, study this resource to understand [concept]:
→ [Resource Name]: [URL]
Then explain back to me: [verification question]"
```

### Student Asks Directly
If the student asks "how does X work?" or "I don't understand Y", use this skill to find the best resource and present it with context.

---

## 5. Community & Getting Help

| Resource | URL |
|----------|-----|
| Flutter Discord | https://discord.gg/flutter |
| Flutter Stack Overflow | https://stackoverflow.com/questions/tagged/flutter |
| Dart Stack Overflow | https://stackoverflow.com/questions/tagged/dart |
| LG LAB Discussions | https://github.com/LiquidGalaxyLAB/liquid-galaxy/discussions |
| Google Earth Community | https://www.google.com/earth/community/ |
| GSoC Student Guide | https://google.github.io/gsocguides/student/ |

---

## Handoff

- **Student studied resources** → Return to `lg-quiz-master` for retry, or `lg-critical-advisor` to demonstrate understanding.
- **Student needs hands-on help** → `.agent/skills/lg-debugger/SKILL.md` for debugging, `.agent/skills/lg-setup-guide/SKILL.md` for tooling.
- **Student ready to continue** → `.agent/skills/lg-resume-pipeline/SKILL.md` to pick up the pipeline.

````
