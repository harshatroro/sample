import 'package:flutter/cupertino.dart';

class ResultScreen extends StatefulWidget {
  final String? text;

  const ResultScreen({
    super.key,
    required this.text,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String text = "No Text Found";

  @override
  void initState() {
    super.initState();
    if(widget.text != null || widget.text!.isNotEmpty) {
      text = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            decoration: TextDecoration.none,
            fontSize: 16,
            color: CupertinoColors.inactiveGray,
          ),
        ),
      ),
    );
  }
}
