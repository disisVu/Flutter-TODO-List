import 'package:flutter/material.dart';
import '../models/todo.dart';

class WidgetToDo extends StatelessWidget {
  final ToDo toDo;

  const WidgetToDo({
    Key? key,
    required this.toDo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 80,
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.1), // Set the shadow color
            spreadRadius: 2, // Set the spread radius
            blurRadius: 4, // Set the blur radius
            offset: const Offset(0, 0), // Set the shadow offset
          ),
        ],
      ),
      child: Text(toDo.title)
    );
  }
}