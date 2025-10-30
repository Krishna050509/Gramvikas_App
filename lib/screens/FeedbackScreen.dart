import 'package:flutter/material.dart';
import 'FeedbackDetailScreen.dart'; // Adjust the import path accordingly

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> pendingFeedback = [
    {'title': 'Feedback 1', 'comment': 'water problem'},
    {'title': 'Feedback 2', 'comment': 'area clean'},
    {'title': 'Feedback 1', 'comment': 'water tank problem'}, // duplicate
  ];

  final List<Map<String, String>> completedFeedback = [
    {'title': 'Feedback 3', 'comment': 'water problem '},
    {'title': 'Feedback 4', 'comment': 'road damage'},
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  bool isDuplicate(List<Map<String, String>> list, Map<String, String> item, int index) {
    for (int i = 0; i < list.length; i++) {
      if (i != index &&
          list[i]['title'] == item['title'] &&
          list[i]['comment'] == item['comment']) {
        return true;
      }
    }
    return false;
  }

  Widget buildFeedbackList(List<Map<String, String>> feedbackList) {
    return ListView.builder(
      itemCount: feedbackList.length,
      itemBuilder: (context, index) {
        final item = feedbackList[index];
        final isDup = isDuplicate(feedbackList, item, index);
        return ListTile(
          leading: Icon(Icons.feedback, color: isDup ? Colors.red : Colors.green),
          title: Text(item['title'] ?? ''),
          subtitle: Text(item['comment'] ?? ''),
          trailing: isDup ? const Icon(Icons.warning, color: Colors.red, size: 20) : null,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => FeedbackDetailScreen(
                  title: item['title'] ?? '',
                  date: 'May 30, 2025',
                  comment: item['comment'] ?? '',
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        backgroundColor: Colors.yellow[800],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildFeedbackList(pendingFeedback),
          buildFeedbackList(completedFeedback),
        ],
      ),
    );
  }
}
