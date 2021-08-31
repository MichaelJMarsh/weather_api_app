import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_api_app/src/weather_model.dart';

class WeatherRepo {
  String apiKey = "9f4a7c65eb277414490a50b0a5cbe89f";
  Future<WeatherModel> getCityWeather(String city) async {
    final result = await http.Client().get(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=9f4a7c65eb277414490a50b0a5cbe89f",
    );

    if (result.statusCode != 200) throw Exception();

    return parsedJson(result.body);
  }

  Future<WeatherModel> getZipCodeWeather(int zipCode) async {
    final result = await http.Client().get(
      "https://api.openweathermap.org/data/2.5/weather?zip=$zipCode,us&APPID=9f4a7c65eb277414490a50b0a5cbe89f",
    );

    if (result.statusCode != 200) throw Exception();

    return parsedJson(result.body);
  }

  WeatherModel parsedJson(final response) {
    final jsonDecoded = json.decode(response);

    final jsonWeather = jsonDecoded["main"];

    return WeatherModel.fromJson(jsonWeather);
  }
}
