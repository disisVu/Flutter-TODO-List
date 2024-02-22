import 'package:flutter/material.dart';
import 'package:todolist/main.dart';
import 'package:todolist/models/models.dart';
import 'package:todolist/providers/todo_provider.dart';
import 'package:todolist/widgets/button_add_todo.dart';
import 'package:todolist/widgets/widget_todo.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ListUpcomingTodo extends StatefulWidget {
  @override
  _ListUpcomingToDoState createState() => _ListUpcomingToDoState();
}

class _ListUpcomingToDoState extends State<ListUpcomingTodo> {
  List<ToDo> filteredToDos = [];

  DateTime? selectedDateTime;
  String searchQuery = '';

  TextEditingController dateTimeController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  bool dateTimeEnable(DateTime day) =>
      day.isAfter(DateTime.now().subtract(const Duration(days: 1)));

  Future<void> selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      selectableDayPredicate: dateTimeEnable,
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          updateTextField();
        });
      }
    }
  }

  // Update datetime input text-field
  void updateTextField() {
    dateTimeController.text = selectedDateTime != null
        ? '${selectedDateTime?.toLocal()}'
        : ''; // Format the date-time as per your requirement
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ToDoProvider>(context);

    void filterToDos(String query) {
      setState(() {
        filteredToDos = provider.toDos
            .where((toDo) =>
        toDo.title.toLowerCase().contains(query.toLowerCase()) &&
            toDo.dateTime.isAfter(DateTime.now()))
            .toList();
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              'Upcoming To-Do',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            backgroundColor: Colors.transparent, // Make the AppBar transparent
            elevation: 0, // Remove AppBar's own shadow
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: searchController,
                onChanged: filterToDos,
                decoration: const InputDecoration(
                  labelText: 'Search by title',
                  prefixIcon: Icon(Icons.search),
                ),
              )
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredToDos.length,
              itemBuilder: (context, index) {
                var toDo = filteredToDos[index];
                return Container(
                  width: 200,
                  height: 60,
                  margin: const EdgeInsets.all(20),
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
                  child: Center(
                    child: ListTile(
                      title: Text(toDo.title),
                      subtitle: Text(
                          DateFormat('dd MMM yyyy, HH:mm').format(toDo.dateTime)
                      ),
                      leading: Checkbox(
                        value: toDo.isCompleted,
                        onChanged: (value) {
                          provider.toggleToDo(toDo);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          provider.removeToDo(toDo);
                          filterToDos(searchQuery);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}