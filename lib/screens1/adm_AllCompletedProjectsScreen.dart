import 'package:flutter/material.dart';
import 'package:gramvikas/screens1/adm_ProofDetailScreen.dart';

class adm_AllCompletedProjectsScreen extends StatefulWidget {
  final List<String> projects;

  const adm_AllCompletedProjectsScreen({super.key, required this.projects});

  @override
  State<adm_AllCompletedProjectsScreen> createState() => _adm_AllCompletedProjectsScreenState();
}

class _adm_AllCompletedProjectsScreenState extends State<adm_AllCompletedProjectsScreen> {
  String searchQuery = '';
  String selectedCategory = 'All';

  final Map<String, String> projectCategories = {
    'Road Repair - Sector 1': 'Roads',
    'Water Tank Maintenance': 'Water',
    'Park Renovation': 'Parks',
    'Drainage Cleanup': 'Sanitation',
  };

  final Color tdpGreen = const Color(0xFF006400);

  List<String> get filteredProjects {
    return widget.projects.where((project) {
      final matchesSearch = project.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == 'All' || projectCategories[project] == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', ...projectCategories.values.toSet()];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Completed Projects'),
        backgroundColor: Colors.yellow[800],
        foregroundColor: tdpGreen,
        elevation: 4,
      ),
      backgroundColor: Colors.yellow[50],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (value) => setState(() => searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search by project title',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                );
              }).toList(),
              onChanged: (value) => setState(() => selectedCategory = value!),
              decoration: InputDecoration(
                labelText: 'Filter by Category',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredProjects.length,
              itemBuilder: (context, index) {
                final project = filteredProjects[index];

                return Card(
                  color: Colors.yellow[100],
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    title: Text(
                      project,
                      style: TextStyle(
                        color: tdpGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(projectCategories[project] ?? 'Unknown'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black54),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => adm_ProofDetailScreen(title: project),
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
    );
  }
}
