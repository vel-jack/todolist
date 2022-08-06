class Todo {
  final String id;
  final String todo;
  final bool isDone;
  final String time;
  final String date;

  Todo({
    required this.id,
    required this.todo,
    required this.isDone,
    required this.time,
    required this.date,
  });

  factory Todo.fromMap(Map<String, dynamic> data) => Todo(
        id: data['id'],
        todo: data['todo'],
        isDone: data['isDone'],
        time: data['time'],
        date: data['date'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'todo': todo,
        'isDone': isDone,
        'time': time,
        'date': date,
      };
}
