import 'package:flutter/material.dart';

import 'profile_menu.dart';
import '../../../services/storage.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

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
            press: () => {},
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
