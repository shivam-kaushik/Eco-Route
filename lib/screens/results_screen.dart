import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/city_model.dart';
import '../models/route_model.dart';
import '../providers/route_provider.dart';
import '../services/route_service.dart';
import 'map_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context);
    final fromCity = routeProvider.fromCity ?? 'Unknown';
    final toCity = routeProvider.toCity ?? 'Unknown';

    final topRoutes = List<RouteModel>.from(routeProvider.routes)
      ..sort((a, b) => a.score.compareTo(b.score));
    final displayedRoutes = topRoutes.take(3).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Recommended Routes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '$fromCity → $toCity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: displayedRoutes.length,
              itemBuilder: (context, index) {
                final route = displayedRoutes[index];
                return Card(
                  child: ListTile(
                    leading: Icon(
                      _getTransportIcon(route.mode),
                      color: _getTransportColor(route.mode),
                    ),
                    title: Text(route.mode.toUpperCase()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Distance: ${route.distanceKm} km'),
                        Text('Time: ${route.timeMin} min'),
                        Text('CO₂: ${route.co2g} g'),
                      ],
                    ),
                    trailing: Chip(
                      label: Text('Score: ${route.score}'),
                      backgroundColor: _getTransportColor(route.mode).withOpacity(0.2),
                    ),
                    onTap: () {
                      final startCity = RouteService.availableCities.firstWhere(
                            (city) => city.name == fromCity,
                        orElse: () => City(name: fromCity, latitude: 0, longitude: 0),
                      );
                      final endCity = RouteService.availableCities.firstWhere(
                            (city) => city.name == toCity,
                        orElse: () => City(name: toCity, latitude: 0, longitude: 0),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            startCity: startCity,
                            endCity: endCity,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

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
}