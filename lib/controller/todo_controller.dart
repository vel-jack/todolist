import 'package:get/get.dart';
import 'package:todolist/model/todo.dart';

class TodoController extends GetxController {
  final Rx<List<Todo>> _todos = Rx<List<Todo>>([]);
  List<Todo> get todos => _todos.value;

  addTodo(Todo todo) {
    _todos.value.add(todo);
  }

  updateTodo(String id) {}

  DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
