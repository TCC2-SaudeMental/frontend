import 'package:flutter/material.dart';

import '../../../size_config.dart';
import 'stream_list.dart';
import 'home_header.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            Container(
              margin: EdgeInsets.only(top: getProportionateScreenWidth(10)),
            ),
            StreamList(),
          ],
        ),
      ),
    );
  }
}
