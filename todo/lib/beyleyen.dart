import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/functions.dart';
import 'package:todo/models/tasks.dart';
import 'package:todo/taskDetail.dart';

class Bekleyen extends StatefulWidget {
  const Bekleyen({super.key});

  @override
  State<Bekleyen> createState() => _BekleyenState();
}

class _BekleyenState extends State<Bekleyen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: getBekleyenler(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: bekleyenlerTitle.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            taskTap(index);
                          },
                          title: Text(bekleyenlerTitle[index]),
                          subtitle: Text(
                              bekleyenlerDes[index] + bekleyenlerId[index]),
                          // ... diğer ListTile özellikleri ...
                        );
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }

  void taskTap(int index) {
    final String taskId = bekleyenlerId[index];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage(
          taskId: taskId,
          taskCopm: false,
          taskDesc: bekleyenlerDes[index],
          taskTitle: bekleyenlerTitle[index],
        ),
      ),
    );
  }
}
