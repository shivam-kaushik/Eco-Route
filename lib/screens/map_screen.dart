import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/city_model.dart';

class MapScreen extends StatefulWidget {
  final City startCity;
  final City endCity;

  const MapScreen({
    Key? key,
    required this.startCity,
    required this.endCity,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  late BitmapDescriptor _startIcon;
  late BitmapDescriptor _endIcon;

  @override
  void initState() {
    super.initState();
    _loadMarkerIcons();
  }

  void _loadMarkerIcons() {
    _startIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
    _endIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _zoomToFit();
  }

  void _zoomToFit() {
    final bounds = LatLngBounds(
      northeast: LatLng(
        max(widget.startCity.latitude, widget.endCity.latitude) + 0.2,
        max(widget.startCity.longitude, widget.endCity.longitude) + 0.2,
      ),
      southwest: LatLng(
        min(widget.startCity.latitude, widget.endCity.latitude) - 0.2,
        min(widget.startCity.longitude, widget.endCity.longitude) - 0.2,
      ),
    );
    _mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.startCity.name} → ${widget.endCity.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.center_focus_strong),
            onPressed: _zoomToFit,
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            (widget.startCity.latitude + widget.endCity.latitude) / 2,
            (widget.startCity.longitude + widget.endCity.longitude) / 2,
          ),
          zoom: 8,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('start'),
            position: widget.startCity.toLatLng(),
            icon: _startIcon,
            infoWindow: InfoWindow(
              title: 'Start: ${widget.startCity.name}',
              snippet: '${widget.startCity.latitude}, ${widget.startCity.longitude}',
            ),
          ),
          Marker(
            markerId: const MarkerId('end'),
            position: widget.endCity.toLatLng(),
            icon: _endIcon,
            infoWindow: InfoWindow(
              title: 'Destination: ${widget.endCity.name}',
              snippet: '${widget.endCity.latitude}, ${widget.endCity.longitude}',
            ),
          ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            points: [widget.startCity.toLatLng(), widget.endCity.toLatLng()],
            color: Colors.blue,
            width: 5,
            geodesic: true,
          ),
        },
      ),
    );
  }
}