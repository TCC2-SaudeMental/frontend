import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../services/storage.dart';

class StreamService {
  Future<Stream> streamList(int days) async {
    var token = await secureStorage.read(key: 'jwt');
    final response = await http.get(
      Uri.parse('https://tcc2-api.herokuapp.com/stream/report?days=$days'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return Stream.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load stream');
    }
  }
}

class Stream {
  final int duration;
  final int id;
  final String stream_date;
  final String status;

  Stream(
      {required this.duration,
      required this.id,
      required this.stream_date,
      required this.status});

  factory Stream.fromJson(Map<String, dynamic> json) {
    return Stream(
        duration: json['data']['duration'],
        id: json['data']['id'],
        stream_date: json['data']['stream_date'],
        status: json['status']);
  }
}
