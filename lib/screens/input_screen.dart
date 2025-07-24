import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/route_provider.dart';
import '../services/route_service.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  late final TextEditingController _fromController;
  late final TextEditingController _toController;
  String? _inputError;

  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController();
    _toController = TextEditingController();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _fetchRoutes(BuildContext context) async {
    setState(() => _inputError = null);
    final routeProvider = Provider.of<RouteProvider>(context, listen: false);

    if (_fromController.text.isEmpty || _toController.text.isEmpty) {
      setState(() => _inputError = 'Please enter both cities');
      return;
    }

    await routeProvider.fetchRoutes(_fromController.text, _toController.text);
    if (mounted && routeProvider.error.isEmpty) {
      Navigator.pushNamed(context, '/results');
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeProvider = Provider.of<RouteProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('EcoRoute')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return RouteService.availableCities
                        .map((city) => city.name)
                        .where((name) => name.toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  onSelected: (String value) => _fromController.text = value,
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: _fromController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(labelText: 'From:'),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return RouteService.availableCities
                        .map((city) => city.name)
                        .where((name) => name.toLowerCase()
                        .contains(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  onSelected: (String value) => _toController.text = value,
                  fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                    return TextField(
                      controller: _toController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(labelText: 'To:'),
                    );
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: routeProvider.isLoading
                      ? null
                      : () => _fetchRoutes(context),
                  child: const Text('Find Routes'),
                ),
                if (_inputError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      _inputError!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
                if (routeProvider.error.isNotEmpty && _inputError == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      routeProvider.error,
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ),
              ],
            ),
          ),
          if (routeProvider.isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Show available cities',
        child: const Icon(Icons.list),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Available Cities'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: RouteService.availableCities.length,
                itemBuilder: (context, index) {
                  final city = RouteService.availableCities[index];
                  return ListTile(
                    title: Text(city.name),
                    subtitle: Text('${city.latitude}, ${city.longitude}'),
                    onTap: () {
                      Navigator.pop(context);
                      if (_fromController.text.isEmpty) {
                        _fromController.text = city.name;
                      } else {
                        _toController.text = city.name;
                      }
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}