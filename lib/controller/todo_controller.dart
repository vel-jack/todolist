import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/utils/constants.dart';

class TodoController extends GetxController {
  static TodoController instance = Get.find();
  addTodo(String todoText, String time, int date) async {
    try {
      final ref = firestore
          .collection('users')
          .doc(authController.user!.uid)
          .collection('todos')
          .doc();
      final todo = Todo(
          id: ref.id, text: todoText, isDone: false, time: time, date: date);
      await ref.set(todo.toMap());
    } catch (e) {
      debugPrint('Something went wrong(Add): $e');
    }
  }

  updateTodo(String id, Todo todo) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user!.uid)
          .collection('todos')
          .doc(id)
          .update(todo.toMap());
    } catch (e) {
      debugPrint('Something went wrong(Update): $e');
    }
  }

  deleteTodo(String id) async {
    try {
      await firestore
          .collection('users')
          .doc(authController.user!.uid)
          .collection('todos')
          .doc(id)
          .delete();
    } catch (e) {
      debugPrint('Something went wrong(Delete): $e');
    }
  }

  deleteCompleted() {
    try {
      WriteBatch batch = firestore.batch();
      return firestore
          .collection('users')
          .doc(authController.user!.uid)
          .collection('todos')
          .where('isDone', isEqualTo: true)
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          batch.delete(document.reference);
        }
        return batch.commit();
      });
    } catch (e) {
      debugPrint('Something went wrong(Batch Delete): $e');
    }
  }
}
