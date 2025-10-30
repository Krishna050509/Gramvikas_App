import 'package:flutter/material.dart';
import 'adm_FeedbackDetailScreen.dart'; // Adjust the import path accordingly

class adm_FeedbackScreen extends StatefulWidget {
  const adm_FeedbackScreen({super.key});

  @override
  State<adm_FeedbackScreen> createState() => _adm_FeedbackScreenState();
}

class _adm_FeedbackScreenState extends State<adm_FeedbackScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> disagreeFeedback = [
    {'title': 'Feedback 1', 'comment': 'water problem'},
    {'title': 'Feedback 2', 'comment': 'area clean'},
    {'title': 'Feedback 1', 'comment': 'water tank problem'}, // duplicate
  ];

  final List<Map<String, String>> agreeFeedback = [
    {'title': 'Feedback 3', 'comment': 'water problem'},
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
                builder: (context) => adm_FeedbackDetailScreen(
                  title: "Feedback ${index + 1}",
                  date: "25 May 2025",
                  description:"ggg",
                  category:"hhh",// Replace with real date if available
                  status: "rejected",
                  image:"gg",
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
            Tab(text: 'Disagree'),
            Tab(text: 'Agree'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildFeedbackList(disagreeFeedback),
          buildFeedbackList(agreeFeedback),
        ],
      ),
    );
  }
}
