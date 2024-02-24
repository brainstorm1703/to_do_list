import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/repository/local/abstract_to_do_list_repository.dart';
import 'package:to_do_list/repository/local/models/task_model.dart';

class ToDoListRepository extends AbstractToDoListRepository {
  final Box<TaskModel> toDoListBox;

  ToDoListRepository({required this.toDoListBox});

  @override
  Future<List<TaskModel>> getAllTasks() async {
    final toDoList = toDoListBox.values.toList();

    // сортировка -> сначала новые, после старые
    toDoList.sort((a, b) => b.dateOfCreation.compareTo(a.dateOfCreation));
    return Future.value(toDoList);
  }

  @override
  Future<void> addTask(TaskModel task) async {
    await toDoListBox.put(task.dateOfCreation, task);
  }

  @override
  Future<void> editTask(TaskModel oldTask, TaskModel newTask) async {
    deleteTask(oldTask);
    addTask(newTask);
  }

  @override
  Future<void> deleteTask(TaskModel task) async {
    await toDoListBox.delete(task.dateOfCreation);
  }
}
