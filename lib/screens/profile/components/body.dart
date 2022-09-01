import 'package:flutter/material.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';

import 'profile_menu.dart';
import '../../../services/storage.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () {
              Navigator.pushNamed(context, CompleteProfileScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              await secureStorage.deleteAll();
              Navigator.popUntil(
                  context, ModalRoute.withName(SignInScreen.routeName));
            },
          ),
        ],
      ),
    );
  }
}
