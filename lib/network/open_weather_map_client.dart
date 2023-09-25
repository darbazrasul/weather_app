import 'dart:convert';

import 'package:location/location.dart';
import 'package:weather_app/modles/for_cast_result.dart';
import 'package:weather_app/modles/weather_result.dart';
import 'package:http/http.dart' as http;

import '../const.dart';

class OpenWeatherMapClient {
  Future<WeatherResult> getWeather(LocationData locationData) async {
    if (locationData.latitude != null && locationData.longitude != null) {
      final res = await http.get(Uri.parse(
          '$apiUrl/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&units=metric&appid=$apiKey&lang=ru'));
      if (res.statusCode == 200) {
        return WeatherResult.fromJson(jsonDecode(res.body));
      } else {
        throw Exception('Bad request');
      }
    } else {
      throw Exception('wrong loaction');
    }
  }

  Future<ForCastResult> getForcast(LocationData locationData) async {
    if (locationData.latitude != null && locationData.longitude != null) {
      final res = await http.get(Uri.parse(
          '$apiUrl/forecast?lat=${locationData.latitude}&lon=${locationData.longitude}&exclude=hourly,daily&units=metric&appid=$apiKey'));

      if (res.statusCode == 200) {
        return ForCastResult.fromJson(jsonDecode(res.body));
      } else {
        throw Exception('Bad request');
      }
    } else {
      throw Exception('wrong loaction');
    }
  }
}
