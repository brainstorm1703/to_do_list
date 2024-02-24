import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/repository/local/abstract_to_do_list_repository.dart';
import 'package:to_do_list/repository/local/models/task_model.dart';

part 'to_do_list_event.dart';
part 'to_do_list_state.dart';

class ToDoListBloc extends Bloc<ToDoListEvent, ToDoListState> {
  ToDoListBloc(this.toDoListRepository) : super(ToDoListInitial()) {
    on<LoadToDoList>(_load);
    on<AddTask>(_add);
    on<EditTask>(_edit);
    on<DeleteTask>(_delete);
  }

  final AbstractToDoListRepository toDoListRepository;

  Future<void> _load(
    LoadToDoList event,
    Emitter<ToDoListState> emit,
  ) async {
    try {
      if (state is! ToDoListLoaded) {
        emit(ToDoListLoading());
      }
      final toDoList = await toDoListRepository.getAllTasks();
      emit(ToDoListLoaded(toDoList: toDoList));
    } catch (e) {
      emit(ToDoListFailure(e));
    }
  }

  Future<void> _add(
    AddTask event,
    Emitter<ToDoListState> emit,
  ) async {
    try {
      await toDoListRepository.addTask(event.task);
      emit(TaskAdded());
    } catch (e) {
      emit(ToDoListFailure(e));
    }
  }

  Future<void> _edit(
    EditTask event,
    Emitter<ToDoListState> emit,
  ) async {
    try {
      await toDoListRepository.editTask(event.oldTask, event.newTask);
      emit(TaskEdited());
    } catch (e) {
      emit(ToDoListFailure(e));
    }
  }

  Future<void> _delete(
    DeleteTask event,
    Emitter<ToDoListState> emit,
  ) async {
    try {
      await toDoListRepository.deleteTask(event.task);
      emit(TaskDeleted());
    } catch (e) {
      emit(ToDoListFailure(e));
    }
  }
}
