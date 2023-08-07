import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

PickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
  print('no image selected');
}

ShowSnackBar(String data, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(data),
    elevation: 10,
    backgroundColor: Colors.blue,
  ));
}
