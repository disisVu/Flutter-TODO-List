import 'package:flutter/foundation.dart';
import '../models/todo.dart';

class ToDoProvider extends ChangeNotifier {
  List<ToDo> _toDos = [];

  List<ToDo> get toDos => _toDos;

  void addToDo(String title, DateTime dateTime) {
    _toDos.add(ToDo(title: title, dateTime: dateTime, isCompleted: false));
    notifyListeners();
  }

  void toggleToDo(ToDo toDo) {
    toDo.isCompleted = !toDo.isCompleted;
    notifyListeners();
  }

  void removeToDo(ToDo toDo) {
    _toDos.remove(toDo);
    notifyListeners();
  }
}