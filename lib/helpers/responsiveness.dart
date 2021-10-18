import 'package:flutter/material.dart';

class Responsivness {
  static const int smallSize = 640;
  static const int mediumSize = 1100;

  bool isSmall(BuildContext context) {
    if (MediaQuery.of(context).size.width <= smallSize) {
      return true;
    }
    return false;
  }

  bool isMedium(BuildContext context) {
    if (MediaQuery.of(context).size.width <= mediumSize &&
        MediaQuery.of(context).size.width > 640) {
      return true;
    }
    return false;
  }

  bool isLarge(BuildContext context) {
    if (MediaQuery.of(context).size.width > mediumSize) {
      return true;
    }
    return false;
  }
}
