import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/functions.dart';
import 'package:todo/taskDetail.dart';

class HomePage extends StatefulWidget {
  final Key? key;
  const HomePage({this.key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: getAllTasks(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "All Tasks Number=${snapshot.data!.meta!.totalItems}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Complated Tasks Number=$sayi"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "Uncomplated Tasks=${snapshot.data!.meta!.totalItems! - sayi}"),
                      ),
                      const Divider(thickness: 2, color: Colors.red),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: bekleyenler.length >= 3
                                ? 3
                                : bekleyenler.length,
                            itemBuilder: (context, index) {
                              final task = snapshot.data!.items![
                                  bekleyenler[bekleyenler.length - index - 1]];
                              return ListTile(
                                onTap: () {
                                  String title = "";
                                  String desc = "";
                                  String id = "";
                                  bool complate = false;
                                  setState(() {
                                    title = task.title.toString();
                                    desc = task.description.toString();
                                    id = task.sId.toString();
                                    complate = task.isCompleted!;
                                  });
                                  onClick(title, desc, id, complate);
                                },
                                title: Text(task.title.toString()),
                                subtitle: Text("${task.description}"),
                                // ... diğer ListTile özellikleri ...
                              );
                            },
                          ))
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }

  void onClick(String title, String desc, String id, bool complate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailPage(
          taskId: id,
          taskCopm: complate,
          taskDesc: desc,
          taskTitle: title,
        ),
      ),
    );
  }
}
