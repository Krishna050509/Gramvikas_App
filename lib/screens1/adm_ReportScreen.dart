import 'package:flutter/material.dart';
import 'package:gramvikas/screens/ReportHistoryScreen.dart';

class adm_ReportScreen extends StatefulWidget {
  final String projectTitle;

  const adm_ReportScreen({super.key, required this.projectTitle});

  @override
  State<adm_ReportScreen> createState() => _adm_ReportScreenState();
}

class _adm_ReportScreenState extends State<adm_ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  String? _category;
  String? _location;
  String? _status = 'Under Review';

  final List<String> _categories = ['Road', 'Water', 'Electricity', 'Health', 'Education'];
  final List<String> _statuses = ['Under Review', 'Accepted', 'Resolved'];

  @override
  Widget build(BuildContext context) {
    final tdpYellow = Colors.yellow[800];
    final tdpGreen = const Color(0xFF006400);

    return Scaffold(
      appBar: AppBar(
        title: Text('Report Issue - ${widget.projectTitle}'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Report History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReportHistoryScreen(),
                ),
              );
            },
          ),
        ],
      ),

      backgroundColor: Colors.yellow[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Title', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Issue title...',
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a title' : null,
                onSaved: (value) => _title = value,
              ),
              const SizedBox(height: 15),

              const Text('Description', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Detailed description...',
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter a description' : null,
                onSaved: (value) => _description = value,
              ),
              const SizedBox(height: 15),

              const Text('Category', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: _categories
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setState(() => _category = value),
                validator: (value) => value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 15),

              const Text('Location (Ward / Area)', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Ward 5, North Zone',
                ),
                onSaved: (value) => _location = value,
              ),
              const SizedBox(height: 15),

              const Text('Upload Photo or Video', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              OutlinedButton.icon(
                onPressed: () {
                  // You can implement image/video picker here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Upload feature coming soon...')),
                  );
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Choose File'),
              ),
              const SizedBox(height: 15),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // You can handle submission here (e.g., send to server or local DB)
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Submitted'),
                        content: const Text('Your issue has been submitted successfully.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          )
                        ],
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: tdpGreen),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
