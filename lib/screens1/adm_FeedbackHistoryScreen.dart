import 'package:flutter/material.dart';

class adm_FeedbackHistoryScreen extends StatefulWidget {
  const adm_FeedbackHistoryScreen({super.key});

  @override
  State<adm_FeedbackHistoryScreen> createState() => _adm_FeedbackHistoryScreenState();
}

class _adm_FeedbackHistoryScreenState extends State<adm_FeedbackHistoryScreen> {
  final Color tdpGreen = const Color(0xFF006400);
  final Color tdpYellow = Colors.yellow[800]!;

  String selectedStatus = 'All';

  final List<Map<String, dynamic>> feedbackList = [
    {
      'title': 'Drainage System Repair',
      'description': 'Repaired drainage to prevent flooding.',
      'budget': '₹ 2,50,000',
      'category': 'Infrastructure',
      'status': 'Completed',
      'image': 'assets/drainage.jpg',
    },
    {
      'title': 'Community Hall Painting',
      'description': 'Repainted and refurbished the hall.',
      'budget': '₹ 90,000',
      'category': 'Community',
      'status': 'Completed',
      'image': 'assets/hall.jpg',
    },
    {
      'title': 'Street Light Installation',
      'description': 'Installed LED street lights.',
      'budget': '₹ 1,20,000',
      'category': 'Electricity',
      'status': 'Ongoing',
      'image': 'assets/streetlights.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredList = selectedStatus == 'All'
        ? feedbackList
        : feedbackList.where((f) => f['status'] == selectedStatus).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Report History'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
      ),
      backgroundColor: Colors.yellow[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Filter by Status',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white,
              ),
              value: selectedStatus,
              items: ['All', 'Ongoing', 'Completed']
                  .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final feedback = filteredList[index];
                return _buildFeedbackCard(context, feedback);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context, Map<String, dynamic> feedback) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (feedback['image'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  feedback['image'],
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 12),
            Text(
              feedback['title'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: tdpGreen),
            ),
            const SizedBox(height: 8),
            Text(feedback['description'], style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Budget: ${feedback['budget']}"),
                Text("Category: ${feedback['category']}"),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Chip(
                label: Text(
                  feedback['status'],
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: feedback['status'] == 'Ongoing' ? Colors.orange : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
