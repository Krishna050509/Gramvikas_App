import 'package:flutter/material.dart';
import 'NotCompletedHistoryScreen.dart'; // <-- Create and import this file

class NotCompletedScreen extends StatefulWidget {
  const NotCompletedScreen({super.key});

  @override
  State<NotCompletedScreen> createState() => _NotCompletedScreenState();
}

class _NotCompletedScreenState extends State<NotCompletedScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color tdpGreen = const Color(0xFF006400);
    final Color lightYellow = Colors.yellow[50]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Not Completed'),
        backgroundColor: Colors.yellow[800],
        foregroundColor: tdpGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'View Not Completed History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotCompletedHistoryScreen()),
              );
            },
          )
        ],
      ),
      backgroundColor: lightYellow,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.redAccent, size: 50),
                const SizedBox(height: 16),
                Text(
                  'Please provide a reason for not completing the project:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Enter reason/description",
                    filled: true,
                    fillColor: Colors.yellow[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    final desc = _descriptionController.text.trim();
                    if (desc.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter a description.")),
                      );
                      return;
                    }

                    // TODO: Submit logic here (API / storage)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Submitted: $desc"),
                      ),
                    );

                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.send),
                  label: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdpGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Back"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
