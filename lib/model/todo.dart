import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String text;
  final bool isDone;
  final String time;
  final int date;

  Todo({
    required this.id,
    required this.text,
    required this.isDone,
    required this.time,
    required this.date,
  });

  Todo copyWith({String? text, bool? isDone, String? time, int? date}) => Todo(
        id: id,
        text: text ?? this.text,
        isDone: isDone ?? this.isDone,
        time: time ?? this.time,
        date: date ?? this.date,
      );

  factory Todo.fromMap(
          DocumentSnapshot<Map<String, dynamic>> documentSnapshot) =>
      Todo(
        id: documentSnapshot.id,
        text: documentSnapshot.data()!['text'],
        isDone: documentSnapshot.data()!['isDone'],
        time: documentSnapshot.data()!['time'],
        date: documentSnapshot.data()!['date'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'text': text,
        'isDone': isDone,
        'time': time,
        'date': date,
      };
  @override
  String toString() {
    return '$text - $date - $time - $isDone';
  }
}
