import 'dart:convert';

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
  final titleContr = TextEditingController();
  final desContr = TextEditingController();

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
                FocusScope.of(context).unfocus();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void dialogUpdated(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Task Updated"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus();
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

  Future<void> update() async {
    if (titleContr.text.trim().isEmpty || desContr.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Please write title and description !!!',
          style: TextStyle(fontSize: 20),
        ),
      ));
    } else {
      final title = titleContr.text.toString();

      final desc = desContr.text.toString();
      final compl = dropdownValue;
      print(dropdownValue);
      String aa = widget.taskId;

      final body = {
        "title": title,
        "description": desc,
        "is_completed": dropdownValue,
      };
      final url = "http://api.nstack.in/v1/todos/$aa";
      final uri = Uri.parse(url);
      final responseUpdate = await http.put(
        uri,
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (responseUpdate.statusCode == 200) {
        dialogUpdated(context);
      } else {
        dialogDeleteError(context);
      }
    }
  }

  String dropdownValue = "";
  @override
  void initState() {
    super.initState();
    titleContr.text = widget.taskTitle;
    desContr.text = widget.taskDesc;
    dropdownValue = widget.taskCopm.toString();
  }

  List<bool> list = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("TİTLE:  " + widget.taskTitle),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("DESCRIPTION:  " + widget.taskDesc),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red.shade300)),
                  onPressed: delete,
                  child: const Text("Delete Task"),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.green[400],
                ),
                const Text(
                  "Update Task",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.purple),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: titleContr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'New Title',
                        labelText: 'New Title',
                        fillColor: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: desContr,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'New Description',
                        labelText: 'New Description',
                        fillColor: Colors.white),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Is Complated:",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        elevation: 16,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        underline: Container(
                          width: 10,
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                        items: list.map<DropdownMenuItem<String>>((bool value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue.shade300)),
                    onPressed: update,
                    child: const Text("Update Task"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
