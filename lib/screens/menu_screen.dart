import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color tdpYellow = Colors.yellow[800]!;
    final Color tdpGreen = const Color(0xFF006400);

    return SafeArea(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material( // Ensures tap effects and safe dismiss
          color: Colors.yellow[50],
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Column(
              children: [
                // Header
                Container(
                  color: tdpYellow,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  width: double.infinity,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile'); // Go to profile
                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ashfak Sayem',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF006400),
                            ),
                          ),
                          Text(
                            'ashfak',
                            style: TextStyle(
                              color: Color(0xFF006400).withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Menu Items
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      _buildMenuItem(context, Icons.dashboard, "Development Activities", "/allActivities", tdpGreen),
                      _buildMenuItem(context, Icons.pending_actions, "Pending Review", "/feedbackHistory", tdpGreen),
                      _buildMenuItem(context, Icons.person, "Profile", "/profile", tdpGreen),
                      _buildMenuItem(context, Icons.notifications, "Notification", "/notifications", tdpGreen),
                      _buildMenuItem(context, Icons.report, "Report", "/report", tdpGreen),
                      _buildMenuItem(context, Icons.feedback, "Feedback", "/feedback", tdpGreen),
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

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String routeName, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: color),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
