import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/repository/local/abstract_to_do_list_repository.dart';
import 'package:to_do_list/repository/local/models/task_model.dart';
import 'package:to_do_list/repository/local/to_do_list_repository.dart';
import 'package:to_do_list/repository/remote/abstract_weather_repository.dart';
import 'package:to_do_list/repository/remote/models/weather_model.dart';
import 'package:to_do_list/repository/remote/weather_repository.dart';
import 'package:to_do_list/to_do_list_app.dart';

void main() async {
  const toDoListBoxName = 'to_do_list_box';
  const weatherBoxName = 'weather_box';
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(WeatherModelAdapter());
  final toDoListBox = await Hive.openBox<TaskModel>(toDoListBoxName);
  final weatherBox = await Hive.openBox<WeatherModel>(weatherBoxName);
  GetIt.I.registerLazySingleton<AbstractToDoListRepository>(
      () => ToDoListRepository(toDoListBox: toDoListBox));

  GetIt.I.registerLazySingleton<AbstractWeatherRepository>(
      () => WeatherRespository(dio: Dio(), weatherBox: weatherBox));
  runApp(const ToDoListApp());
}
