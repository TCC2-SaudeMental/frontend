import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../services/storage.dart';
import '../../../size_config.dart';
import '../../../store/days.dart';

class StreamList extends StatefulWidget {
  @override
  _StreamListState createState() => _StreamListState();
}

class _StreamListState extends State<StreamList> {
  List<dynamic> streams = [];
  final DaysState controller = Get.put(DaysState());

  @override
  void initState() {
    super.initState();
    ever(controller.rx_days, (value) => {retrieveStreams()});
    retrieveStreams();
  }

  Future<void> retrieveStreams() async {
    String? token = await secureStorage.read(key: 'jwt');
    if (token == null) {
      return;
    }
    EasyLoading.show(status: 'Carregando...');

    final response = await http.get(
      Uri.parse(
          'https://tcc2-api.herokuapp.com/stream/report?days=${controller.rx_days.value + 1}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${token}'
      },
    );

    final body = jsonDecode(response.body);
    List<dynamic> aux = body['data'];
    setState(() {
      streams = aux;
    });
    EasyLoading.dismiss();
  }

  List<StreamCard> getCardList() {
    return streams
        .map((item) => StreamCard(item['stream_date'], item['duration']))
        .toList();
  }

  Widget build(BuildContext context) {
    return Column(children: getCardList());
  }
}

class StreamCard extends StatelessWidget {
  final String date;
  final int duration;

  StreamCard(this.date, this.duration);

  String durationToString(int minutes) {
    var d = Duration(minutes: minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}h${parts[1].padLeft(2, '0')}';
  }

  String getText() {
    final formatted_date = Jiffy(date, 'yyyy-MM-dd').format('dd/MM/yyy');
    final minutes = duration ~/ 60;
    final time_string = durationToString(minutes);

    return "${formatted_date} - ${time_string}";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
          top: getProportionateScreenWidth(5),
          bottom: getProportionateScreenWidth(5)),
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
        vertical: getProportionateScreenWidth(15),
      ),
      decoration: BoxDecoration(
        color: Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "Horas streamadas\n"),
            TextSpan(
              text: getText(),
              style: TextStyle(
                fontSize: getProportionateScreenWidth(24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
