import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:to_do_list/features/to_do_list_page/bloc/to_do_list_bloc.dart';
import 'package:to_do_list/features/to_do_list_page/widgets/to_do_list_error_widget.dart';
import 'package:to_do_list/features/to_do_list_page/widgets/to_do_list_widget.dart';
import 'package:to_do_list/repository/local/abstract_to_do_list_repository.dart';
import 'package:to_do_list/repository/local/models/task_model.dart';
import 'package:to_do_list/theme/theme.dart';

class ToDoListPageScreen extends StatefulWidget {
  const ToDoListPageScreen({super.key});

  @override
  State<ToDoListPageScreen> createState() => _ToDoListPageScreenState();
}

class _ToDoListPageScreenState extends State<ToDoListPageScreen> {
  final _toDoListBloc = ToDoListBloc(GetIt.I<AbstractToDoListRepository>());
  bool _showFinished = false;
  bool _showUnfinished = false;
  List<String> _selectedCategory = [];
  List<String> _allCategory = [];

  @override
  void initState() {
    _toDoListBloc.add(LoadToDoList());
    super.initState();
  }

  List<String> getAllCategory(List<TaskModel> toDoList) {
    List<String> uniqueCategories =
        toDoList.map((task) => task.category).toSet().toList();
    return uniqueCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => _filterMenu(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ToDoListBloc, ToDoListState>(
        bloc: _toDoListBloc,
        builder: (context, state) {
          if (state is ToDoListLoaded) {
            if (state.toDoList.isNotEmpty) {
              _allCategory = getAllCategory(state.toDoList);
              return ToDoListWidget(
                toDoList: state.toDoList,
                toDoListBloc: _toDoListBloc,
                showFinished: _showFinished,
                showUnfinished: _showUnfinished,
                selectedCategory: _selectedCategory,
              );
            }
          }
          if (state is TaskAdded ||
              state is TaskDeleted ||
              state is TaskEdited) {
            _toDoListBloc.add(LoadToDoList());
          }
          if (state is ToDoListFailure) {
            return ToDoListErrorWidget(exception: state.exception);
          }
          return const Center(child: Text('No Task. Create new!'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).pushNamed(
            '/action_with_task',
            arguments: {
              'task': const TaskModel(
                  name: '',
                  description: '',
                  category: '',
                  isFinished: false,
                  dateOfCreation: ''),
              'bloc': _toDoListBloc,
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _filterMenu() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[850],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CheckboxListTile(
            title: Text(
              'Show Finished Task',
              style: theme.textTheme.bodyMedium,
            ),
            value: _showFinished,
            onChanged: (value) {
              setState(() {
                _showFinished = !_showFinished;
              });
            },
          ),
          CheckboxListTile(
            title: Text(
              'Show Unfinished Task',
              style: theme.textTheme.bodyMedium,
            ),
            value: _showUnfinished,
            onChanged: (value) {
              setState(() {
                _showUnfinished = !_showUnfinished;
              });
            },
          ),
          const Divider(),
          Text(
            'Category',
            style: theme.textTheme.bodyMedium,
          ),
          for (final category in _allCategory)
            CheckboxListTile(
              title: Text(
                category,
                style: theme.textTheme.bodyMedium,
              ),
              value: _selectedCategory.contains(category),
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    if (value) {
                      _selectedCategory.add(category);
                    } else {
                      _selectedCategory.remove(category);
                    }
                  }
                });
              },
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Apply',
              style: theme.textTheme.headlineMedium,
            ),
          ),
        ],
      ),
    );
  }
}
