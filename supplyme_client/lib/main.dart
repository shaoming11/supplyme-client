import 'package:flutter/material.dart';
import 'package:supplyme_client/pages/prompt.dart';

import 'pages/results.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SupplyMe",
      home: const PromptPage(),
      routes: {
        "/home": (context) => const PromptPage(),
        "/results": (context) => const ResultsPage(prompt: ""),
      },
    );
  }
}
