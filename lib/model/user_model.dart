import 'package:cloud_firestore/cloud_firestore.dart';

class UserTask {
  String id;
  String subtitle;
  String title;
  String time;
  int image;
  bool isDone;
  UserTask(
      this.id, this.subtitle, this.time, this.image, this.title, this.isDone);

  toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'image': image,
      'isDone': isDone,
      'time': time,
    };
  }

  factory UserTask.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserTask(
      document.id,
      data['title'],
      data['subtitle'],
      data['image'],
      data['isDone'],
      data['time'],
    );
  }
}
