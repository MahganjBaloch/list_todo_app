import 'package:flutter/material.dart';
import '../widgets/quick_task_input.dart';
import '../models/todo.dart';
import 'edit_screen.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];

  void addTodo(String task, String date, String time) {
    setState(() {
      todos.add(Todo(task: task, date: date, time: time));
    });
  }

  void updateTodo(int index, String task, String date, String time) {
    setState(() {
      todos[index] = Todo(task: task, date: date, time: time);
    });
  }

  void deleteTodo(int index) {
    setState(() {
      todos[index].deleted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL TO DO'),
        backgroundColor: Color.fromARGB(255, 87, 105, 238),
      ),
      backgroundColor: const Color.fromARGB(255, 115, 5, 134),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: todos.map((todo) {
                    return todo.deleted
                        ? SizedBox.shrink()
                        : Container(
                            color: Color.fromARGB(255, 206, 72, 230),
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            child: ListTile(
                              title: Text(
                                todo.task,
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 236, 230, 230),
                                  decoration: todo.deleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Date: ',
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 246, 243, 243)),
                                      ),
                                      Text(
                                        todo.date,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 242, 239, 239)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Time: ',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 248, 247, 247)),
                                      ),
                                      Text(
                                        todo.time,
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 243, 242, 242)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditTodoScreen(
                                      todo: todo,
                                      onUpdate: (task, date, time) {
                                        updateTodo(todos.indexOf(todo), task,
                                            date, time);
                                      },
                                    ),
                                  ),
                                );
                              },
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  deleteTodo(todos.indexOf(todo));
                                },
                              ),
                            ),
                          );
                  }).toList(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                QuickTaskInput(onSubmit: addTodo),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTodoScreen(
                onUpdate: addTodo,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        foregroundColor: Colors.blue,
      ),
    );
  }
}
