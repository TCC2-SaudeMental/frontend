import 'package:flutter/material.dart';

import 'components/body.dart';

class AnswerScreen extends StatelessWidget {
  static String routeName = "/answer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta'),
      ),
      body: Body(),
    );
  }
}
