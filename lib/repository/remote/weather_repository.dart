import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/repository/remote/abstract_weather_repository.dart';
import 'package:to_do_list/repository/remote/models/weather_model.dart';
import 'package:dio/dio.dart';

class WeatherRespository extends AbstractWeatherRepository {
  final Dio dio;

  final Box<WeatherModel> weatherBox;

  WeatherRespository({required this.dio, required this.weatherBox});

  final String apiKey = '&appid=1369dd6b5ae78fc9952261ab9aa236b4';

  final String uri = 'https://api.openweathermap.org/';
  final String uriForWeather = 'data/2.5/weather?units=metric';
  final String uriForIcon = 'img/w/';

  @override
  Future<WeatherModel> getWeatherByCity(String city) async {
    weatherBox.clear();
    try {
      final response = await dio.get('$uri$uriForWeather$apiKey&q=$city');

      final data = response.data as Map<String, dynamic>;

      final weather = WeatherModel(
        temp: data['main']['temp'],
        feelsLike: data['main']['feels_like'],
        windSpeed: data['wind']['speed'],
        weatherDesription: data['weather'][0]['main'],
        country: data['sys']['country'],
        cityName: data['name'],
        iconName: data['weather'][0]['icon'],
      );
      return weather;
    } catch (e) {
      return const WeatherModel(
          temp: 0.0,
          feelsLike: 0.0,
          windSpeed: 0.0,
          weatherDesription: '',
          country: '',
          cityName: '',
          iconName: '');
    }
  }

  @override
  String getCity() {
    if (weatherBox.get('city') != null) {
      return weatherBox.get('city')!.cityName;
    }
    return '';
  }

  @override
  void saveCity(WeatherModel weather) {
    weatherBox.put('city', weather);
  }

  @override
  String getImageUrl(String iconName) {
    return '$uri$uriForIcon$iconName';
  }
}
