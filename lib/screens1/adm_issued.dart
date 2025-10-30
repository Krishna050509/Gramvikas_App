import 'package:flutter/material.dart';

class IssuedReportScreen extends StatefulWidget {
  const IssuedReportScreen({super.key});

  @override
  State<IssuedReportScreen> createState() => _IssuedReportScreenState();
}

class _IssuedReportScreenState extends State<IssuedReportScreen> {
  final Color tdpGreen = const Color(0xFF006400);
  final Color tdpYellow = Colors.yellow[800]!;

  String searchQuery = '';

  final List<Map<String, dynamic>> issuedReports = [
    {
      'title': 'Water Supply Interruption',
      'description': 'The pipeline installed last month is leaking near the junction.',
    },
    {
      'title': 'Damaged Road Surface',
      'description': 'Cracks and potholes appeared just 3 weeks after the road construction.',
    },
    {
      'title': 'Park Lighting Issue',
      'description': 'Most of the lights installed in the park are not working.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> filteredReports = issuedReports
        .where((report) =>
    report['title'].toLowerCase().contains(searchQuery.toLowerCase()) ||
        report['description'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Issued Reports'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
      ),
      backgroundColor: Colors.yellow[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search reports...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredReports.length,
              itemBuilder: (context, index) {
                final report = filteredReports[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          report['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: tdpGreen,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          report['description'],
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
