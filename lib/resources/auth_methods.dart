import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentuser = _auth.currentUser!;

    DocumentSnapshot snap =
        await firestore.collection("users").doc(currentuser.uid).get();
    return model.User.fromSnap(snap);
  }

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
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String downloadUrl = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);

        model.User user = model.User(
            username: name,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: downloadUrl);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      }
      res = "success";
    } on FirebaseAuthException catch (e) {
      res = e.code.toString();
    }
    return res;
  }

  Future<String> LoginWithEmailandPass(
      {required String email, required String pass}) async {
    String res = "Something went wrong";
    try {
      UserCredential cred =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      res = "success";
    } on FirebaseAuthException catch (err) {
      res = err.code.toString();
    }
    return res;
  }
}
