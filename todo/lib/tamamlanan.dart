import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todo/functions.dart';
import 'package:todo/models/tasks.dart';

class Tamamlanan extends StatefulWidget {
  const Tamamlanan({super.key});

  @override
  State<Tamamlanan> createState() => _BekleyenState();
}

class _BekleyenState extends State<Tamamlanan> {
  List<Tasks>? _tasks;
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
                          title: Text(tamamlananTitle[index]),
                          subtitle: Text(tamamlananDes[index]),
                          // ... diğer ListTile özellikleri ...
                        );
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              })),
    );
  }
}
