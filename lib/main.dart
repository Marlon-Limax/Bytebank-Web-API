import 'dart:developer';

import 'package:bytebankwebapi/models/contact.dart';
import 'package:bytebankwebapi/models/transaction.dart';
import 'package:bytebankwebapi/screens/dashboard.dart';
import 'package:flutter/material.dart';

import 'http/webclient.dart';

void main() {
  runApp(const ByteBankApp());
  WebClient loggingInterceptor = WebClient();
  loggingInterceptor.save(Transaction(500.0, Contact(0, 'Bobbyz', 3000))).then((transaction) => log(transaction.toString()));
  //loggingInterceptor.findAll().then((transactions) => debugPrint('new transactions $transactions'));
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
