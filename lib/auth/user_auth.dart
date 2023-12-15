import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/data/firestore.dart';

abstract class UserAuthentication {
  Future<void> SignUp(String email, String password, String confPassword);
  Future<void> Login(String email, String password);
}

class UserAuthenticationRemote extends UserAuthentication {
  @override
  Future<void> Login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> SignUp(
      String email, String password, String confPassword) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: email,
          password: password,
        )
        .then((value) => FireStoreDatabase().createUser(email));
  }
}
