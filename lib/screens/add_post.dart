import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _image;
  void upload() async {
    Uint8List img = await PickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void _ImageSource(BuildContext context) {}
  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Post'),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                user.username,
                style: const TextStyle(
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ))
        ],
      ),
      body: Center(
        child: IconButton(
            onPressed: () {
              _ImageSource(context);
            },
            icon: const Icon(Icons.upload_file)),
      ),
    );
  }
}
