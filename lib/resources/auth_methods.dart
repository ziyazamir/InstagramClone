import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<String> SignUp(
      {required String email,
      required String password,
      required String cPassword,
      required String bio,
      // required Uint8List file = null,
      required String name}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          cPassword.isNotEmpty &&
          bio.isNotEmpty &&
          name.isNotEmpty &&
          password == cPassword) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);

        await firestore.collection('users').doc(cred.user!.uid).set({
          'username': name,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
        });
      }
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
