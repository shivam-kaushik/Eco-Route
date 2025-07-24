# EcoRoute Mobile App

A Flutter app prototype for eco-friendly route planning between cities with multiple transport modes. Shows distance, time, CO₂ emissions, and a score to help choose greener routes.

## Features
- Input screen with autocomplete city selection
- Results screen showing top 3 routes sorted by eco score
- Map preview with route polyline and markers
- State management with Provider for clean architecture
- Loads route data from local JSON asset

## Getting Started

1. Clone repo and run:
```
flutter pub get
flutter run
```
2. Routes data is loaded from `assets/routes.json`.

## Design Decisions

- Flutter for cross-platform native performance
- Provider for simple, reactive state management
- Google Maps Flutter for map preview

## Next Steps

Integrate real API, improve error handling, add caching/offline support, and enhance UI/UX for a production-ready app.
