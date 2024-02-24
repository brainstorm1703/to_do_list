import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends Equatable {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final bool isFinished;
  @HiveField(5)
  final String dateOfCreation;
  const TaskModel({
    required this.name,
    required this.description,
    required this.category,
    required this.isFinished,
    required this.dateOfCreation,
  });
  @override
  List<Object> get props =>
      [name, description, category, isFinished, dateOfCreation];
}
