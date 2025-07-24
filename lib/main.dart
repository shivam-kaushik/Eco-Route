import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eco_route_mobile/providers/route_provider.dart';
import 'package:eco_route_mobile/screens/input_screen.dart';
import 'package:eco_route_mobile/screens/results_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RouteProvider(),
      child: MaterialApp(
        title: 'EcoRoute',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const InputScreen(),
          '/results': (context) => const ResultsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}