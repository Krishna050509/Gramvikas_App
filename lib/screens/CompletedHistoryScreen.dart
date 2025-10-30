import 'package:flutter/material.dart';

class CompletedHistoryScreen extends StatelessWidget {
  const CompletedHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color tdpGreen = const Color(0xFF006400);

    // Sample history list
    final List<Map<String, String>> completedProjects = [
      {
        'title': 'Road Repair - Sector 1',
        'date': '2024-06-01',
        'category': 'Roads',
      },
      {
        'title': 'New School Building',
        'date': '2024-05-15',
        'category': 'Schools',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed Project History'),
        backgroundColor: Colors.yellow[800],
        foregroundColor: tdpGreen,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: completedProjects.length,
        itemBuilder: (context, index) {
          final project = completedProjects[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text(project['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Category: ${project['category']}\nDate: ${project['date']}'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}
