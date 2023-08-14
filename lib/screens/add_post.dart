import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/firestore_methods.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _image;
  bool _isloading = false;
  void upload(ImageSource sourcer) async {
    Uint8List img = await PickImage(sourcer);
    Navigator.pop(context);
    setState(() {
      _image = img;
    });
  }

  TextEditingController description = TextEditingController();
  void _ImageSource(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Select Image Source'),
            children: [
              SimpleDialogOption(
                child: const Text('Take a photo'),
                onPressed: () {
                  upload(ImageSource.camera);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SimpleDialogOption(
                child: const Text('Choose From Gallery'),
                onPressed: () {
                  upload(ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  void PostImage(String uid, String username, String profileImage) async {
    setState(() {
      _isloading = true;
    });
    try {
      String res = await FireStoremethods()
          .uploadPost(description.text, _image!, uid, username, profileImage);
      if (res == "success") {
        setState(() {
          _isloading = false;
        });
        ShowSnackBar("Posted!", context);
        setState(() {
          _image = null;
        });
      } else {
        setState(() {
          _isloading = false;
        });
        ShowSnackBar(res, context);
      }
    } catch (e) {
      setState(() {
        _isloading = false;
      });
      ShowSnackBar(e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          _image = null;
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Post'),
          actions: [
            TextButton(
                onPressed: () {
                  PostImage(FirebaseAuth.instance.currentUser!.uid,
                      user.username, user.photoUrl);
                },
                child: Text(
                  user.username,
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ))
          ],
        ),
        body: _image == null
            ? Center(
                child: IconButton(
                    onPressed: () {
                      _ImageSource(context);
                    },
                    icon: const Icon(Icons.upload_file)),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    _isloading
                        ? const LinearProgressIndicator()
                        : Container(
                            padding: const EdgeInsets.only(top: 0.0),
                          ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                        SizedBox(
                          // height: 50,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextField(
                            controller: description,
                            maxLines: 8,
                            decoration: const InputDecoration(
                                hintText: "Write a Caption..",
                                border: InputBorder.none),
                          ),
                        ),
                        Stack(
                          children: [
                            Positioned(
                                bottom: -5,
                                right: 5,
                                child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 10,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      _ImageSource(context);
                                    })),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: AspectRatio(
                                aspectRatio: 480 / 480,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(_image!),
                                          fit: BoxFit.fill,
                                          alignment:
                                              FractionalOffset.topCenter)),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
