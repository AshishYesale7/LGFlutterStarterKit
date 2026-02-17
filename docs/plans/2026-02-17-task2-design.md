# Design Document: LG Task 2 Demo App

**Date**: 2026-02-17
**Status**: Approved

## 1. Overview
This application serves as a **Remote Controller** for a Liquid Galaxy rig, specifically designed to fulfill "Task 2" requirements. It demonstrates the core capabilities of the LG SDK: SSH communication, KML visualization, and rigorous state management.

## 2. Architecture
We follow the **Strict Controller-Responder** pattern:
-   **Controller**: Flutter App (Mobile).
-   **Responder**: Liquid Galaxy Rig (Google Earth).
-   **Transport**: SSH (Port 22).

### Layer Boundaries
1.  **UI Layer (`screens/`)**:
    -   Displays buttons.
    -   Calls `LGService`.
    -   **NEVER** imports `dartssh2` or generates KML.
2.  **Service Layer (`services/`)**:
    -   `LGService`: Orchestrates high-level actions (e.g., `sendLogo`).
    -   `KMLService`: Pure functional generation of KML strings.
    -   `SSHService`: Manages socket connections and executes raw shell commands.
3.  **Domain Layer (`models/`)**:
    -   Defines `KMLPayload`, `LGConnectionSettings`.

## 3. Feature Design

### A. LG Logo (Left Screen)
-   **Visual**: Standard LG Logo.
-   **Target**: Screen 3 (Left on a 3-screen rig).
-   **Mechanism**: KML `ScreenOverlay`.
-   **Implementation**:
    -   File `slave_3.kml`.
    -   Overlay positioned fastidiously to ensure visibility.

### B. 3D Pyramid (Center Screen)
-   **Visual**: Colored Pyramid.
-   **Target**: Screen 1 (Center).
-   **Mechanism**: KML `Placemark` with `Polygon` geometry (extruded).
-   **Implementation**:
    -   Construct a 4-sided pyramid using `<Polygon>` points.
    -   Altitude mode: `relativeToGround`.
    -   Extrusion: `1`.

### C. Fly To Home City (Mumbai)
-   **Visual**: Smooth camera flight.
-   **Target**: Master (Center).
-   **Mechanism**: `gmap_pylib` "flytoview" command OR raw `echo "flytoview=..." > /tmp/query.txt`.
-   **Coordinates**: 19.0760° N, 72.8777° E.

### D. Clean
-   **Mechanism**:
    -   `echo '' > /var/www/html/kmls.txt` (Clear master registry).
    -   Loop through slaves to clear specific KMLs.

## 4. KML Strategy
-   **Generation**: All KML is generated in Dart code (no static files) to demonstrate dynamic capabilities.
-   **Validation**: KML strings will be validated against basic XML rules before sending.

## 5. Security & Safety
-   **SSH Credentials**: Managed via `Config` (for this demo) or `flutter_secure_storage`.
-   **Connection**: Auto-reconnect on app launch.
-   **Error Handling**: Graceful degradation if Rig is unreachable.

## 6. Testing Strategy
-   **Unit Tests**: Verify KML generation strings.
-   **Widget Tests**: Verify button presence and tap handlers.
-   **Integration**: Manual verification on Rig/VM.
