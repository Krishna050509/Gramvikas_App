import 'package:flutter/material.dart';
import 'ReportScreen.dart';

class FeedbackHistoryScreen extends StatefulWidget {
  final String projectTitle;

  const FeedbackHistoryScreen({super.key, required this.projectTitle});

  @override
  State<FeedbackHistoryScreen> createState() => _FeedbackHistoryScreenState();
}

class _FeedbackHistoryScreenState extends State<FeedbackHistoryScreen> {
  String? feedbackAnswer;

  final Color tdpYellow = Colors.yellow[800]!;
  final Color tdpGreen = const Color(0xFF006400);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback for ${widget.projectTitle}'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
      ),
      backgroundColor: Colors.yellow[50], // ✅ Background color
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportScreen(
                          projectTitle: widget.projectTitle,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.report),
                  label: const Text('Report Issue'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String value) {
    final bool isSelected = feedbackAnswer == value;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            feedbackAnswer = value;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? tdpGreen : Colors.grey[300],
          foregroundColor: isSelected ? Colors.white : Colors.black,
        ),
        child: Text(value),
      ),
    );
  }
}
