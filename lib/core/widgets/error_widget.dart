import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String errorMessage;
  const MyErrorWidget({
    Key? key,
    required this.errorMessage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
          child: Text(
        errorMessage,
        style: Theme.of(context).textTheme.titleSmall,
        textAlign: TextAlign.center,
      )),
    );
  }
}
