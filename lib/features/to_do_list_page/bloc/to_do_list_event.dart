part of 'to_do_list_bloc.dart';

abstract class ToDoListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadToDoList extends ToDoListEvent {}

class AddTask extends ToDoListEvent {
  final TaskModel task;

  AddTask({required this.task});

  @override
  List<Object> get props => [task];
}

class EditTask extends ToDoListEvent {
  final TaskModel oldTask, newTask;

  EditTask({required this.oldTask, required this.newTask});
  @override
  List<Object> get props => [oldTask, newTask];
}

class DeleteTask extends ToDoListEvent {
  final TaskModel task;

  DeleteTask({required this.task});

  @override
  List<Object> get props => [task];
}
