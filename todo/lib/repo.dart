import 'package:todo/models/tasks.dart';

class Repo {
  static Tasks tasks = Tasks();
  static final Repo _instance = Repo._internal();

  factory Repo() {
    return _instance;
  }

  Repo._internal();
}
