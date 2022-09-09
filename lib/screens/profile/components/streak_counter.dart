import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import '../../../services/storage.dart';

class StreakCounter extends StatefulWidget {
  @override
  _StreakCounterState createState() => _StreakCounterState();
}

class _StreakCounterState extends State<StreakCounter> {
  String streak = '...';

  @override
  void initState() {
    super.initState();
    retrieveStreak();
  }

  Future<void> retrieveStreak() async {
    String? token = await secureStorage.read(key: 'jwt');
    if (token == null) {
      return;
    }

    EasyLoading.show(status: 'Carregando...');

    final response = await http.get(
      Uri.parse('https://tcc2-api.herokuapp.com/auth/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      },
    );

    final body = jsonDecode(response.body);
    int? aux_streak = body['data']['user']['answer_streak'];
    String new_streak = aux_streak == null ? '0' : aux_streak.toString();
    setState(() {
      streak = new_streak;
    });
    EasyLoading.dismiss();
  }

  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Color(0xFFF5F6F9),
            shape: BoxShape.circle,
            border: Border.all(width: 4, color: Color(0xFFFF7643))),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            streak,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF7643),
                fontSize: 40),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 20),
        child: Text("Pontuação"),
      )
    ]);
  }
}
