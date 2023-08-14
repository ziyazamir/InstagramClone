import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String> uploadImageToStorage(
      String childname, Uint8List file, bool isPost) async {
    Reference ref = storage.ref().child(childname);
    if (isPost) {
      String uid = const Uuid().v1();
      ref = ref.child(uid);
    } else {
      ref = ref.child(auth.currentUser!.uid);
    }
    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
