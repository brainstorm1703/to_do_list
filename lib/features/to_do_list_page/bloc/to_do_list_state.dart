part of 'to_do_list_bloc.dart';

class ToDoListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToDoListInitial extends ToDoListState {}

class ToDoListLoading extends ToDoListState {}

class ToDoListLoaded extends ToDoListState {
  final List<TaskModel> toDoList;

  ToDoListLoaded({required this.toDoList});

  @override
  List<Object?> get props => [toDoList];
}

class TaskAdded extends ToDoListState {}

class TaskEdited extends ToDoListState {}

class TaskDeleted extends ToDoListState {}

class ToDoListFailure extends ToDoListState {
  final Object exception;

  ToDoListFailure(this.exception);

  @override
  List<Object?> get props => super.props..add(exception);
}
