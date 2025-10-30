import 'package:flutter/material.dart';
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color tdpGreen = const Color(0xFF006400);
    final Color tdpYellow = Colors.yellow[800]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
      ),
      body: const Center(
        child: Text('History Screen Content Here'),
      ),
    );
  }
}
