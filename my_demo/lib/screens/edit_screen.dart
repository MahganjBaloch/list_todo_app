import 'package:flutter/material.dart';
import '../models/todo.dart';

class EditTodoScreen extends StatefulWidget {
  final Todo? todo; // Change Todo to be nullable to handle adding todos
  final Function(String, String, String) onUpdate;

  const EditTodoScreen({Key? key, this.todo, required this.onUpdate})
      : super(key: key);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  TextEditingController _taskController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _taskController.text = widget.todo!.task;
      _dateController.text = widget.todo!.date;
      _timeController.text = widget.todo!.time;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add Todo' : 'Update Todo'),
        backgroundColor: Color.fromARGB(255, 87, 105, 238),
      ),
      backgroundColor: const Color.fromARGB(255, 115, 5, 134),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _taskController,
                style: TextStyle(color: Color.fromARGB(255, 225, 223, 229)),
                decoration: InputDecoration(
                  labelText: 'What is to be done ',
                  hintText: 'Enter task name',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 221, 228, 234)),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _dateController,
                style: TextStyle(color: Color.fromARGB(255, 238, 239, 240)),
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  hintText: 'Set task date',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 247, 243, 245)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Icon(Icons.calendar_today, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _timeController,
                style: TextStyle(color: Color.fromARGB(255, 237, 237, 239)),
                decoration: InputDecoration(
                  labelText: 'Task Time',
                  hintText: 'Set task time',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 244, 242, 243)),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Icon(Icons.access_time, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final task = _taskController.text;
                  final date = _dateController.text;
                  final time = _timeController.text;
                  if (task.isNotEmpty && date.isNotEmpty && time.isNotEmpty) {
                    widget.onUpdate(task, date, time);
                    Navigator.pop(context);
                  } else {
                    // Show error message or handle empty fields
                  }
                },
                child: Text(widget.todo == null ? 'Add Todo' : 'Update Todo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF6200EE), // Header background color
              onPrimary: Colors.white, // Text on header background color
              surface: const Color.fromARGB(255, 115, 5, 134), // Background color
              onSurface: const Color.fromARGB(255, 225, 223, 229), // Text on background color
            ),
            dialogBackgroundColor: const Color.fromARGB(255, 115, 5, 134), // Calendar background color
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      final formattedDate = '${pickedDate.month}/${pickedDate.day}/${pickedDate.year}';
      setState(() {
        _dateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }
}
