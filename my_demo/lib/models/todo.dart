class Todo {
  final String task;
  final String date;
  final String time;
  bool deleted;

  Todo({
    required this.task,
    required this.date,
    required this.time,
    this.deleted = false,
  });
}
