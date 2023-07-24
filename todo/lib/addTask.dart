import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/home.dart';
import 'package:http/http.dart' as http;

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final controllerTitle = TextEditingController();
  final controllerDes = TextEditingController();
  @override
  void dispose() {
    controllerTitle.dispose();
    controllerDes.dispose();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Task Added"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controllerDes.clear();
                controllerTitle.clear();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onSaveButtonPressed() async {
    if (controllerTitle.text.trim().isEmpty ||
        controllerDes.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Please fill title and description !!!',
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      final title = controllerTitle.text.toString();

      final desc = controllerDes.text.toString();
      final body = {
        "title": title.toString(),
        "description": desc.toString(),
        "is_completed": false,
      };

      const url = "http://api.nstack.in/v1/todos";
      final uri = Uri.parse(url.toString());
      final res = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (res.statusCode == 201) {
        _showAlertDialog(context);
      } else {
        print("hata");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Add Task",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: controllerTitle,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Title',
                    fillColor: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: controllerDes,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _onSaveButtonPressed,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
