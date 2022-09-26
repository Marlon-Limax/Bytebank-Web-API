import 'package:bytebankwebapi/components/centered_message.dart';
import 'package:bytebankwebapi/components/progress.dart';
import 'package:bytebankwebapi/models/transaction.dart';
import 'package:flutter/material.dart';

import '../http/webclient.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoggingInterceptor loggingInterceptor = LoggingInterceptor();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: Future.delayed(const Duration(seconds: 1)).then((value) => loggingInterceptor.findAll()),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
              // ignore: dead_code
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                final List<Transaction> transactions = snapshot.data ?? [];
                if (transactions.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                            transaction.value.toString(),
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            transaction.contact.accountNumber.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: transactions.length,
                  );
                }
              }
              return const CenteredMessage('No transactions found', icon: Icons.warning);
              // ignore: dead_code
              break;
          }
          return const CenteredMessage('Unknown error', icon: Icons.warning);
        },
      ),
    );
  }
}
