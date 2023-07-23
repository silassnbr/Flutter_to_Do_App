import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  final String taskId;

  TaskDetailPage({required this.taskId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task ID"),
      ),
      body: Center(
        child: Text("Task ID: $taskId"),
      ),
    );
  }
}
