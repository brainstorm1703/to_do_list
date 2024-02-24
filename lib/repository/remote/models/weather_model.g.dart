// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherModelAdapter extends TypeAdapter<WeatherModel> {
  @override
  final int typeId = 2;

  @override
  WeatherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherModel(
      temp: fields[1] as double,
      feelsLike: fields[2] as double,
      windSpeed: fields[3] as double,
      weatherDesription: fields[4] as String,
      country: fields[5] as String,
      cityName: fields[6] as String,
      iconName: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WeatherModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.temp)
      ..writeByte(2)
      ..write(obj.feelsLike)
      ..writeByte(3)
      ..write(obj.windSpeed)
      ..writeByte(4)
      ..write(obj.weatherDesription)
      ..writeByte(5)
      ..write(obj.country)
      ..writeByte(6)
      ..write(obj.cityName)
      ..writeByte(7)
      ..write(obj.iconName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      temp: (json['main']['temp'] as num).toDouble(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      weatherDesription: json['weather']['main'] as String,
      country: json['sys']['country'] as String,
      cityName: json['name'] as String,
      iconName: json['weather']['icon'] as String,
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'wind_speed': instance.windSpeed,
      'main': instance.weatherDesription,
      'country': instance.country,
      'city_name': instance.cityName,
      'icon': instance.iconName,
    };
