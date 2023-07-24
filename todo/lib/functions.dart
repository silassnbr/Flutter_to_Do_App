import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:todo/models/tasks.dart';
import 'package:todo/repo.dart';

var sayi;
var toplam;
List<int> bekleyenler = [];
List<int> bekleyenlerSonUc = [];
List<int> bekleyenlerSonUcTitle = [];
Future<Tasks> getAllTasks() async {
  bekleyenler.clear();
  final url = 'http://api.nstack.in/v1/todos?page=1&limit=19';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    print(response.statusCode.toString());
    final json = Tasks.fromJson(jsonDecode(response.body));
    Repo.tasks = Tasks.fromJson(jsonDecode(response.body));
    print(Repo.tasks.items!.length.toString());
    toplam = json.items!.length;
    sayi = 0;
    for (var i = 0; i < json.items!.length; i++) {
      if (json.items![i].isCompleted == true) {
        sayi = sayi + 1;
      } else {
        bekleyenler.add(i);
      }
    }
    return Repo.tasks;
  } else {
    throw (Exception(e));
  }
}

List<String> bekleyenlerTitle = [];
List<String> bekleyenlerDes = [];
List<String> bekleyenlerId = [];
Future<Tasks> getBekleyenler() async {
  bekleyenlerTitle.clear();
  bekleyenlerDes.clear();
  bekleyenlerId.clear();
  final url = 'http://api.nstack.in/v1/todos?page=1&limit=19';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final json = Tasks.fromJson(jsonDecode(response.body));

    for (var i = 0; i < json.items!.length; i++) {
      if (json.items![i].isCompleted == false) {
        bekleyenlerTitle.add(json.items![i].title.toString());
        bekleyenlerDes.add(json.items![i].description.toString());
        bekleyenlerId.add(json.items![i].sId.toString());
        print(bekleyenlerTitle);
      }
    }
    return Repo.tasks;
  } else {
    throw (Exception(e));
  }
}

List<String> tamamlananTitle = [];
List<String> tamamlananDes = [];
List<String> tamamlananId = [];
Future<Tasks> getTamamlanan() async {
  tamamlananTitle.clear();
  tamamlananDes.clear();
  tamamlananId.clear();
  final url = 'http://api.nstack.in/v1/todos?page=1&limit=19';
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    final json = Tasks.fromJson(jsonDecode(response.body));

    for (var i = 0; i < json.items!.length; i++) {
      if (json.items![i].isCompleted == true) {
        tamamlananTitle.add(json.items![i].title.toString());
        tamamlananDes.add(json.items![i].description.toString());
        tamamlananId.add(json.items![i].sId.toString());
      }
    }
    return Repo.tasks;
  } else {
    throw (Exception(e));
  }
}
