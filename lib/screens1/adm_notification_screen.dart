import 'package:flutter/material.dart';

class adm_NotificationScreen extends StatelessWidget {
  const adm_NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color tdpYellow = Colors.yellow[800]!;
    final Color tdpGreen = const Color(0xFF006400);

    final List<Map<String, dynamic>> notifications = [
      {
        'icon': Icons.calendar_month,
        'title': 'Upcoming Meeting',
        'message': 'Ward review meeting scheduled for 10:00 AM tomorrow.',
        'time': 'Today',
      },
      {
        'icon': Icons.pending_actions,
        'title': 'Report Pending',
        'message': 'Sanitation project report submission is pending.',
        'time': '2 hours ago',
      },
      {
        'icon': Icons.assignment_turned_in,
        'title': 'Project Completion Proof',
        'message': 'Upload proof of completion for Sector 3 drainage project.',
        'time': 'Yesterday',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
        elevation: 0,
      ),
      backgroundColor: Colors.yellow[50],
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.yellow[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: tdpGreen.withOpacity(0.1),
                child: Icon(notification['icon'], color: tdpGreen),
              ),
              title: Text(
                notification['title'],
                style: TextStyle(fontWeight: FontWeight.bold, color: tdpGreen),
              ),
              subtitle: Text(notification['message']),
              trailing: Text(
                notification['time'],
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
