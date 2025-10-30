import 'package:flutter/material.dart';

class ReportSubmissionScreen extends StatefulWidget {
  final String dealTitle;
  final int dealId;

  const ReportSubmissionScreen({
    Key? key,
    this.dealTitle = 'Untitled Deal',
    this.dealId = 0,
  }) : super(key: key);

  @override
  State<ReportSubmissionScreen> createState() => _ReportSubmissionScreenState();
}

class _ReportSubmissionScreenState extends State<ReportSubmissionScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();

  final Color tdpYellow = Colors.yellow[800]!;
  final Color tdpGreen = const Color(0xFF006400);

  String selectedCategory = 'Roads';
  final List<String> categories = ['Roads', 'Schools', 'Sanitation', 'Health'];

  List<String> photoPaths = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: Text('Report for Deal #${widget.dealId}'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            tooltip: 'Report History',
            onPressed: () {
              Navigator.pushNamed(context, '/admreportHistory');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reporting for: ${widget.dealTitle}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: tdpGreen),
            ),
            const SizedBox(height: 16),

            // Description
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Report Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),

            // Budget
            TextField(
              controller: budgetController,
              decoration: const InputDecoration(
                labelText: 'Budget (in USD)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Category dropdown
            DropdownButtonFormField<String>(
              value: selectedCategory,
              items: categories
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Photos (placeholder)
            Text('Photos (not functional)', style: TextStyle(color: Colors.grey[600])),
            Wrap(
              spacing: 10,
              children: [
                ...photoPaths.map((path) => ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.photo),
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      photoPaths.add('dummy_photo_path');
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Submit button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  if (descriptionController.text.trim().isEmpty ||
                      budgetController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill all required fields.')),
                    );
                    return;
                  }

                  // Submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report submitted successfully')),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tdpGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Submit Report'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
