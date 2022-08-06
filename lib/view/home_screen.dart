import 'package:flutter/material.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            time = TimeOfDay.now().format(context);
          });
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Add Todo'),
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
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Add Todo'),
                      )
                    ],
                  )).then((value) {
            textController.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
