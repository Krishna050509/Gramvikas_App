import 'package:flutter/material.dart';
import 'FeedbackHistoryScreen.dart';

class AllActivitiesScreen extends StatefulWidget {
  const AllActivitiesScreen({super.key});

  @override
  State<AllActivitiesScreen> createState() => _AllActivitiesScreenState();
}

class _AllActivitiesScreenState extends State<AllActivitiesScreen> {
  final Color tdpYellow = Colors.yellow[800]!;
  final Color tdpGreen = const Color(0xFF006400);

  final List<Map<String, dynamic>> allProjects = [
    {
      'title': 'Road Repair - Sector 1',
      'description': 'Fixing potholes and resurfacing main roads.',
      'category': 'Roads',
      'budget': '\$1.5M',
      'status': 'Completed',
      'image': 'assets/road.jpg',
    },
    {
      'title': 'New School Building',
      'description': 'Primary school for 300+ students.',
      'category': 'Schools',
      'budget': '\$800K',
      'status': 'Ongoing',
      'image': 'assets/school.jpg',
    },
    {
      'title': 'Drainage Project - Ward 4',
      'description': 'Installing new underground drainage system.',
      'category': 'Sanitation',
      'budget': '\$600K',
      'status': 'Planned',
      'image': 'assets/sanitation.jpg',
    },
    {
      'title': 'Community Clinic Upgrade',
      'description': 'Upgrading facilities and equipment.',
      'category': 'Health',
      'budget': '\$400K',
      'status': 'Ongoing',
      'image': 'assets/health.jpg',
    },
  ];

  String selectedStatus = 'All';
  String selectedCategory = 'All';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredProjects = allProjects.where((project) {
      final matchesStatus =
          selectedStatus == 'All' || project['status'] == selectedStatus;
      final matchesCategory =
          selectedCategory == 'All' || project['category'] == selectedCategory;
      final matchesSearch = project['title']
          .toLowerCase()
          .contains(searchQuery.toLowerCase()) ||
          project['description']
              .toLowerCase()
              .contains(searchQuery.toLowerCase());
      return matchesStatus && matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Development Activities'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
      ),
      backgroundColor: Colors.yellow[50], // Scaffold background
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterRow(),
          const SizedBox(height: 8),
          Expanded(
            child: filteredProjects.isEmpty
                ? const Center(child: Text('No matching projects found.'))
                : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                final project = filteredProjects[index];
                return _buildProjectCard(project);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search by title or description',
          prefixIcon: Icon(Icons.search, color: tdpGreen),
          filled: true,
          fillColor: Colors.yellow[50], // <-- updated
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: tdpGreen),
          ),
        ),
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildFilterRow() {
    final statuses = ['All', 'Ongoing', 'Completed', 'Planned'];
    final categories = ['All', 'Roads', 'Schools', 'Sanitation', 'Health'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Status',
                labelStyle: TextStyle(color: tdpGreen),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: tdpGreen),
                ),
                filled: true,
                fillColor: Colors.yellow[50], // <-- updated
              ),
              value: selectedStatus,
              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
              dropdownColor: Colors.white,
              iconEnabledColor: tdpGreen,
              items: statuses.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(status, style: TextStyle(color: tdpGreen)),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(color: tdpGreen),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: tdpGreen),
                ),
                filled: true,
                fillColor: Colors.yellow[50], // <-- updated
              ),
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              dropdownColor: Colors.white,
              iconEnabledColor: tdpGreen,
              items: categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat, style: TextStyle(color: tdpGreen)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Card(
      color: Colors.yellow[50],
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              project['image'],
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 160,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project['title'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: tdpGreen,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  project['description'],
                  style: TextStyle(color: Colors.grey[800]),
                ),
                const SizedBox(height: 10),
                _buildDetailRow(Icons.category, 'Category', project['category']),
                _buildDetailRow(Icons.attach_money, 'Budget', project['budget']),
                _buildDetailRow(Icons.check_circle, 'Status', project['status']),
                const SizedBox(height: 10),

                // ✅ If status is 'Ongoing', show Yes/No buttons
                if (project['status'] == 'Ongoing')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Is this project completed?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/completed');
                            },
                            icon: const Icon(Icons.check),
                            label: const Text('Yes'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: tdpGreen,
                              foregroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, '/not_completed');
                            },
                            icon: const Icon(Icons.close),
                            label: const Text('No'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                // ✅ Optional: Feedback for Completed projects
                if (project['status'] == 'Completed')
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: tdpGreen,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FeedbackHistoryScreen(
                                projectTitle: project['title']),
                          ),
                        );
                      },
                      icon: const Icon(Icons.feedback),
                      label: const Text('Give Feedback'),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: tdpGreen),
          const SizedBox(width: 8),
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 6),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
