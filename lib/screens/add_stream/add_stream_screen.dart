import 'package:flutter/material.dart';
import 'package:shop_app/components/coustom_bottom_nav_bar.dart';
import 'package:shop_app/enums.dart';

import 'components/body.dart';

class AddStreamScreen extends StatelessWidget {
  static String routeName = "/add_stream";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD STREAM"),
      ),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(
          selectedMenu: MenuState.add_stream),
    );
  }
}
