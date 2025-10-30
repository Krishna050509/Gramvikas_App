import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'ReportHistoryScreen.dart';  // <-- import this

class ReportScreens extends StatefulWidget {
  const ReportScreens({super.key});

  @override
  State<ReportScreens> createState() => _ReportScreensState();
}

class _ReportScreensState extends State<ReportScreens> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String? _selectedCategory;
  String? _selectedWard;
  XFile? _mediaFile;

  final List<String> categories = ['Road', 'Water', 'Electricity', 'Sanitation'];
  final List<String> wards = ['Ward 1', 'Ward 2', 'Ward 3'];

  Future<void> _pickMedia() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // or .pickVideo()
    if (pickedFile != null) {
      setState(() {
        _mediaFile = pickedFile;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle submission logic here
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Issue submitted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Issue'),
        backgroundColor: Colors.yellow[800],
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
      backgroundColor: Colors.yellow[50],  // <-- set background color here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) =>
                value == null || value.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category'),
                value: _selectedCategory,
                items: categories
                    .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCategory = value),
                validator: (value) => value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Ward'),
                value: _selectedWard,
                items: wards
                    .map((ward) => DropdownMenuItem(value: ward, child: Text(ward)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedWard = value),
                validator: (value) => value == null ? 'Please select a ward' : null,
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _pickMedia,
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Photo/Video'),
              ),
              if (_mediaFile != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('Selected: ${_mediaFile!.name}',
                      style: const TextStyle(fontSize: 14)),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
                child: const Text('Submit Issue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
