import 'package:flutter/material.dart';
import 'package:todolist/utils/constants.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            color: kPrimayColor,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${authController.user!.email}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.delete),
            title: Text('Delete Completed Todos'),
          ),
          const Spacer(),
          ListTile(
            onTap: () {
              authController.signOut();
            },
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
