import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/emailAuth/login.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});
  void Logout(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: ((context) => EmailLogin())));
  }

  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        child: Text("Mobile view"),
      ),
    );
  }
}
