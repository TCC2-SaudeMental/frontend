import 'package:flutter/material.dart';
import 'dart:async';

import '../../../size_config.dart';
import 'package:flutter/material.dart';

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
