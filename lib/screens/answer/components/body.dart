import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;

import '../../../components/default_button.dart';

import '../../../services/flash_message.dart';
import '../../../services/storage.dart';

final questionTextStyle = TextStyle(
  fontSize: getProportionateScreenWidth(18),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

class Body extends StatelessWidget {
  void changeScore(context, int score) async {
    String? token = await secureStorage.read(key: 'jwt');
    if (token == null) {
      return;
    }

    final response = await http.put(
      Uri.parse('https://tcc2-api.herokuapp.com/user/score'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}',
      },
      body: jsonEncode(<String, int>{
        'amount': score,
      }),
    );

    final body = jsonDecode(response.body);

    if (response.statusCode != 200) {
      showErrorFlash("Erro ao submeter resposta", context);
    } else {
      showSuccessFlash(body['data'], context);
    }
    Navigator.popUntil(context, ModalRoute.withName(HomeScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                Text("De maneira geral, estou satisfeito(a) com minha vida estes últimos dias.",
                    style: questionTextStyle),
                SizedBox(height: SizeConfig.screenHeight * 0.06),
                DefaultButton(
                    text: "Discordo Totalmente",
                    press: () {
                      changeScore(context, -2);
                    }),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                DefaultButton(
                    text: "Discordo Parcialmente",
                    press: () {
                      changeScore(context, -1);
                    }),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                DefaultButton(
                    text: "Concordo Parcialmente",
                    press: () {
                      changeScore(context, 1);
                    }),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                DefaultButton(
                    text: "Concordo Totalmente",
                    press: () {
                      changeScore(context, 2);
                    }),
                SizedBox(height: getProportionateScreenHeight(30)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
