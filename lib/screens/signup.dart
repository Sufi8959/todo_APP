import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/user_auth.dart';
import 'package:todo_app/data/firestore.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/image_widget.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();
final confPasswordController = TextEditingController();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

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
                focusNode3: _focusNode3,
                confPasswordController: confPasswordController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SignUpButtom(
              isLoading: isLoading,
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });
                  try {
                    UserAuthenticationRemote()
                        .SignUp(emailController.text, passwordController.text,
                            confPasswordController.text)
                        .then((value) {
                      setState(() {
                        isLoading = false;
                      });
                      Utils().toastMessage('Account created Successfully');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                      //  FireStoreDatabase().createUser(emailController.text);
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        isLoading = false;
                      });
                    });
                  } on FirebaseAuthException catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    if (e.code == 'weak-password') {
                      Utils().toastMessage('please enter a strong password');
                    } else if (e.code == 'account-already-in-use') {
                      Utils().toastMessage('user already exist');
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
  TextFieldWidget(
      {super.key,
      required FocusNode focusNode1,
      required FocusNode focusNode2,
      required FocusNode focusNode3,
      required this.emailController,
      required this.passwordController,
      required this.confPasswordController});

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confPasswordController;

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
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: TextFormField(
              focusNode: _focusNode3,
              controller: confPasswordController,
              style: TextStyle(fontSize: 14, color: Colors.black87),
              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.lock, color: Colors.greenAccent.shade400),
                hintText: "Confirm Password",
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
                if (value!.isEmpty ||
                    passwordController.text != confPasswordController.text) {
                  return 'Password do not match';
                }
                return null;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Already have an account? ", style: TextStyle(fontSize: 12)),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  'Login',
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

class SignUpButtom extends StatelessWidget {
  SignUpButtom({super.key, required this.onTap, this.isLoading = false});
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
                  child: const CircularProgressIndicator(strokeWidth: 5.0))
              : Text('SignUp', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
