import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

Future<void> findAll() async {
  try {
    final Response response = await http.get(Uri.parse('http://192.168.15.76:8080/transactions'));
    debugPrint(response.body);
  } catch (e) {
    debugPrint(e.toString());
  }
}