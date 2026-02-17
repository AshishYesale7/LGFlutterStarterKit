# Learning Journal - LG Task 2 App

## Stage 1: Initialization
-   **Challenge**: Flutter SDK not found in PATH.
-   **Solution**: Proceeded with code generation while requesting user input.
-   **Key Constraint**: Strict LG architecture (Controller-Responder).

## Stage 2: Brainstorming
-   **Decision**: Use `ScreenOverlay` for Logo (Slave 3) and `Polygon` for Pyramid (Master).
-   **Architecture**: Followed the Service Layer pattern strictly. No logic in UI.

## Stage 3: Visualization Design
-   **KML Strategy**: 
    -   Generated KML dynamically using Dart strings.
    -   Used `dartssh2` for transport.
    -   Implemented a "Clean" function to clear both KMLs and Logos.

## Stage 5: Data Pipeline
-   **Models**: Created `ConnectionStatus` enum.
-   **Services**:
    -   `SSHService`: Handles raw socket communication.
    -   `KMLService`: Generates XML content.
    -   `LGService`: Facade for UI interaction.

## Stage 6: UI Scaffolding
-   **Providers**: implemented `ThemeProvider` and `SettingsProvider`.
-   **Screens**:
    -   `SplashScreen`: Simple branding.
    -   `ConnectionScreen`: Credentials input.
    -   `MainScreen`: Grid of action buttons.
    -   `SettingsScreen`: Configuration.
    -   `HelpScreen`: Instructions.
-   **Compliance**: UI only calls `LGService`, never `SSHService` directly.
