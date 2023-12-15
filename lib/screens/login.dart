import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/user_auth.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/signup.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/image_widget.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    super.initState();
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ImageWidget(),
            SizedBox(
              height: 50,
            ),
            Form(
              key: _formKey,
              child: TextFieldWidget(
                focusNode1: _focusNode1,
                emailController: emailController,
                focusNode2: _focusNode2,
                passwordController: passwordController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            LoginButton(
              isLoading: isLoading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  try {
                    setState(() {
                      isLoading = true;
                    });
                    UserAuthenticationRemote()
                        .Login(emailController.text, passwordController.text)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      Utils().toastMessage('Logged in Successfully');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    });
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    if (e.code == 'user-not-found') {
                      Utils().toastMessage('user does not exist');
                    } else if (e.code == 'wrong-email' ||
                        e.code == 'wrong-password' ||
                        e.code == 'wrong email' && e.code == 'wrong password') {
                      Utils().toastMessage('invalid email or password');
                    }
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required FocusNode focusNode1,
    required FocusNode focusNode2,
    required this.emailController,
    required this.passwordController,
  });

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TextFormField(
              focusNode: _focusNode1,
              controller: emailController,
              style: TextStyle(fontSize: 14, color: Colors.black87),
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.email, color: Colors.greenAccent.shade400),
                hintText: "Email",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      BorderSide(width: 1, color: Colors.greenAccent.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.greenAccent.shade400, width: 1.5),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'email is empty';
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TextFormField(
              focusNode: _focusNode2,
              controller: passwordController,
              style: TextStyle(fontSize: 14, color: Colors.black87),
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.lock, color: Colors.greenAccent.shade400),
                hintText: "Password",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide:
                      BorderSide(width: 1, color: Colors.greenAccent.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.greenAccent.shade400, width: 1.5),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'password is empty';
                }
                return null;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Dont't have an account? ",
                  style: ThemeData().textTheme.bodyLarge),
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                ),
                child: Text(
                  'SignUp',
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  LoginButton({super.key, required this.onTap, this.isLoading = false});
  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.greenAccent.shade400,
            borderRadius: BorderRadius.circular(6),
          ),
          width: double.infinity,
          height: 35,
          child: isLoading
              ? Padding(
                  padding: EdgeInsets.all(4),
                  child: const CircularProgressIndicator(strokeWidth: 5.0),
                )
              : Text('Login', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
