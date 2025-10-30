import 'package:flutter/material.dart';

class adm_FetchDataScreen extends StatelessWidget {
  final String title;
  final String category;
  final String description;
  final String date;
  final String image;

  const adm_FetchDataScreen({
    Key? key,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color tdpGreen = const Color(0xFF006400);
    final Color tdpYellow = Colors.yellow[800]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetched Details'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,

      ),
      backgroundColor: Colors.yellow[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            shadowColor: tdpGreen.withOpacity(0.4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    image,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 220,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: tdpGreen,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildInfoRow(Icons.category, 'Category', category, tdpGreen),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.description, 'Description', description, Colors.grey[800]!),
                      const SizedBox(height: 8),
                      _buildInfoRow(Icons.calendar_today, 'Date', date, Colors.grey[800]!),
                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/adminDashboard');
                          },
                          icon: const Icon(Icons.report),
                          label: const Text('Report'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: tdpGreen,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 16, color: color),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

