import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<String> SignUp(
      {required String email,
      required String password,
      required String cPassword,
      required String bio,
      required Uint8List file,
      required String name}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          cPassword.isNotEmpty &&
          bio.isNotEmpty &&
          name.isNotEmpty &&
          password == cPassword &&
          file.isNotEmpty) {
        UserCredential cred = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);
        await firestore.collection('users').doc(cred.user!.uid).set({
          'username': name,
          'email': email,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': downloadUrl,
        });
      }
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
