import 'package:flutter/material.dart';

class adm_ProofDetailScreen extends StatefulWidget {
  final String title;

  const adm_ProofDetailScreen({super.key, required this.title});

  @override
  State<adm_ProofDetailScreen> createState() => _adm_ProofDetailScreenState();
}

class _adm_ProofDetailScreenState extends State<adm_ProofDetailScreen> {
  String? approvalStatus;
  final Color tdpGreen = const Color(0xFF006400);

  @override
  Widget build(BuildContext context) {
    final String description = 'Fixing potholes and resurfacing main roads.';
    final String category = 'Roads';
    final String imagePath = 'assets/road.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title} Proof'),
        backgroundColor: Colors.yellow[800],
        foregroundColor: tdpGreen,
      ),
      backgroundColor: Colors.yellow[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagePath,
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: tdpGreen,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(Icons.category, 'Category', category),
                    const SizedBox(height: 8),
                    _buildInfoRow(Icons.description, 'Description', description),
                    const SizedBox(height: 24),

                    /// Accept/Reject Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() => approvalStatus = 'Accepted');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Project Accepted'), backgroundColor: Colors.green),
                            );
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Accept'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() => approvalStatus = 'Rejected');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Project Rejected'), backgroundColor: Colors.red),
                            );
                          },
                          icon: const Icon(Icons.close),
                          label: const Text('Reject'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    if (approvalStatus != null)
                      Center(
                        child: Text(
                          'Status: $approvalStatus',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: approvalStatus == 'Accepted' ? Colors.green : Colors.red,
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
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[800]),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 16, color: Colors.black87),
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
