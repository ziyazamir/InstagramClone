import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/TextFieldInput.dart';

class EmailRegister extends StatefulWidget {
  const EmailRegister({super.key});

  @override
  State<EmailRegister> createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController cpasswordController = TextEditingController();

  TextEditingController usernamController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  Uint8List? image;
  void Register(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    String cpassword = cpasswordController.text;
    if (password == null) {
      log("please eneter all the fields");
    } else if (password != cpassword) {
      log("password doesnt matched");
    } else {
      try {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        log("user created");
        Navigator.pop(context);
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }

      // log();s
    }
  }

  SelectImage() async {
    Uint8List img = await PickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Login"),
      // ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/images/ic_instagram.svg',
                height: 64,
                color: primaryColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(image!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ437yIliz8bD_CfEsagFeT2SAkaCHZOvNgQ&usqp=CAU'),
                        ),
                  Positioned(
                      bottom: -10,
                      right: -10,
                      child: IconButton(
                          onPressed: () {
                            SelectImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 30,
                          )))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFiledInput(
                  controller: usernamController,
                  label: 'Enter username',
                  InputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              TextFiledInput(
                  controller: emailController,
                  label: 'Enter Email',
                  InputType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              TextFiledInput(
                  controller: passwordController,
                  label: 'Enter Password',
                  isPass: true,
                  InputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              TextFiledInput(
                  controller: cpasswordController,
                  label: 'Confirm Password',
                  isPass: true,
                  InputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              TextFiledInput(
                  controller: bioController,
                  label: 'bio',
                  InputType: TextInputType.text),

              // TextField(
              //   controller: passwordController,
              //   obscureText: true,
              //   decoration: const InputDecoration(labelText: "Enter Password"),
              // ),
              // TextField(
              //   controller: cpasswordController,
              //   obscureText: true,
              //   decoration: const InputDecoration(labelText: "Confirm Password"),
              // ),
              const SizedBox(height: 30),
              InkWell(
                  onTap: () async {
                    String res = await AuthMethods().SignUp(
                      email: emailController.text,
                      password: passwordController.text,
                      cPassword: cpasswordController.text,
                      bio: bioController.text,
                      file: image!,
                      name: usernamController.text,
                    );
                    print(res);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                      )))
            ]),
          ),
        ),
      ),
    );
  }
}
