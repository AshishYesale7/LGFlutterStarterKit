# Screens & UI

> Complete documentation of every screen, route, widget, and UI element in the starter kit.

---

## Table of Contents

- [Route Map](#route-map)
- [Splash Screen](#splash-screen)
- [Connection Screen](#connection-screen)
- [Main Dashboard Screen](#main-dashboard-screen)
- [Settings Screen](#settings-screen)
- [Help Screen](#help-screen)
- [Workflow Flow Screen](#workflow-flow-screen)
- [Optional Screens](#optional-screens)
- [Custom Widgets](#custom-widgets)
- [Theming](#theming)

---

## Route Map

| Route | Screen Class | File | Purpose |
|-------|-------------|------|---------|
| `/` | `SplashScreen` | `screens/splash_screen.dart` | App branding, auto-navigate |
| `/connection` | `ConnectionScreen` | `screens/connection_screen.dart` | Credential input, connect to rig |
| `/main` | `MainScreen` | `screens/main_screen.dart` | Dashboard with LG operations |
| `/settings` | `SettingsScreen` | `screens/settings_screen.dart` | Rig config, theme toggle |
| `/help` | `HelpScreen` | `screens/help_screen.dart` | Instructions, architecture info |
| `/workflow` | `WorkflowFlowScreen` | `screens/workflow_flow_screen.dart` | Interactive pipeline visualizer |

Routes are defined in `main.dart` inside the `MaterialApp` configuration.

---

## Splash Screen

**Route:** `/`  
**File:** `screens/splash_screen.dart`  
**Type:** `StatefulWidget`

### Behavior
- Displays for 2 seconds
- Auto-navigates to `/connection` via `Navigator.pushReplacementNamed`

### UI Elements
- Centered globe icon (`Icons.public`, 100px, blue)
- "LG Starter Kit" headline text
- "Liquid Galaxy Controller" subtitle
- `CircularProgressIndicator`

### Customization
Replace the icon and text for your app's branding. Adjust the delay duration in `initState`.

---

## Connection Screen

**Route:** `/connection`  
**File:** `screens/connection_screen.dart`  
**Type:** `StatefulWidget`

### State
- `_isConnecting: bool` — loading indicator
- `_errorMessage: String?` — error display

### Text Controllers
- `_hostController` — LG master IP address
- `_portController` — SSH port
- `_userController` — SSH username
- `_passController` — SSH password (obscured)

### Behavior

1. **On init:** Loads persisted credentials from `SettingsProvider` into text controllers
2. **On connect:**
   - Saves credentials via `settings.updateSettings()` (secure storage)
   - Calls `lgService.connect(host, port, username, password)`
   - On success → navigates to `/main`
   - On failure → displays error message
3. **Skip (Demo Mode):** Navigates directly to `/main` without connecting

### UI Elements
- AppBar with settings icon → `/settings`
- 4 text fields: Host IP, Port, Username, Password
- `FilledButton` "Connect" (with loading indicator)
- `OutlinedButton` "Skip (Demo Mode)"
- Error message display (red text)

---

## Main Dashboard Screen

**Route:** `/main`  
**File:** `screens/main_screen.dart`  
**Type:** `StatefulWidget`

### State
- `_isLoading: bool` — action loading state
- `_statusMessage: String?` — success/error feedback

### AppBar Actions
- Workflow icon → `/workflow`
- Settings icon → `/settings`
- Help icon → `/help`

### UI Sections

#### Status Card
- Connected/disconnected icon with color
- Status message text
- Loading indicator during operations

#### 5 Core Task 2 Buttons
| Button | Icon | Method |
|--------|------|--------|
| Send Logo | `image` | `lgService.sendLogo()` |
| Send Pyramid | `change_history` | `lgService.sendPyramid()` |
| Fly to Home City | `home` | `lgService.flyToHomeCity()` |
| Clean Logos | `cleaning_services` | `lgService.cleanLogos()` |
| Clean KMLs | `delete_sweep` | `lgService.cleanKMLs()` |

#### Additional Buttons
| Button | Icon | Method |
|--------|------|--------|
| Send KML Placemark | `place` | `lgService.sendKMLPlacemark(name: 'Lleida', ...)` |
| Reboot LG | `restart_alt` | `lgService.rebootLG()` |
| Disconnect | `logout` | `lgService.disconnect()` → `/connection` |

### Error Handling
All button presses go through `_executeAction()` which:
- Sets `_isLoading = true`
- Calls the async method
- Catches errors and displays in `_statusMessage`
- Sets `_isLoading = false`

---

## Settings Screen

**Route:** `/settings`  
**File:** `screens/settings_screen.dart`  
**Type:** `StatelessWidget`

### UI Sections

#### Connection Card (Read-Only)
Shows current connection settings from `SettingsProvider`:
- Host IP
- Port
- Username
- Total Screens

#### Appearance
Three `RadioListTile<ThemeMode>` options:
- **System** (follows device setting)
- **Light**
- **Dark**

Changes are applied immediately via `ThemeProvider.setThemeMode()` and persisted to `SharedPreferences`.

#### Reset
- "Reset to Defaults" button
- Calls `settings.resetToDefaults()` — clears SecureStorage + SharedPreferences, reverts to `Config.*` values
- Shows confirmation `SnackBar`

---

## Help Screen

**Route:** `/help`  
**File:** `screens/help_screen.dart`  
**Type:** `StatelessWidget`

### Content Cards

#### About
Description of the LG Flutter Starter Kit, version info.

#### SSH Commands (8 items)
- `flyTo(lat, lon)` — Fly camera
- `search(query)` — Search Google Earth
- `rebootLG()` — Reboot rig
- `cleanKMLs()` — Clear all KMLs
- `sendLogo()` — Display logo on slave
- `sendPyramid()` — Send 3D pyramid
- `flyToHomeCity()` — Fly to configured home
- `cleanLogos()` — Remove slave overlays

#### KML Basics (5 items)
- Placemarks — Points on the globe
- Overlays — Screen/ground image overlays
- LineStrings — Paths between coordinates
- Polygons — Filled shapes (including 3D extruded)
- NetworkLinks — Dynamic KML loading

#### Architecture (5 items)
Lists the key folders/files and their roles.

---

## Workflow Flow Screen

**Route:** `/workflow`  
**File:** `screens/workflow_flow_screen.dart`  
**Type:** `StatefulWidget`

### Purpose
Interactive **n8n-style** visualization of the 11-stage agent pipeline. Shows the complete flow from environment setup to graduation quiz.

### Layout
- Grid-based: `_colW = 260px`, `_rowH = 120px`, `_topPad = 40px`, `_leftPad = 40px`
- 20 nodes across 5 rows
- 16 edges (15 forward + 1 conditional feedback)

### Node Layout

| Row | Nodes |
|-----|-------|
| Row 0 | `env_doctor` → `shield_pre` → `init` → Checkpoint → `brainstorm` |
| Row 1 | Checkpoint → `viz_arch` → `plan` → Checkpoint → `data_pipeline` |
| Row 2 | `ui_kml` → `execute` → Checkpoint → `review` → `shield_post` |
| Row 3 | `quiz` (centered at col 2) |
| Row 4 (Helpers) | `critical_advisor`, `dep_resolver`, `resume_pipeline`, `learning_resources`, `demo_recorder` |

### Interactions
- **Pan:** Drag to scroll
- **Zoom:** Pinch gesture (0.15x – 2.5x range)
- **Zoom buttons:** Zoom In (1.3x), Zoom Out (0.7x), Fit to Screen (reset)
- **Tap node:** Opens bottom sheet with:
  - Icon + tag + label + description
  - Skill path (if applicable)
  - Checkpoint question (if applicable)
  - "Next →" chips for connected nodes

### Legend
Color-coded dots at the top:
- 🔵 **Stage** — Pipeline stage
- 🟣 **Checkpoint** — Verification point
- ⚪ **Helper** — Support skill (always active)
- 🟢 **Trigger** — Pipeline entry point

### Custom Painter
Edges are drawn by `FlowEdgePainter` using cubic Bezier curves:
- Normal edges: grey with 0.5 alpha
- Conditional edges: orange with 0.7 alpha + label
- Arrow heads at endpoints

---

## Optional Screens

Located in `screens/optional_files/`, these are template screens for common LG use cases:

| File | Purpose |
|------|---------|
| `orbit.dart` | 360° camera orbit around a location via `lgService.sendOrbit()` |
| `earthquake.dart` | USGS earthquake data visualization |
| `kml_viewer.dart` | KML file browser and viewer |
| `balloon.dart` | Balloon animation demo |
| `nodejs.dart` | Node.js server integration demo |

These screens are **not wired to any route** by default — add them to `main.dart` routes as needed.

---

## Custom Widgets

### FlowNodeCard

**File:** `widgets/flow_node_card.dart`  
**Dimensions:** 200 × 80 px

Visual representation of a pipeline node:
- Left icon strip (48px, accent-colored)
- Tag label (9px, uppercase)
- Label text (12px, bold)
- Status chip (RUNNING / DONE / BLOCKED / IDLE) if non-idle
- Right connector dot if node has outputs

**Color scheme:**
| Node Type | Background | Accent |
|-----------|-----------|--------|
| Stage | surface | primary (blue) |
| Checkpoint | tertiaryContainer | tertiary (purple) |
| Helper | surfaceContainerHighest | secondary (grey) |
| Trigger | surface | green |

### FlowEdgePainter

**File:** `widgets/flow_edge_painter.dart`  
**Type:** `CustomPainter`

Draws edges between nodes as cubic Bezier curves:
- Computes start (right-center of source) and end (left-center of target)
- Control points use horizontal offset: `dx = abs(end - start) * 0.5`
- Draws arrow head at endpoint
- Conditional edges: orange color + italic label at midpoint
- Normal edges: grey with 0.5 alpha

---

## Theming

### Material 3 Configuration

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.light,
  ),
  darkTheme: ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
    brightness: Brightness.dark,
  ),
  themeMode: themeProvider.themeMode,
)
```

### Theme Modes
- **System** — follows device light/dark setting (default)
- **Light** — forced light theme
- **Dark** — forced dark theme

Theme preference is persisted via `ThemeProvider` → `SharedPreferences` and survives app restarts.
