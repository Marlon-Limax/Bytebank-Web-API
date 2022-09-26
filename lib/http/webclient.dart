import 'dart:convert';

import 'package:bytebankwebapi/models/contact.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import '../models/transaction.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('Request');
    debugPrint('url: ${data.url}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('Response');
    debugPrint('status code ${data.statusCode}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    return data;
  }

  Future<List<Transaction>> findAll() async {
    final List<Transaction> transactions = [];
    try {
      final Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);
      // ignore: unused_local_variable
      final Response response = await client.get(Uri.parse('http://192.168.15.76:8080/transactions')).timeout(
            const Duration(seconds: 5),
          );
      final List<dynamic> decodedJson = jsonDecode(response.body);

      for (Map<String, dynamic> transactionJson in decodedJson) {
        final Map<String, dynamic> contactJson = transactionJson['contact'];
        final Transaction transaction = Transaction(
          transactionJson['value'],
          Contact(
            0,
            contactJson['name'],
            contactJson['accountNumber'],
          ),
        );
        transactions.add(transaction);
      }
      return transactions;
    } catch (error) {
      debugPrint(error.toString());
      return transactions;
    }
  }
}
