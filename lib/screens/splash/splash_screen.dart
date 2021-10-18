import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:take_home/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          CupertinoIcons.book_solid,
          color: OurColors.yellow,
          size: 100,
        ),
      ),
    );
  }
}
