import 'package:flutter/cupertino.dart';
import '../models/route_model.dart';
import '../services/route_service.dart';

class RouteProvider with ChangeNotifier {
  final RouteService _routeService = RouteService();
  List<RouteModel> _routes = [];
  bool _isLoading = false;
  String _error = '';
  String? _fromCity;
  String? _toCity;

  List<RouteModel> get routes => _routes;
  bool get isLoading => _isLoading;
  String get error => _error;
  String? get fromCity => _fromCity;
  String? get toCity => _toCity;

  Future<void> fetchRoutes(String fromCity, String toCity) async {
    _isLoading = true;
    _error = '';
    _fromCity = fromCity;
    _toCity = toCity;
    notifyListeners();

    try {
      _routes = await _routeService.fetchRoutes(fromCity, toCity);
      if (_routes.isEmpty) {
        _error = 'No routes found between these cities';
      }
    } catch (e) {
      _routes = [];
      _error = e.toString().replaceAll('Exception:', '').trim();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}