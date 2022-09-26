import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  final String message;
  // ignore: use_key_in_widget_constructors
  const Progress({this.message = 'loading'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Text(message),
        ],
      ),
    );
  }
}
