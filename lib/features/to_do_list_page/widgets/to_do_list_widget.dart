import 'package:flutter/material.dart';
import 'package:to_do_list/features/to_do_list_page/bloc/to_do_list_bloc.dart';
import 'package:to_do_list/repository/local/models/task_model.dart';

class ToDoListWidget extends StatefulWidget {
  const ToDoListWidget(
      {super.key,
      required this.toDoList,
      required this.toDoListBloc,
      required this.showFinished,
      required this.showUnfinished,
      required this.selectedCategory});

  final List<TaskModel> toDoList;
  final ToDoListBloc toDoListBloc;
  final bool showFinished;
  final bool showUnfinished;
  final List<String> selectedCategory;

  @override
  State<ToDoListWidget> createState() => _ToDoListWidgetState();
}

class _ToDoListWidgetState extends State<ToDoListWidget> {
  List<TaskModel> toDoList = [];
  void sortToDoList() {
    if (!widget.showFinished &&
        !widget.showUnfinished &&
        widget.selectedCategory.isEmpty) {
      toDoList = widget.toDoList;
      return;
    }
    Set<TaskModel> chosenTask = {};
    if (widget.selectedCategory.isNotEmpty) {
      for (final task in widget.toDoList) {
        if (widget.selectedCategory.contains(task.category)) {
          chosenTask.add(task);
        } else {
          chosenTask.remove(task);
        }
      }
    }
    if (widget.showFinished) {
      for (final task in widget.toDoList) {
        if (task.isFinished &&
            widget.selectedCategory.contains(task.category)) {
          chosenTask.add(task);
        } else {
          chosenTask.remove(task);
        }
      }
    }
    if (widget.showUnfinished) {
      for (final task in widget.toDoList) {
        if (!task.isFinished &&
            widget.selectedCategory.contains(task.category)) {
          chosenTask.add(task);
        } else {
          chosenTask.remove(task);
        }
      }
    }
    toDoList = chosenTask.toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    sortToDoList();
    return Scaffold(
      body: ListView.separated(
        itemCount: toDoList.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          String name = toDoList[index].name;
          String category = toDoList[index].category;
          String description = toDoList[index].description;
          if (description.split(' ').length > 2) {
            List<String> words = toDoList[index].description.split(' ');
            for (int i = 1; i < words.length; i += 3) {
              words.insert(i, '\n');
            }
            description = words.join(' ');
          }
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).pushNamed(
                '/action_with_task',
                arguments: {
                  'task': toDoList[index],
                  'bloc': widget.toDoListBloc,
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[850],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          'task name: $name',
                          softWrap: true,
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'description: $description',
                          softWrap: true,
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'category: $category',
                          softWrap: true,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Checkbox(
                      value: toDoList[index].isFinished,
                      onChanged: (value) {
                        widget.toDoListBloc.add(
                          EditTask(
                            oldTask: toDoList[index],
                            newTask: TaskModel(
                              name: toDoList[index].name,
                              description: toDoList[index].description,
                              category: toDoList[index].category,
                              isFinished: !toDoList[index].isFinished,
                              dateOfCreation: toDoList[index].dateOfCreation,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
