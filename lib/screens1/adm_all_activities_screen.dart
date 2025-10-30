import 'package:flutter/material.dart';
// Import your ReportSubmissionScreen here
import 'report_submission_screen.dart';

class adm_AllActivitiesScreen extends StatefulWidget {
  const adm_AllActivitiesScreen({super.key});

  @override
  State<adm_AllActivitiesScreen> createState() => _adm_AllActivitiesScreenState();
}

class _adm_AllActivitiesScreenState extends State<adm_AllActivitiesScreen> with SingleTickerProviderStateMixin {
  final Color tdpYellow = Colors.yellow[800]!;
  final Color tdpGreen = const Color(0xFF006400);

  late TabController _tabController;

  String searchQuery = '';

  List<Map<String, dynamic>> allProjects = [
    {
      'title': 'Road Repair - Sector 1',
      'description': 'Fixing potholes and resurfacing main roads.',
      'category': 'Roads',
      'image': 'assets/road.jpg',
      'status': 'Pending',
      'projectStatus': 'Planned',
    },
    {
      'title': 'New School Building',
      'description': 'Primary school for 300+ students.',
      'category': 'Schools',
      'image': 'assets/school.jpg',
      'status': 'Accepted',
      'projectStatus': 'Planned',
    },
    {
      'title': 'Drainage Project - Ward 4',
      'description': 'Installing new underground drainage system.',
      'category': 'Sanitation',
      'image': 'assets/sanitation.jpg',
      'status': 'Accepted',
      'projectStatus': 'Completed',
    },
    {
      'title': 'Community Clinic Upgrade',
      'description': 'Upgrading facilities and equipment.',
      'category': 'Health',
      'image': 'assets/health.jpg',
      'status': 'Rejected',
      'projectStatus': 'N/A',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _filteredProjects(String statusFilter) {
    return allProjects.where((project) {
      final matchesStatus = statusFilter == 'All' || project['status'] == statusFilter;
      final matchesSearch = project['title'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          project['description'].toLowerCase().contains(searchQuery.toLowerCase());
      return matchesStatus && matchesSearch;
    }).toList();
  }

  void _updateStatus(int index, String newStatus) {
    setState(() {
      allProjects[index]['status'] = newStatus;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Project $newStatus'),
        backgroundColor: newStatus == 'Accepted' ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Development Activities'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
        bottom: TabBar(
          controller: _tabController,
          labelColor: tdpGreen,
          unselectedLabelColor: Colors.grey[700],
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Accepted'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      backgroundColor: Colors.yellow[50],
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildProjectList('Pending'),
                _buildProjectList('Accepted'),
                _buildProjectList('Rejected'),
              ],
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
          fillColor: Colors.yellow[50],
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

  Widget _buildProjectList(String statusFilter) {
    final filtered = _filteredProjects(statusFilter);

    if (filtered.isEmpty) {
      return Center(child: Text('No $statusFilter projects found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final project = filtered[index];
        final actualIndex = allProjects.indexOf(project);
        return _buildProjectCard(project, actualIndex);
      },
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project, int projectIndex) {
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
                const SizedBox(height: 10),


                if (project['status'] == 'Pending')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _updateStatus(projectIndex, 'Accepted'),
                        icon: const Icon(Icons.check),
                        label: const Text('Accept'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          foregroundColor: Colors.white,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _updateStatus(projectIndex, 'Rejected'),
                        icon: const Icon(Icons.close),
                        label: const Text('Reject'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),

                if (project['status'] == 'Accepted')
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReportSubmissionScreen(
                                // pass any necessary data here
                              ),
                            ),
                          );
                        },
                        child: const Text('Report'),
                      ),
                    ),
                  ),

                if (project['status'] != 'Pending')
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, top: 6),
                      child: Chip(
                        label: Text(
                          project['status'],
                          style: const TextStyle(color: Colors.white),
                        ),
                        backgroundColor: project['status'] == 'Accepted'
                            ? Colors.green
                            : Colors.red,
                      ),
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
}
