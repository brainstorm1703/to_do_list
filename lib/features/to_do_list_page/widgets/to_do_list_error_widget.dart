import 'package:flutter/material.dart';

class ToDoListErrorWidget extends StatelessWidget {
  const ToDoListErrorWidget({super.key, required this.exception});

  final Object exception;

  @override
  Widget build(BuildContext context) {
    final errorMessage = 'Exception: ${exception.toString()}';
    return Center(
      child: Text(errorMessage),
    );
  }
}
