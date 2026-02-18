---
name: lg-viz-architect
description: 'Designs Liquid Galaxy visualization experiences — deciding what the user sees on the multi-screen rig, how the camera moves, and which KML elements combine to tell a compelling data story.'
---

# LG Viz Architect — Visualization Experience Designer

Translates a raw data source into a **visual narrative** for the Liquid Galaxy rig.
This skill operates between brainstorming and planning — it decides *what the user
will see and feel* on the multi-screen Google Earth display.

**Announce:** "Viz Architect activated. Let's design the experience people will see on the rig."

**⚠️ PROMINENT GUARDRAIL**: The **Critical Advisor** (.agent/skills/lg-critical-advisor/SKILL.md) and **LG Shield** (.agent/skills/lg-shield/SKILL.md) are active at all times. If the student can't explain the phone-to-rig interaction model, STOP and invoke the Critical Advisor.

## When to Invoke
- After `lg-brainstormer` selects a concept.
- Before `lg-plan-writer` creates implementation tasks.
- When adding a new visualization to an existing app.

## Design Workflow

### Step 1 — Data Inventory
Identify the data source and its shape:

```
Source: USGS Earthquake API
Shape: { lat, lon, depth, magnitude, place, time }
Update frequency: Every 60 seconds
Volume: ~20-200 events per query
```

Ask: *"What story does this data tell? What patterns should be visible on a panoramic display?"*

### Step 2 — Experience Storyboard
Design the rig experience as a sequence of visual moments:

```
Moment 1: Cold Open
  → Camera starts at global view (altitude 15,000 km)
  → All earthquake placemarks fade in simultaneously
  → Color-coded by magnitude (green → yellow → red)

Moment 2: Focus Dive
  → Camera flies to the strongest recent earthquake
  → Balloon opens with detail (magnitude, depth, location)
  → Neighboring quakes visible in peripheral screens

Moment 3: Orbit Reveal
  → 360° orbit around the epicenter
  → Tilt at 60° for terrain perspective
  → Duration: 36 steps × 1.2s = ~43 seconds

Moment 4: Regional Survey
  → Camera pulls back to regional view
  → Tour auto-advances through top-5 quakes
  → Each stop holds for 5 seconds
```

### Step 3 — KML Element Mapping
Map each moment to specific KML elements:

| Moment | KML Element | Template |
|--------|-------------|----------|
| Placemark cluster | `<Document>` with N `<Placemark>` elements | `placemark.kml.tmpl` |
| Camera flight | `<gx:FlyTo>` with `<LookAt>` | `flyto.kml.tmpl` |
| Info popup | `<BalloonStyle>` with HTML content | `balloon.kml.tmpl` |
| Orbit tour | `<gx:Tour>` with `<gx:Playlist>` of `<gx:FlyTo>` | `orbit.kml.tmpl` |
| App logo | `<ScreenOverlay>` on right-most slave | `logo_slave.kml.tmpl` |
| Time animation | `<TimeStamp>` or `<TimeSpan>` on placemarks | Custom |

### Step 4 — Multi-Screen Awareness
Design for the panoramic layout:

- **Center screen (master)**: Primary focus — the main KML visualization.
- **Left/right screens (slaves)**: Context — surrounding geography, peripheral placemarks.
- **Right-most slave overlay**: App logo + legend using `ScreenOverlay`.
- **Camera tilt**: Use 50°–70° tilt so terrain fills peripheral screens dramatically.
- **Heading**: Consider slight heading offsets per screen for immersive panorama.

### Step 5 — Interaction Design
Map phone controller actions to rig responses:

| Phone Action | Rig Response |
|-------------|--------------|
| Tap placemark in list | FlyTo + Balloon on rig |
| Swipe/scroll map | FlyTo with smooth camera |
| Tap "Orbit" button | Start orbit tour |
| Tap "Overview" | FlyTo global altitude |
| Tap "Clear" | Remove all KML overlays |
| Pull-to-refresh | Re-fetch API, regenerate KML |

### Step 6 — Performance Constraints
Document limits for the target rig:

| Constraint | Guideline |
|-----------|-----------|
| Max simultaneous placemarks | ~500 (Google Earth performance) |
| KML string size | < 2 MB per transmission |
| FlyTo animation duration | 2–5 seconds (smooth but not slow) |
| Orbit steps | 24–72 (10°–15° per step) |
| Tour hold time | 3–8 seconds per stop |
| ScreenOverlay image size | < 500 KB PNG |

## Output
Produces a `viz-design.md` document in `docs/plans/`:

```markdown
# Visualization Design: [App Name]
## Data Source: [API / static data]
## Experience Storyboard: [Moments 1–N]
## KML Elements: [Table mapping moments to KML]
## Multi-Screen Layout: [What goes where]
## Interaction Map: [Phone → Rig responses]
## Performance Budget: [Constraints table]
```

## ⛔️ Student Interaction — MANDATORY

**After completing the visualization design, STOP and discuss with the student:**
1. Walk through the storyboard — ask them to visualize what each "moment" looks like on a 3-screen rig.
2. Ask: *"Which phone action maps to which rig response? Trace one interaction end-to-end."*
3. If the student cannot explain the phone-to-rig interaction model, link to **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md).

**DO NOT move to planning** until the student can explain their visualization design.

## Reference Links

- **Lucia's LG Master App (experience reference)**: https://github.com/LiquidGalaxyLAB/LG-Master-Web-App
- **KML Reference (Google)**: https://developers.google.com/kml/documentation/kmlreference
- **Google Earth gallery (inspiration)**: https://earth.google.com/gallery/
- **LG LAB past projects**: https://github.com/LiquidGalaxyLAB
- For deeper study → **lg-learning-resources** (.agent/skills/lg-learning-resources/SKILL.md)

## Handoff
Passes the visualization design to `lg-plan-writer` for task breakdown and to
`lg-kml-craftsman` for artistic KML composition.

## 🔗 Skill Chain

After the visualization design is complete and the student passes the interaction checkpoint, **automatically offer the next stage**:

> *"Visualization design is locked in! We know what the rig will display and how the camera moves. Now let's break this into a step-by-step implementation plan. Ready to write the plan? 📝"*

If student says "ready" → activate `.agent/skills/lg-plan-writer/SKILL.md`.
