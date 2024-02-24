import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class WeatherModel extends Equatable {
  @JsonKey(name: 'temp')
  @HiveField(1)
  final double temp;
  @JsonKey(name: 'feels_like')
  @HiveField(2)
  final double feelsLike;
  @JsonKey(name: 'wind_speed')
  @HiveField(3)
  final double windSpeed;
  @JsonKey(name: 'main')
  @HiveField(4)
  final String weatherDesription;
  @JsonKey(name: 'country')
  @HiveField(5)
  final String country;
  @JsonKey(name: 'city_name')
  @HiveField(6)
  final String cityName;
  @JsonKey(name: 'icon')
  @HiveField(7)
  final String iconName;

  const WeatherModel(
      {required this.temp,
      required this.feelsLike,
      required this.windSpeed,
      required this.weatherDesription,
      required this.country,
      required this.cityName,
      required this.iconName});
  @override
  List<Object> get props => [temp, feelsLike, windSpeed, weatherDesription];
}
