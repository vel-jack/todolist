import 'package:flutter/material.dart';

class TodoLogo extends StatelessWidget {
  const TodoLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 50,
        ),
        Icon(
          Icons.check_circle,
          size: 60,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Todo list',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
