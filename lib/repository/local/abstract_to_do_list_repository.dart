import 'package:to_do_list/repository/local/models/task_model.dart';

abstract class AbstractToDoListRepository {
  Future<List<TaskModel>> getAllTasks();
  Future<void> addTask(TaskModel task);
  Future<void> editTask(TaskModel oldTask, TaskModel newTask);
  Future<void> deleteTask(TaskModel task);
}
