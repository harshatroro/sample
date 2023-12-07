import 'package:flutter/cupertino.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(
          text,
        ),
      ),
    );
  }
}
