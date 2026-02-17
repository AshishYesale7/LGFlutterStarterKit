# Visualization Design: LG Task 2 Demo App

## Data Source
-   **Static Data**: LG Logo URL, Pyramid Coordinates (Lleida), Home City Coordinates (Mumbai).
-   **User Input**: None (hardcoded for this demo task).

## Experience Storyboard

### Moment 1: Connection & Logo
-   **Visual**: Liquid Galaxy Logo appears on the Left Screen (Screen 3).
-   **Purpose**: Branding and connection verification.
-   **KML Element**: `<ScreenOverlay>` in `slave_3.kml`.

### Moment 2: The Pyramid
-   **Visual**: A colored 3D Pyramid appears in the center of the view (Lleida).
-   **Purpose**: Demonstrate 3D KML generation.
-   **KML Element**: `<Placemark>` with `<Polygon>` geometry and `extrude=1`.
-   **Location**: Near LG Lab, Lleida (41.6176° N, 0.6200° E).

### Moment 3: Home City Flyover
-   **Visual**: Smooth camera flight from current location to Mumbai.
-   **Purpose**: Demonstrate navigation control.
-   **KML Element**: `gx:FlyTo` command sent to Master.
-   **Destination**: Mumbai (19.0760° N, 72.8777° E).

## KML Elements & Templates

| Feature | KML Structure | Target Screen |
| :--- | :--- | :--- |
| **Logo** | `<ScreenOverlay> ... <Icon>...URL...</Icon> ... </ScreenOverlay>` | Left (Slave 3) |
| **Pyramid** | `<Placemark> <Style>...</Style> <Polygon> <extrude>1</extrude> <outerBoundaryIs>...</outerBoundaryIs> </Polygon> </Placemark>` | Center (Master) |
| **Clean** | Empty KML `<kml><Document></Document></kml>` | All Screens |

## Interaction Map

| Phone Action | Rig Response | Implementation |
| :--- | :--- | :--- |
| Tap "Show Logo" | Logo appears on Left Screen | `SSHService.upload(slave_3.kml)` |
| Tap "Show Pyramid" | Pyramid appears on Center | `SSHService.upload(pyramid.kml)` + `FlyTo(pyramid)` |
| Tap "Fly to Home" | Camera flies to Mumbai | `SSHService.flyTo(Mumbai)` |
| Tap "Clean" | All content removed | `SSHService.clean()` (iterates all screens) |

## Performance Budget
-   **KML Size**: Very small (< 5KB).
-   **FlyTo Duration**: 3 seconds (smooth).
-   **Update Rate**: On demand (button press only).
