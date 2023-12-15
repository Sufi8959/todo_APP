import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:uuid/uuid.dart';

class FireStoreDatabase {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> createUser(String email) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({'id': auth.currentUser!.uid, 'email': email});
      return true;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }

  Future<bool> AddNewTask(String title, String subtitle, int image) async {
    try {
      var uuid = Uuid().v4();
      DateTime time = DateTime.now();
      await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set({
        'id': uuid,
        'title': title,
        'subtitle': subtitle,
        'isDone': false,
        'image': image,
        'time': "${time.hour}:${time.minute}",
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<List<UserTask>> getNotes(AsyncSnapshot snapshot) async {
    final snapshot = await firebaseFirestore.collection('users').get();
    final userData =
        snapshot.docs.map((e) => UserTask.fromSnapShot(e)).toList();
    return userData;
  }

  Stream<QuerySnapshot> stream() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('tasks')
        .snapshots();
  }

  Future<bool> isDone(String uuid, bool isDone) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('tasks')
          .doc(uuid)
          .update({'isDone': isDone});
      return true;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }

  Future<bool> updateTask(
      String uuid, String title, String subtitle, int image) async {
    try {
      DateTime time = new DateTime.now();
      await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('tasks')
          .doc(uuid)
          .update({
        'title': title,
        'subtitle': subtitle,
        'image': image,
        'time': "${time.hour}${time.minute}"
      });
      return true;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }

  Future<bool> deleteTask(String uuid) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('tasks')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      print(e.toString());
      return true;
    }
  }
}
