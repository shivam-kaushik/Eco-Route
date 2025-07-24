class RouteModel {
  final String mode;
  final double distanceKm;
  final int timeMin;
  final int co2g;
  final double score;

  RouteModel({
    required this.mode,
    required this.distanceKm,
    required this.timeMin,
    required this.co2g,
    required this.score,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      mode: json['mode'],
      distanceKm: json['distance_km'],
      timeMin: json['time_min'],
      co2g: json['co2_g'],
      score: json['score'],
    );
  }
}