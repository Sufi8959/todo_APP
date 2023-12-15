import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/data/firestore.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/screens/new_task.dart';
import 'package:todo_app/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool show = false;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade400,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            auth.signOut().then(
                  (value) => Navigator.push(
                    (context),
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  ),
                );
          },
          icon: Icon(Icons.logout_outlined),
        ),
        title: Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.small(
        foregroundColor: Colors.white,
        backgroundColor: Colors.greenAccent.shade400,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => NewTaskScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() {
              show = true;
            });
          }
          if (notification.direction == ScrollDirection.reverse) {
            setState(() {
              show = false;
              ;
            });
          }
          return true;
        },
        child: StreamBuilder<QuerySnapshot>(
          stream: FireStoreDatabase().stream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final taskList = FireStoreDatabase().getNotes(snapshot);
              return ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  //  final task = taskList[index];
                  return TaskWidget(taskList as UserTask);
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error:${snapshot.error}');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
