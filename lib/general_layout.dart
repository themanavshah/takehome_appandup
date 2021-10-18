import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:take_home/constants/colors.dart';
import 'package:take_home/controllers/books_controller.dart';
import 'package:take_home/screens/favorite/favorite_screen.dart';
import 'package:take_home/screens/home/home_screen.dart';
import 'package:take_home/screens/profile/profile_screen.dart';

class GeneralLayout extends StatefulWidget {
  const GeneralLayout({Key? key}) : super(key: key);

  @override
  _GeneralLayoutState createState() => _GeneralLayoutState();
}

class _GeneralLayoutState extends State<GeneralLayout> {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    bool initiated = false;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((data) {
      List books = data.data()?["favorites"] ?? [];
      if (!initiated) {
        for (var bookid in books) {
          bookIdList.add(bookid);
        }
        initiated = true;
      }
    });
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? WebGeneralLayout()
        : Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _pageIndex,
              onTap: onTabTapped,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey.withOpacity(0.8),
              elevation: 0,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Icon(Icons.home),
                  ),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Icon(Icons.favorite_rounded),
                  ),
                  label: "Liked",
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Icon(Icons.person),
                  ),
                  label: "Profile",
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [OurColors.yellow.withOpacity(0.7), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.0, 0.5],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: PageView(
                children: tabPages,
                onPageChanged: onPageChanged,
                controller: _pageController,
              ),
            ),
          );
  }
}

class WebGeneralLayout extends StatefulWidget {
  const WebGeneralLayout({Key? key}) : super(key: key);

  @override
  State<WebGeneralLayout> createState() => _WebGeneralLayoutState();
}

class _WebGeneralLayoutState extends State<WebGeneralLayout> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BookHook",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(FirebaseAuth.instance.currentUser!.email!
                  .split("@")[0]
                  .toString()),
              accountEmail: Text(FirebaseAuth.instance.currentUser!.email ??
                  "Email not found"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  FirebaseAuth.instance.currentUser!.email?[0] ?? "-",
                  style: TextStyle(
                    fontSize: 40.0,
                    color: OurColors.yellow,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageIndex = 0;
                      });
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.home),
                        SizedBox(width: 10),
                        Text(
                          "Home",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageIndex = 1;
                      });
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.favorite),
                        SizedBox(width: 10),
                        Text(
                          "Favorite",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageIndex = 2;
                      });
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.person),
                        SizedBox(width: 10),
                        Text(
                          "Profile",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _pageIndex == 0
          ? const HomeScreen()
          : _pageIndex == 1
              ? const FavoriteScreen()
              : const ProfileScreen(),
    );
  }
}
