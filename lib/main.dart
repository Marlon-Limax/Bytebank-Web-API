import 'package:bytebankwebapi/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'http/webclient.dart';

void main() {
  runApp(const ByteBankApp());
  LoggingInterceptor teste = LoggingInterceptor();
  teste.findAll();
}

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.green[900],
            secondary: Colors.blueAccent,
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: const Dashboard());
  }
}
