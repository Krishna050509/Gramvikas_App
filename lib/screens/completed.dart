import 'package:flutter/material.dart';
import 'CompletedHistoryScreen.dart'; // <-- Import the new screen

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color tdpGreen = const Color(0xFF006400);
    final Color lightYellow = Colors.yellow[50]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Completion'),
        backgroundColor: Colors.yellow[800],
        foregroundColor: tdpGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'View Completed History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CompletedHistoryScreen()),
              );
            },
          ),
        ],
      ),
      backgroundColor: lightYellow,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Project Title"),
                _buildTextField("Enter project title"),
                const SizedBox(height: 16),

                _buildLabel("Description"),
                _buildTextField("Enter project description", maxLines: 3),
                const SizedBox(height: 16),

                _buildLabel("Category"),
                _buildTextField("Enter category"),
                const SizedBox(height: 20),

                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload Proof"),
                    onPressed: () {
                      // TODO: Handle file upload
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: ElevatedButton(
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      // TODO: Submit logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Submitted successfully!")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdpGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 16),
                      textStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.yellow[50],
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
