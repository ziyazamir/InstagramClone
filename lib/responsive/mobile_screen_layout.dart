import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/emailAuth/login.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'package:instagram_clone/models/user.dart' as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  void Logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => const EmailLogin())));
  }

  String username = "ziya";
  @override
  void initState() {
    // TODO: implement initState
    // getUser();
  }

  // void getUser() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     username = (snap.data() as Map<String, dynamic>)['username'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
        actions: [
          IconButton(
              onPressed: () {
                Logout(context);
              },
              padding: const EdgeInsets.only(right: 30),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text(username),
      ),
    );
  }
}
