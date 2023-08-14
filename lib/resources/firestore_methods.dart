import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoremethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String desc, Uint8List file, String uid,
      String username, String profileImage) async {
    String res = "Something went wrong";
    try {
      String PhotoUrl =
          await StorageMethods().uploadImageToStorage('Posts', file, true);
      String PostId = const Uuid().v1();
      // firestore.doc("")
      Post post = Post(
          description: desc,
          uid: uid,
          username: username,
          likes: [],
          postId: PostId,
          datePublished: DateTime.now(),
          postUrl: PhotoUrl,
          profImage: profileImage);
      firestore.collection("posts").doc(PostId).set(post.toJson());
      return "success";
    } catch (e) {
      res = e.toString();
      return res;
    }
  }
}
