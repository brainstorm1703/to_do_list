import 'package:flutter/material.dart';
import 'package:to_do_list/features/to_do_list_page/bloc/to_do_list_bloc.dart';
import 'package:to_do_list/repository/local/models/task_model.dart';
import 'package:to_do_list/theme/theme.dart';

class ActionWithTask extends StatefulWidget {
  const ActionWithTask({super.key});

  @override
  State<ActionWithTask> createState() => _ActionWithTaskState();
}

class _ActionWithTaskState extends State<ActionWithTask> {
  TaskModel? task;
  ToDoListBloc? toDoListBloc;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    task = args['task'] as TaskModel;
    toDoListBloc = args['bloc'] as ToDoListBloc;

    _nameController.text = task!.name;
    _descriptionController.text = task!.description;
    _categoryController.text = task!.category;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _createTextFormField('Name', _nameController),
              _createTextFormField('Description', _descriptionController),
              _createTextFormField('Category', _categoryController),
              _createButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Padding _createTextFormField(String data, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Input $data',
          enabledBorder: theme.inputDecorationTheme.enabledBorder,
          focusedBorder: theme.inputDecorationTheme.enabledBorder,
        ),
        style: theme.textTheme.bodyMedium,
      ),
    );
  }

  Widget _createButtons() {
    if (task!.name == '') {
      return Center(child: _createButton('Save'));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _createButton('Delete'),
          _createButton('Edit'),
        ],
      );
    }
  }

  TextButton _createButton(String text) {
    return TextButton(
      onPressed: () {
        final newTask = TaskModel(
          name: _nameController.text,
          description: _descriptionController.text,
          category: _categoryController.text,
          isFinished: task!.isFinished,
          dateOfCreation: DateTime.now().toString(),
        );
        switch (text) {
          case 'Save':
            toDoListBloc!.add(AddTask(task: newTask));
            break;
          case 'Delete':
            toDoListBloc!.add(DeleteTask(task: task!));
            break;
          case 'Edit':
            toDoListBloc!.add(EditTask(oldTask: task!, newTask: newTask));
            break;
        }
        Navigator.of(context).pop();
      },
      child: Text(
        text,
        style: theme.textTheme.bodyMedium,
      ),
    );
  }
}
