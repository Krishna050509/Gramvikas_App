import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color tdpYellow = Colors.yellow[800]!;
    final Color tdpGreen = const Color(0xFF006400);

    final List<Map<String, dynamic>> notifications = [
      {
        'icon': Icons.calendar_month,
        'title': 'Upcoming Meeting',
        'message': 'Project status meeting at 10:00 AM.',
        'time': 'Today',
      },
      {
        'icon': Icons.report_gmailerrorred,
        'title': 'Report Accepted',
        'message': 'Your recent development report has been approved.',
        'time': '1 hour ago',
      },

      {
        'icon': Icons.message,
        'title': 'New Feedback',
        'message': 'You received feedback from the review team.',
        'time': '2 days ago',
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
