import 'package:flutter/material.dart';
import 'package:todolist/widgets/button_add_todo.dart';

import '../../providers/todo_provider.dart';
import '../todo_pages/todo_pages.dart';

export 'home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage( {super.key} );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List')
      ),
      body: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ListAllTodo())
                            );
                          },
                          child: const Text('View All To-Do')
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ListTodayTodo())
                            );
                          },
                          child: const Text('View Today To-Do')
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ListUpcomingTodo())
                            );
                          },
                          child: const Text('View Upcoming To-Do')
                      )
                    ],
                  )
              )
          ),
        ]
      )
    );
  }
}