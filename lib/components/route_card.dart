import 'package:flutter/material.dart';
import '../models/route_model.dart';
import '../theme/app_theme.dart';

class RouteCard extends StatelessWidget {
  final RouteModel route;
  final VoidCallback onTap;

  const RouteCard({
    super.key,
    required this.route,
    required this.onTap,
  });

  IconData _getTransportIcon(String mode) {
    switch (mode) {
      case 'driving': return Icons.directions_car;
      case 'bicycling': return Icons.directions_bike;
      case 'transit': return Icons.directions_transit;
      case 'walking': return Icons.directions_walk;
      default: return Icons.directions;
    }
  }

  Color _getTransportColor(String mode) {
    switch (mode) {
      case 'driving': return Colors.blue;
      case 'bicycling': return Colors.green;
      case 'transit': return Colors.purple;
      case 'walking': return Colors.orange;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.padding),
          child: Row(
            children: [
              Icon(
                _getTransportIcon(route.mode),
                color: _getTransportColor(route.mode),
                size: 32,
              ),
              const SizedBox(width: AppTheme.spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      route.mode.toUpperCase(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text('Distance: ${route.distanceKm} km'),
                    Text('Time: ${route.timeMin} min'),
                    Text('CO₂: ${route.co2g} g'),
                  ],
                ),
              ),
              Chip(
                label: Text(
                  'Score: ${route.score}',
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: _getTransportColor(route.mode).withOpacity(0.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}