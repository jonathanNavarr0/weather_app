import 'package:flutter/material.dart';
import 'services/weather_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clima App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService();
  final _cityController = TextEditingController();
  Map<String, dynamic>? _weatherData;
  String _error = '';

  void _search() async {
    try {
      final data = await _weatherService.getWeather(_cityController.text);
      setState(() {
        _weatherData = data;
        _error = '';
      });
    } catch (e) {
      setState(() {
        _error = 'No se pudo obtener el clima';
        _weatherData = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta el Clima')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: InputDecoration(labelText: 'Ciudad'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _search,
              child: Text('Buscar'),
            ),
            SizedBox(height: 20),
            if (_error.isNotEmpty)
              Text(
                _error,
                style: TextStyle(color: Colors.red),
              ),
            if (_weatherData != null) ...[
              Text(
                '${_weatherData!['name']}',
                style: TextStyle(fontSize: 22),
              ),
              Text(
                '${_weatherData!['main']['temp']} °C',
                style: TextStyle(fontSize: 26),
              ),
              Text(
                '${_weatherData!['weather'][0]['description']}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
