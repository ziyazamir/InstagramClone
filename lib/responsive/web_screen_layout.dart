import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import 'package:instagram_clone/models/user.dart' as model;

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("WEb View"),
      ),
      body: Center(
        child: Text(user.bio),
      ),
    );
  }
}
