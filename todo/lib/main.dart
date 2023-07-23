import 'package:flutter/material.dart';
import 'package:todo/addTask.dart';
import 'package:todo/allTasks.dart';
import 'package:todo/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(
        title: 'To Do App',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _buildPage = <Widget>[
    HomePage(key: UniqueKey()),
    AddTask(),
    AllTasksPage()
  ];

  void tap(int index) {
    if (index == 0) {
      // Ana sayfaya geçiş yapıldığında key'i güncelle
      setState(() {
        _buildPage[0] = HomePage(key: UniqueKey());
      });
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.green[900]),
        ),
        shadowColor: Colors.green[900],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _buildPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home Page',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_task_sharp),
            label: 'Add Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'All Tasks',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[400],
        onTap: tap,
      ),
    );
  }
}
