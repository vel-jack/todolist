import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/utils/constants.dart';
import 'package:todolist/utils/helper.dart';
import 'package:todolist/view/end_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  String time = '';
  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      endDrawer: const EndDrawer(),
      body: Container(
        color: Colors.grey.shade100,
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firestore
                .collection('users')
                .doc(authController.user!.uid)
                .collection('todos')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final todoList =
                  snapshot.data!.docs.map((e) => Todo.fromMap(e)).toList();

              return GroupedListView(
                order: GroupedListOrder.DESC,
                elements: todoList,
                groupBy: (Todo todo) => todo.date,
                groupHeaderBuilder: (Todo todo) => Padding(
                  padding: const EdgeInsets.all(10.0).copyWith(left: 20),
                  child: Text(
                    getFormattedDate(todo.date).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                    ),
                  ),
                ),
                itemBuilder: (context, Todo todo) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () {
                        textController.text = todo.text;
                        time = todo.time;
                        showTodoInput(context, todo: todo);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              left: BorderSide(
                            color: getLabelColor(todo.date),
                            width: 10,
                          )),
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(4, 4),
                              blurRadius: 2.0,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: AnimatedOpacity(
                          opacity: todo.isDone ? 0.4 : 1.0,
                          duration: const Duration(milliseconds: 100),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Text(
                                  todo.text,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              )),
                              Text(
                                todo.time,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 5),
                              InkWell(
                                  onTap: () {
                                    todoController.updateTodo(todo.id,
                                        todo.copyWith(isDone: !todo.isDone));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(4)
                                        .copyWith(right: 14),
                                    child: Icon(
                                      todo.isDone
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      size: 28,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            time = TimeOfDay.now().format(context);
          });
          await showTodoInput(context).then((value) {
            textController.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  showTodoInput(BuildContext context, {Todo? todo}) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(todo == null ? 'Add Todo' : 'Update Todo'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  OutlinedButton(
                    onPressed: () async {
                      final newTime = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      if (newTime != null) {
                        setState(() {
                          time = newTime.format(context);
                        });
                      }
                    },
                    child: Text('Time : $time'),
                  ),
                ],
              ),
              actions: [
                if (todo != null)
                  TextButton.icon(
                      onPressed: () {
                        todoController.deleteTodo(todo.id);
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      label: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () {
                    if (textController.text.isEmpty) {
                      return;
                    }
                    if (todo != null) {
                      todoController.updateTodo(todo.id,
                          todo.copyWith(text: textController.text, time: time));
                    } else {
                      todoController.addTodo(textController.text, time,
                          getDateTimestamp(DateTime.now()));
                    }
                    Navigator.pop(context);
                  },
                  child: Text(todo == null ? 'Add Todo' : 'Update Todo'),
                )
              ],
            ));
  }
}
