import 'package:flutter/material.dart';
import 'package:take_home/screens/profile/widgets/logout_card.dart';
import 'package:take_home/screens/profile/widgets/profile_os_detail.dart';

enum ProfileOSActions {
  profile,
  joinBookCommuninty,
  qrCode,
  aboutUs,
  logout,
}

class ProfileOSTile extends StatelessWidget {
  IconData icon;
  String name;
  ProfileOSActions osAction;
  ProfileOSTile({
    Key? key,
    required this.icon,
    required this.name,
    required this.osAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        osAction == ProfileOSActions.logout
            ? {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return const LogoutCard();
                    })
              }
            : {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileOSDetail(
                              pagename: name,
                            )))
              };
      },
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 30),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(
            endIndent: 20,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: must_be_immutable
