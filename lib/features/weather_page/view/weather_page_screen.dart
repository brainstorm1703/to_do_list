import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_list/repository/remote/abstract_weather_repository.dart';
import 'package:to_do_list/repository/remote/models/weather_model.dart';
import 'package:to_do_list/theme/theme.dart';

class WeatherPageScreen extends StatefulWidget {
  const WeatherPageScreen({super.key});

  @override
  State<WeatherPageScreen> createState() => _WeatherPageScreenState();
}

class _WeatherPageScreenState extends State<WeatherPageScreen> {
  late String cityName;
  final TextEditingController _cityNameController = TextEditingController();
  WeatherModel? weather;
  final weatherRespository = GetIt.I<AbstractWeatherRepository>();

  Future<void> getWeather() async {
    final weatherData = await weatherRespository.getWeatherByCity(cityName);
    setState(() {
      weather = weatherData;
    });
  }

  @override
  void initState() {
    super.initState();
    cityName = weatherRespository.getCity();
    if (cityName == '') {
      cityName = 'kyiv';
    }
    _cityNameController.text = cityName;
    getWeather();
  }

  @override
  void dispose() {
    weatherRespository.saveCity(weather!);
    _cityNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _cityNameController,
            decoration: InputDecoration(
              labelText: 'Input City Name',
              enabledBorder: theme.inputDecorationTheme.enabledBorder,
              focusedBorder: theme.inputDecorationTheme.enabledBorder,
            ),
            style: theme.textTheme.bodyMedium,
            onChanged: (text) {
              setState(() {
                cityName = text;
              });
            },
          ),
          TextButton(
            onPressed: () async {
              await getWeather();
              weatherRespository.saveCity(weather!);
            },
            child: Text(
              'Get Weather',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Center(
            child: Column(
              children: [
                weather != null
                    ? weather!.cityName != ''
                        ? weatherWidget()
                        : const Center(
                            child: Text('Wrong city name'),
                          )
                    : const Center(child: CircularProgressIndicator()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget weatherWidget() {
    return Column(
      children: [
        Text('${weather!.cityName}\n${weather!.country}'),
        const SizedBox(
          width: 10,
        ),
        Text(
            'Temperature: ${weather!.temp}\n Feels like: ${weather!.feelsLike}'),
        const SizedBox(
          width: 10,
        ),
        Text('Wind speed: ${weather!.windSpeed}'),
        const SizedBox(
          width: 10,
        ),
        Image.network(
          weatherRespository.getImageUrl(weather!.iconName),
          color: Colors.white,
        ),
      ],
    );
  }
}
