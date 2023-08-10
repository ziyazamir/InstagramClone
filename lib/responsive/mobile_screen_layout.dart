import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/emailAuth/login.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/globalVariables.dart';

// import 'gl'
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
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    // getUser();
    pageController = PageController();
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
  late int _page = 0;
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onpageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onpageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: HomeScreenItems,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // selectedItemColor: Colors.amber,
        // elevation: 10,
        // selectedIconTheme: const IconThemeData(grade: 0),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  size: 30,
                  // weight: 10,
                  color: _page == 0 ? primaryColor : secondaryColor),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,
                  size: 30, color: _page == 1 ? primaryColor : secondaryColor),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle,
                  color: _page == 2 ? primaryColor : secondaryColor),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite,
                  color: _page == 3 ? primaryColor : secondaryColor),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _page == 4 ? primaryColor : secondaryColor),
              label: ""),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
