import 'package:flutter/material.dart';

class DealDetailScreen extends StatefulWidget {
  final int dealId;

  const DealDetailScreen({Key? key, required this.dealId}) : super(key: key);

  @override
  State<DealDetailScreen> createState() => _DealDetailScreenState();
}

class _DealDetailScreenState extends State<DealDetailScreen> {
  final List<Map<String, dynamic>> allDeals = [
    {
      'title': 'Road Repair in Zone 5',
      'description': 'Repairing damaged roads in Zone 5.',
      'category': 'Roads',
      'budget': '\$1.2M',
      'status': 'Completed',
      'image': 'assets/road.jpg',
    },
    {
      'title': 'School Construction',
      'description': 'New primary school in Sector 3.',
      'category': 'Schools',
      'budget': '\$500K',
      'status': 'Ongoing',
      'image': 'assets/school.jpg',
    },
    {
      'title': 'Drainage Upgrade',
      'description': 'Upgrading drainage in Ward 7.',
      'category': 'Sanitation',
      'budget': '\$300K',
      'status': 'Planned',
      'image': 'assets/sanitation.jpg',
    },
    {
      'title': 'Health Center Renovation',
      'description': 'Renovating Ward 2 Health Center.',
      'category': 'Health',
      'budget': '\$400K',
      'status': 'Ongoing',
      'image': 'assets/health.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Color tdpGreen = const Color(0xFF006400);
    final Color tdpYellow50 = Colors.yellow[50]!;

    final ongoingDeals =
    allDeals.where((deal) => deal['status'] == 'Ongoing').toList();

    if (ongoingDeals.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Ongoing Deals'),
          backgroundColor: Colors.yellow[800],
        ),
        backgroundColor: tdpYellow50,
        body: const Center(
          child: Text('No ongoing deals available.'),
        ),
      );
    }

    final deal = ongoingDeals[widget.dealId % ongoingDeals.length];

    return Scaffold(
      appBar: AppBar(
        title: Text('Deal #${widget.dealId}'),
        backgroundColor: Colors.yellow[800],
        foregroundColor: tdpGreen,
      ),
      backgroundColor: tdpYellow50,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: tdpYellow50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      deal['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Center(
                            child: Icon(Icons.broken_image, size: 50)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deal #${widget.dealId}: ${deal['title']}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: tdpGreen,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          deal['description'],
                          style:
                          TextStyle(fontSize: 16, color: Colors.grey[800]),
                        ),
                        const SizedBox(height: 20),
                        _buildDetailRow(Icons.category, 'Category',
                            deal['category'], tdpGreen),
                        _buildDetailRow(Icons.attach_money, 'Budget',
                            deal['budget'], tdpGreen),
                        _buildDetailRow(Icons.check_circle, 'Status',
                            deal['status'], tdpGreen),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'If the project is completed, please click \'Yes\' or \'No\':',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: const Text('Yes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdpGreen,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/completed');
                  },
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  icon: const Icon(Icons.close, color: Colors.white),
                  label: const Text('No'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/not_completed');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label:',
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: color.withOpacity(0.8)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
