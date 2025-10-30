import 'package:flutter/material.dart';



class FeedbackDetailScreen extends StatefulWidget {
  final String title;
  final String date;
  final String comment;

  const FeedbackDetailScreen({
    Key? key,
    required this.title,
    required this.date,
    required this.comment,
  }) : super(key: key);

  @override
  State<FeedbackDetailScreen> createState() => _FeedbackDetailScreenState();
}

class _FeedbackDetailScreenState extends State<FeedbackDetailScreen> {
  String? feedbackAnswer;

  Widget _buildOptionButton(String label) {
    final isSelected = feedbackAnswer == label;
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green[700] : Colors.green[300],
        ),
        onPressed: () {
          setState(() {
            feedbackAnswer = label;
          });
        },
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.yellow[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[800]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(fontSize: 14, color: Colors.green[700]),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.comment,
                    style: TextStyle(fontSize: 16, color: Colors.green[900]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '1. Are you satisfied with the quality of this project?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildOptionButton('Agree'),
                const SizedBox(width: 12),
                _buildOptionButton('Disagree'),
              ],
            ),
            const SizedBox(height: 24),
            if (feedbackAnswer == 'Disagree')
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.report),
                  label: const Text("Report Issue"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/report');

                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
