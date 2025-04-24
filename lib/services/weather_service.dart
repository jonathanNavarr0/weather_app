import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'a5e8fed2c9c680345e9f09a69ead0602'; // tu API key
  final String baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url =
        Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric&lang=es');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener el clima');
    }
  }
}
