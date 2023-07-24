import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/functions.dart';
import 'package:todo/models/tasks.dart';
import 'package:todo/taskDetail.dart';

class Tamamlanan extends StatefulWidget {
  const Tamamlanan({super.key});

  @override
  State<Tamamlanan> createState() => _BekleyenState();
}

class _BekleyenState extends State<Tamamlanan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: getTamamlanan(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: tamamlananTitle.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            taskTapp(index);
                          },
                          title: Text(tamamlananTitle[index]),
                          subtitle: Text(tamamlananDes[index]),
                        );
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }

  void taskTapp(int index) {
    final String taskId = tamamlananId[index];
    bool a = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage(
          taskId: taskId,
          taskCopm: true,
          taskDesc: tamamlananDes[index],
          taskTitle: tamamlananTitle[index],
        ),
      ),
    );
  }
}
