import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:take_home/screens/profile/widgets/logout_card.dart';
import 'package:take_home/screens/profile/widgets/profile_os_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  String nameExractor() {
    var email = FirebaseAuth.instance.currentUser!.email.toString();
    var name = email.split("@")[0];
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0, left: 40, right: 40),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey.withOpacity(0.6),
                  child: Icon(
                    Icons.person,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameExractor(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            ProfileOSTile(
              icon: CupertinoIcons.person_2_fill,
              name: "Profile",
              osAction: ProfileOSActions.profile,
            ),
            ProfileOSTile(
              icon: CupertinoIcons.book_circle_fill,
              name: "Join our book community",
              osAction: ProfileOSActions.joinBookCommuninty,
            ),
            ProfileOSTile(
              icon: CupertinoIcons.qrcode,
              name: "QR code",
              osAction: ProfileOSActions.qrCode,
            ),
            ProfileOSTile(
              icon: CupertinoIcons.building_2_fill,
              name: "About us",
              osAction: ProfileOSActions.aboutUs,
            ),
            ProfileOSTile(
              icon: Icons.logout_rounded,
              name: "Log out",
              osAction: ProfileOSActions.logout,
            ),
          ],
        ),
      ),
    );
  }
}
