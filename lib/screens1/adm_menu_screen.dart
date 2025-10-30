import 'package:flutter/material.dart';

class adm_MenuScreen extends StatelessWidget {
  const adm_MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color tdpYellow = Colors.yellow[800]!;
    final Color tdpGreen = const Color(0xFF006400);

    return SafeArea(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Material(
          color: Colors.yellow[50],
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
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
                          Navigator.pushNamed(context, '/profile');
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
                              color: tdpGreen,
                            ),
                          ),
                          Text(
                            'ashfak',
                            style: TextStyle(
                              color: tdpGreen.withOpacity(0.8),
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
                      _buildMenuItem(
                          context, Icons.pending_actions, "Pending Projects Approval", "/adm_allActivities", tdpGreen),
                      _buildMenuItem(context, Icons.build_circle_outlined, "Development Projects", "/admreportHistory", tdpGreen),
                      _buildMenuItem(context, Icons.mark_chat_read_outlined, "Review Completed List", "/adm_feedbackHistory", tdpGreen),
                      _buildMenuItem(context, Icons.report_problem_outlined, "Issued Reported List", "/issued", tdpGreen),
                      _buildMenuItem(context, Icons.feedback_outlined, "Feedback Report History", "/feedbackreportHistory", tdpGreen),
                      _buildMenuItem(context, Icons.assignment_turned_in, "Project Completion Proof", "/adm_AllCompletedProjectsScreen", tdpGreen),
                      const Divider(height: 30),
                      _buildMenuItem(context, Icons.notifications_outlined, "Notifications", "/notifications", tdpGreen),
                      _buildMenuItem(context, Icons.newspaper_outlined, "News Update", "/newsUpdate", tdpGreen),
                      _buildMenuItem(context, Icons.video_call_outlined, "Conduct Meeting", "/meetingSchedule", tdpGreen),
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
