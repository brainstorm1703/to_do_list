import 'package:to_do_list/repository/remote/models/weather_model.dart';

abstract class AbstractWeatherRepository {
  Future<WeatherModel> getWeatherByCity(String city);
  String getCity();
  void saveCity(WeatherModel weather);
  String getImageUrl(String iconName);
}
