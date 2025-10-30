import 'package:flutter/material.dart';

class NotCompletedHistoryScreen extends StatelessWidget {
  const NotCompletedHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color tdpGreen = const Color(0xFF006400);

    // Dummy data - Replace with actual data
    final List<Map<String, String>> notCompletedProjects = [
      {
        'reason': 'Heavy rains delayed construction.',
        'date': '2024-06-05',
      },
      {
        'reason': 'Material shortage in local market.',
        'date': '2024-05-27',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Completed History'),
        backgroundColor: Colors.yellow[800],
        foregroundColor: tdpGreen,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: notCompletedProjects.length,
        itemBuilder: (context, index) {
          final project = notCompletedProjects[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.warning, color: Colors.redAccent),
              title: Text(project['reason']!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Date: ${project['date']}'),
            ),
          );
        },
      ),
    );
  }
}
