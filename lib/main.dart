import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/screens/splash_screen.dart';
import 'package:todo_app/screens/update_task.dart';
import 'firebase_options.dart';
import 'package:todo_app/constants/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorScheme,
        textTheme: ThemeData()
            .textTheme
            .copyWith(bodyMedium: TextStyle(fontSize: 12, color: Colors.black)),
      ),
      home: LoginScreen(),
    );
  }
}
