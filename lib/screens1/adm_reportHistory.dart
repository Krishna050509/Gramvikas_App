import 'package:flutter/material.dart';

class adm_reportHistory extends StatefulWidget {
  const adm_reportHistory({super.key});

  @override
  State<adm_reportHistory> createState() => _adm_reportHistoryState();
}

class _adm_reportHistoryState extends State<adm_reportHistory> {
  final Color tdpYellow = Colors.yellow[800]!;
  final Color tdpGreen = const Color(0xFF006400);

  String searchQuery = '';
  String selectedProjectStatus = 'All';
  String selectedCategory = 'All';

  final List<String> statuses = ['All', 'Ongoing', 'Completed'];
  final List<String> categories = ['All', 'Roads', 'Schools', 'Sanitation', 'Health'];

  List<Map<String, dynamic>> allProjects = [
    {
      'title': 'Road Repair - Sector 1',
      'description': 'Fixing potholes and resurfacing main roads.',
      'category': 'Roads',
      'projectStatus': 'Ongoing',
      'image': 'assets/road.jpg',
      'status': 'Accepted',
    },
    {
      'title': 'New School Building',
      'description': 'Primary school for 300+ students.',
      'category': 'Schools',
      'projectStatus': 'Planned',
      'image': 'assets/school.jpg',
      'status': 'Accepted',
    },
    {
      'title': 'Drainage Project - Ward 4',
      'description': 'Installing new underground drainage system.',
      'category': 'Sanitation',
      'projectStatus': 'Completed',
      'image': 'assets/sanitation.jpg',
      'status': 'Accepted',
    },
    {
      'title': 'Community Clinic Upgrade',
      'description': 'Upgrading facilities and equipment.',
      'category': 'Health',
      'projectStatus': 'Ongoing',
      'image': 'assets/health.jpg',
      'status': 'accepted',
    },
  ];

  List<Map<String, dynamic>> _filteredProjects() {
    return allProjects.where((project) {
      final isOngoingOrCompleted = project['projectStatus'] == 'Ongoing' || project['projectStatus'] == 'Completed';
      final matchesProjectStatus = selectedProjectStatus == 'All' || project['projectStatus'] == selectedProjectStatus;
      final matchesCategory = selectedCategory == 'All' || project['category'] == selectedCategory;
      final matchesSearch = project['title'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          project['description'].toLowerCase().contains(searchQuery.toLowerCase());

      return isOngoingOrCompleted && matchesProjectStatus && matchesCategory && matchesSearch;
    }).toList();
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        onChanged: (value) => setState(() => searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search projects...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedProjectStatus,
              decoration: InputDecoration(
                labelText: 'Project Status',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.yellow[50],
              ),
              items: statuses.map((status) => DropdownMenuItem(value: status, child: Text(status))).toList(),
              onChanged: (value) => setState(() => selectedProjectStatus = value!),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                filled: true,
                fillColor: Colors.yellow[50],
              ),
              items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (value) => setState(() => selectedCategory = value!),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    return Card(
      color: Colors.yellow[50],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
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
                Text(project['title'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: tdpGreen)),
                const SizedBox(height: 6),
                Text(project['description'], style: TextStyle(color: Colors.grey[800])),
                const SizedBox(height: 10),
                _buildDetailRow(Icons.category, 'Category', project['category']),
                _buildDetailRow(Icons.timeline, 'Project Status', project['projectStatus']),
                _buildDetailRow(Icons.flag, 'Approval Status', project['status']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: tdpGreen),
        const SizedBox(width: 8),
        Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 6),
        Expanded(child: Text(value)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredProjects();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Development Projects'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
      ),
      backgroundColor: Colors.yellow[50],
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilters(),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No matching projects found.'))
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) => _buildProjectCard(filtered[index]),
            ),
          ),
        ],
      ),
    );
  }
}
