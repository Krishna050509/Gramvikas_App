import 'package:flutter/material.dart';

class adm_ProfileScreen extends StatelessWidget {
  const adm_ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color tdpYellow = Colors.yellow[800]!;
    final Color tdpGreen = const Color(0xFF006400);

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: tdpYellow,
        foregroundColor: tdpGreen,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header with photo and name
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            decoration: BoxDecoration(
              color: tdpYellow,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
                const SizedBox(height: 15),
                Text(
                  'Ashfak Sayem',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: tdpGreen,
                  ),
                ),
                Text(
                  'ashfak@example.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: tdpGreen.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Details
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildProfileCard(Icons.person, "Username", "ashfak", tdpGreen),
                _buildProfileCard(Icons.email, "Gmail", "ashfak@example.com", tdpGreen),
                _buildProfileCard(Icons.location_on, "Address", "123 TDP Road, Dhaka, Bangladesh", tdpGreen),
                _buildProfileCard(Icons.phone, "Phone Number", "+880 1234-567890", tdpGreen),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(IconData icon, String title, String value, Color color) {
    return Card(
      color: Colors.yellow[50], // Light yellow card
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 1.5, // Subtle shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        subtitle: Text(
          value,
          style: TextStyle(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

}
