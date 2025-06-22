import 'package:flutter/material.dart';
import 'package:supplyme_client/api/prompt.dart';

class ResultsPage extends StatefulWidget {
  final String prompt;

  const ResultsPage({
    super.key,
    required this.prompt,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  String prompt = "";

  bool firstTime = true;

  Map<String, dynamic>? results;

  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      prompt = widget.prompt;

      firstTime = false;

      callAPI(prompt).then((res) {
        setState(() {
          results = res;
        });
      });
    }
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                Text("a")
              ],
            ),
            Container(
              child: Text("b"),
            )
          ],
        ),
      ),
    );
  }
}