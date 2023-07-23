import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/functions.dart';

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
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                color: Colors.purple[200],
                                child: Center(
                                    child: Text(
                                        "${snapshot.data!.items![bekleyenler[0]].title}\n${snapshot.data!.items![bekleyenler[0]].description}")),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                color: Colors.purple[200],
                                child: Center(
                                  child: Text(
                                      "${snapshot.data!.items![bekleyenler[1]].title}\n${snapshot.data!.items![bekleyenler[1]].description}"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                color: Colors.purple[200],
                                child: Center(
                                  child: Text(
                                      "${snapshot.data!.items![bekleyenler[2]].title}\n${snapshot.data!.items![bekleyenler[2]].description}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }
}
