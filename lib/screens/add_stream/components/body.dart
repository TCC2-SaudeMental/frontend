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
  void _startTimer(){
    Timer.periodic(Duration(seconds:1), (timer) {
      setState(() {
        if (secondStart > 58) {
          secondTotal += secondStart + 1;
          secondStart = -1;
          if (minuteStart > 58){
            minuteStart = -1;
            hourStart++;
          }
          minuteStart++;
        };
        secondStart++;
      });
    });
  }
  bool _pressButton() {
    if(pressed){
      return false;
    }
    pressed = true;
    return true;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                MaterialButton(
                    onPressed: () async{
                      if(!pressed){
                        _startTimer();
                      }
                      else{
                        null;
                      }
                    },
                    child: Text(
                        'Iniciar Stream',
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                        ),
                    ),
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30) ),
                    color: Colors.deepOrange,
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
