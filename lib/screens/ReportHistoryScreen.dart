import 'package:flutter/material.dart';

class ReportHistoryScreen extends StatefulWidget {
  const ReportHistoryScreen({super.key});

  @override
  State<ReportHistoryScreen> createState() => _ReportHistoryScreenState();
}

class _ReportHistoryScreenState extends State<ReportHistoryScreen> {
  final List<Map<String, String>> _allReports = [
    {
      'title': 'Broken Water Pipe',
      'description': 'Water leaking near junction',
      'category': 'Water',
      'location': 'Ward 5',
      'status': 'Under Review',
    },
    {
      'title': 'Street Light Not Working',
      'description': 'Complete darkness in the lane',
      'category': 'Electricity',
      'location': 'Ward 3',
      'status': 'Accepted',
    },
    {
      'title': 'Potholes',
      'description': 'Large potholes causing traffic',
      'category': 'Road',
      'location': 'North Zone',
      'status': 'Resolved',
    },
  ];

  String _searchQuery = '';
  String? _selectedCategory;
  String? _selectedStatus;

  final List<String> _categories = ['Road', 'Water', 'Electricity', 'Health', 'Education'];
  final List<String> _statuses = ['Under Review', 'Accepted', 'Resolved'];

  @override
  Widget build(BuildContext context) {
    final filteredReports = _allReports.where((report) {
      final matchesSearch = _searchQuery.isEmpty ||
          report['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          report['description']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null || report['category'] == _selectedCategory;
      final matchesStatus = _selectedStatus == null || report['status'] == _selectedStatus;
      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report History'),
        backgroundColor: Colors.yellow[800],
        foregroundColor: const Color(0xFF006400), // Deep green text/icon
      ),
      backgroundColor: Colors.yellow[50],
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search by title or description...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
            const SizedBox(height: 10),

            // Filters
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Category'),
                    value: _selectedCategory,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('All')),
                      ..._categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))),
                    ],
                    onChanged: (value) => setState(() => _selectedCategory = value),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Status'),
                    value: _selectedStatus,
                    items: [
                      const DropdownMenuItem(value: null, child: Text('All')),
                      ..._statuses.map((stat) => DropdownMenuItem(value: stat, child: Text(stat))),
                    ],
                    onChanged: (value) => setState(() => _selectedStatus = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Report list
            Expanded(
              child: filteredReports.isEmpty
                  ? const Center(child: Text('No reports match your filters.'))
                  : ListView.builder(
                itemCount: filteredReports.length,
                itemBuilder: (context, index) {
                  final report = filteredReports[index];
                  return Card(
                    color: Colors.yellow[50],
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        report['title'] ?? '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Status: ${report['status']}'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(report['title'] ?? 'Report Details'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description: ${report['description']}'),
                                Text('Category: ${report['category']}'),
                                Text('Location: ${report['location']}'),
                                Text('Status: ${report['status']}'),
                                const SizedBox(height: 10),
                                const Text('Media:'),
                                const Icon(Icons.image, size: 40), // Placeholder
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
