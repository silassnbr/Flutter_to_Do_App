import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TaskDetailPage extends StatefulWidget {
  final String taskId;
  final String taskTitle;
  final String taskDesc;
  bool taskCopm;
  TaskDetailPage(
      {required this.taskId,
      required this.taskTitle,
      required this.taskCopm,
      required this.taskDesc});

  @override
  _MyTaskPageState createState() => _MyTaskPageState();
}

class _MyTaskPageState extends State<TaskDetailPage> {
  void dialogDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Task Deleted"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void dialogDeleteError(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error Try Again!!!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> delete() async {
    final url = "http://api.nstack.in/v1/todos/${widget.taskId}";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      dialogDelete(context);
    } else {
      dialogDeleteError(context);
    }
  }

  void update() {
    print("update");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Details" + "   " + widget.taskTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: delete,
              child: Text("Delete Task"),
            ),
            ElevatedButton(
              onPressed: update,
              child: Text("Update Task"),
            ),
          ],
        ),
      ),
    );
  }
}
