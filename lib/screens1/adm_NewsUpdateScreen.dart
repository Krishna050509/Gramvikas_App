import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class NewsUpdateScreen extends StatefulWidget {
  const NewsUpdateScreen({super.key});

  @override
  State<NewsUpdateScreen> createState() => _NewsUpdateScreenState();
}

class _NewsUpdateScreenState extends State<NewsUpdateScreen> {
  final TextEditingController _descController = TextEditingController();
  File? _imageFile;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _submitNews() {
    if (_descController.text.isEmpty && _imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please add a description or image")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("News submitted successfully!")),
    );

    // Clear fields
    setState(() {
      _descController.clear();
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final green800 = const Color(0xFF006400);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: const Text("News Update", style: TextStyle(color: Color(0xFF006400))),
        iconTheme: const IconThemeData(color: Color(0xFF006400)),
      ),
      backgroundColor: Colors.yellow[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add News", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: green800)),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write news description...",
                filled: true,
                fillColor: Colors.yellow[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pick Image"),
              style: ElevatedButton.styleFrom(
                backgroundColor: green800,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            if (_imageFile != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_imageFile!, height: 180, width: double.infinity, fit: BoxFit.cover),
              ),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                onPressed: _submitNews,
                icon: const Icon(Icons.send),
                label: const Text("Submit News"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: green800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
