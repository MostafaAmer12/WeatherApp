import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  WeatherModel? weather;
  String baseUrl = 'https://api.weatherapi.com/v1';
  String apiKey = 'a46e25a474f745e5b22160635231208';

  Future<WeatherModel?> getWeather({required String cityName}) async {
    try {
      Uri url =
          Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);

      weather = WeatherModel.fromJson(data);
    } catch (e) {
      print(e);
    }

    return weather;
  }
}
