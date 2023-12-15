import 'package:flutter/material.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/screens/signup.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isUserExist = true;
  void forwardTo() {
    setState(() {
      isUserExist = !isUserExist;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isUserExist) {
      return LoginScreen();
    } else {
      return SignUpScreen();
    }
  }
}
