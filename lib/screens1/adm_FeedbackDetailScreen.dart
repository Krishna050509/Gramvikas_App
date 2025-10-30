import 'package:flutter/material.dart';
import 'package:gramvikas/screens1/adm_FetchDataScreen.dart'; // Adjust the import path accordingly

class adm_FeedbackDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String category;
  final String date;
  final String status;
  final String image;

  const adm_FeedbackDetailScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    required this.status,
    required this.image,
  }) : super(key: key);

  @override
  State<adm_FeedbackDetailScreen> createState() => _adm_FeedbackDetailScreenState();
}

class _adm_FeedbackDetailScreenState extends State<adm_FeedbackDetailScreen> {
  String? feedbackAnswer;
  String? projectStatus; // 'Accepted' or 'Rejected'
  bool showFetchButton = false; // Controls visibility of Fetch button

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

  void _setStatus(String status) {
    setState(() {
      projectStatus = status;
      showFetchButton = status == 'Accepted'; // Show fetch button only if Accepted
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Project $status'),
        backgroundColor: status == 'Accepted' ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color tdpGreen = const Color(0xFF006400);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.yellow[800],
        foregroundColor: tdpGreen,
      ),
      backgroundColor: Colors.yellow[50],
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tdpGreen),
          ),
          const SizedBox(height: 8),
          Text(widget.description, style: TextStyle(color: Colors.grey[800])),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.category, size: 18, color: tdpGreen),
              const SizedBox(width: 6),
              Text('Category: ${widget.category}'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 18, color: tdpGreen),
              const SizedBox(width: 6),
              Text('Date: ${widget.date}'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.assignment, size: 18, color: tdpGreen),
              const SizedBox(width: 6),
              Text('Status: ${widget.status}'),
            ],
          ),
          const SizedBox(height: 24),

          /// Accept/Reject Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: () => _setStatus('Accepted'),
                icon: const Icon(Icons.check),
                label: const Text('Accept'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _setStatus('Rejected'),
                icon: const Icon(Icons.close),
                label: const Text('Reject'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[700],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          /// Show Fetch button only if accepted
          if (showFetchButton)
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => adm_FetchDataScreen(
                      title: 'Road Repair - Sector 1',
                      category: 'Roads',
                      description: 'Fixing potholes and resurfacing main roads.',
                      date: '2025-06-03',
                      image:"fggg",
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.download),
              label: const Text('Fetch'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
