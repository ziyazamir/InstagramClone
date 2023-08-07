import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import 'package:instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/responsive/web_screen_layout.dart';
import 'package:instagram_clone/screens/emailAuth/register.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/utils.dart';
import 'package:instagram_clone/widgets/TextFieldInput.dart';

// ignore: must_be_immutable
class EmailLogin extends StatefulWidget {
  const EmailLogin({super.key});

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _isloading = false;

  // TextEditingController phoneController = TextEditingController();
  void Login(context) async {
    setState(() {
      _isloading = true;
    });
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String res =
        await AuthMethods().LoginWithEmailandPass(email: email, pass: password);
    if (res != "success") {
      ShowSnackBar(res, context);
      setState(() {
        _isloading = false;
      });
    } else {
      ShowSnackBar("login succesfully", context);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout()))));
      setState(() {
        _isloading = false;
      });
    }
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
            child: Column(
                // shrinkWrap: true,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  SvgPicture.asset(
                    'assets/images/ic_instagram.svg',
                    height: 64,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 64),
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
                  const SizedBox(height: 50),
                  InkWell(
                      onTap: () {
                        Login(context);
                      },
                      child: Container(
                          width: double.infinity,
                          // height: 50,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          alignment: Alignment.center,
                          // color: primaryColor,
                          child: _isloading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Roboto'),
                                ))),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Column(
                      children: [
                        const Text("Dont have an account"),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EmailRegister()));
                            },
                            child: const Text("Create account"))
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
