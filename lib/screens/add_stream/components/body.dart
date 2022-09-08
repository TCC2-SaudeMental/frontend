import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import '../../../size_config.dart';
import '../../../services/flash_message.dart';
import '../../../services/storage.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int hourStart = 0;
  int minuteStart = 0;
  int secondStart = 0;
  int secondTotal = 0;
  bool pressed = false;
  bool paused = false;
  late Timer timer;

  void _startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (secondStart > 58) {
          secondTotal += secondStart + 1;
          secondStart = -1;
          if (minuteStart > 58) {
            minuteStart = -1;
            hourStart++;
          }
          minuteStart++;
        }
        ;
        secondStart++;
      });
    });
  }

  void _pressButton() {
    if (!pressed) {
      setState(() {
        pressed = true;
      });
      _startTimer();
    }
  }

  void _pauseButton() {
    if (!paused) {
      timer.cancel();
      setState(() {
        paused = true;
      });
    } else {
      _startTimer();
      setState(() {
        paused = false;
      });
    }
  }

  String _getPauseText() {
    if (paused) {
      return 'Continuar';
    } else {
      return 'Pausar';
    }
  }

  void _submitTime() async {
    String? token = await secureStorage.read(key: 'jwt');
    if (token == null) {
      return;
    }
    final int duration = secondTotal + secondStart;

    final response = await http.post(
      Uri.parse('https://tcc2-api.herokuapp.com/stream'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}',
      },
      body: jsonEncode(<String, int>{
        'duration': duration,
      }),
    );

    if (response.statusCode != 200) {
      showErrorFlash('Erro ao submeter Stream', context);
    } else {
      showSuccessFlash('Stream submetida com sucesso!', context);

      hourStart = 0;
      minuteStart = 0;
      secondStart = 0;
      secondTotal = 0;
      pressed = false;
      paused = false;

      Navigator.pushNamed(context, 'Answer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    hourStart.toString().padLeft(2, "0") + ":",
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    minuteStart.toString().padLeft(2, "0") + ":",
                    style: TextStyle(fontSize: 50),
                  ),
                  Text(
                    secondStart.toString().padLeft(2, "0"),
                    style: TextStyle(fontSize: 50),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!pressed)
                  MaterialButton(
                    onPressed: () {
                      _pressButton();
                    },
                    child: Text(
                      'Iniciar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Color(0xFFFF7643),
                    padding: EdgeInsets.only(
                        bottom: 20, top: 14, left: 20, right: 20),
                  ),
                if (pressed)
                  MaterialButton(
                    onPressed: () {
                      _pauseButton();
                    },
                    child: Text(
                      _getPauseText(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Color(0xFFF5F6F9),
                    padding: EdgeInsets.only(
                        bottom: 20, top: 14, left: 20, right: 20),
                  ),
                SizedBox(height: getProportionateScreenHeight(20)),
                if (pressed)
                  MaterialButton(
                    onPressed: () {
                      _submitTime();
                    },
                    child: Text(
                      'Encerrar',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: Color(0xFFFF7643),
                    padding: EdgeInsets.only(
                        bottom: 20, top: 14, left: 20, right: 20),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
//
// return SafeArea(
// child: SingleChildScrollView(
// child: Center(
// child: Column(
// children: [
// SizedBox(height: getProportionateScreenHeight(20)),
// Text(
// "Flutter é ruim dms",
// style: TextStyle(
// color: Colors.black,
// fontSize: getProportionateScreenWidth(28),
// fontWeight: FontWeight.bold,
// ),
// ),
// FloatingActionButton.extended(
// onPressed: () {
// // Add your onPressed code here!
// },
// label: const Text('Iniciar stream'),
// icon: const Icon(Icons.access_alarm),
// backgroundColor: Colors.green,
// ),
// ],
// ),
// ),
// ),
// );
