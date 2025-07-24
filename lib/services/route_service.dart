import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/city_model.dart';
import '../models/route_model.dart';

class RouteService {
  static final List<City> availableCities = [
    City(name: 'Toronto', latitude: 43.65, longitude: -79.34),
    City(name: 'Kitchener', latitude: 43.45, longitude: -80.49),
    City(name: 'Ottawa', latitude: 45.42, longitude: -75.69),
    City(name: 'Hamilton', latitude: 43.26, longitude: -79.87),
    City(name: 'London', latitude: 42.98, longitude: -81.25),
  ];

  Future<List<RouteModel>> fetchRoutes(String fromCity, String toCity) async {
    try {
      final _ = _getCity(fromCity);
      final _ = _getCity(toCity);

      final String response = await rootBundle.loadString('assets/routes.json');
      final List<dynamic> data = json.decode(response);

      return data.map((json) => RouteModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Invalid city selection. ${e.toString()}');
    }
  }

  City _getCity(String cityName) {
    return availableCities.firstWhere(
          (city) => city.name.toLowerCase() == cityName.toLowerCase(),
      orElse: () => throw Exception('Please select from: ${availableCities.map((c) => c.name).join(', ')}'),
    );
  }

  static String get cityListString =>
      availableCities.map((c) => c.name).join(', ');
}