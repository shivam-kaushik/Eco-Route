# EcoRoute Mobile App

A Flutter app prototype for eco-friendly route planning between cities with multiple transport modes. Shows distance, time, CO₂ emissions, and a score to help choose greener routes.

## Features
- Input screen with autocomplete city selection
- Results screen showing top 3 routes sorted by eco score
- Map preview with route polyline and markers
- State management with Provider for clean architecture
- Loads route data from local JSON asset

## Video Demo
Youtube: https://www.youtube.com/shorts/bp3ajxxMUWU

## Getting Started

## Quick Start
1. Install Dependencies
```
flutter pub get
```

2. Run the App
```
flutter run
```
The app starts on your connected emulator or device.

## Mock Data
Location: assets/routes.json

## Loading Method:
The mock routes are loaded at runtime using Flutter's rootBundle.loadString('assets/routes.json') method. The routes JSON includes multiple transport modes (driving, bicycling, transit, walking) with example metrics (distance, time, CO₂, score). No network configuration or mock server is needed.

## Design Decisions
Framework Choice:
Flutter was chosen for rapid cross-platform development, native performance, and expressive UI.

## Libraries:

provider — State management, for scalable and reactive UI.

google_maps_flutter — Interactive map previews, polylines, and markers.

Flutter core libraries for navigation and UI components.

## Project Structure:

assets/ — Static resources (including routes.json).

models/ — Data models (route, city).

providers/ — App state management.

screens/ — UI screens (Input, Results, Map).

services/ — Route data loading and business logic.

libs/ — Utilities and shared code to keep logic organized and reusable.

## Next Steps

To deliver a production-grade EcoRoute app, several enhancements are recommended. First, replace the static JSON with a real RESTful or GraphQL API to provide dynamic, scalable, and up-to-date routing. Implement authentication to enable personalized route histories, saved places, and individualized recommendations, ensuring user data is secure. Add persistent caching of routes and cities for improved performance and offline support using local storage solutions like hive or shared_preferences.

Enhance error handling across network, parsing, and user input flows to provide clear, actionable feedback. Expand the city database and integrate real geocoding services to accommodate more locations and user-defined addresses. Strengthen the testing suite with unit, widget, and integration tests, and set up continuous integration/continuous deployment (CI/CD) workflows for automated QA and streamlined releases. Finally, invest in accessibility improvements, theming, and support for multiple languages to make the app more usable and broadly accessible. These steps, together, will transform EcoRoute into a robust, user-friendly, and scalable platform supporting eco-conscious travel decisions.
