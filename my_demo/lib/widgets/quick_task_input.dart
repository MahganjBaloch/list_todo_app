import 'package:flutter/material.dart';

class QuickTaskInput extends StatefulWidget {
  final Function(String, String, String) onSubmit;

  const QuickTaskInput({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _QuickTaskInputState createState() => _QuickTaskInputState();
}

class _QuickTaskInputState extends State<QuickTaskInput> {
  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 206, 72, 230), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _taskController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'ENTER QUICK TASK HERE',
              hintText: 'ENTER ',
              labelStyle: TextStyle(color: Colors.white),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                widget.onSubmit(value, '', '');
                _taskController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
