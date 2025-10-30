import 'package:flutter/material.dart';
import 'public_bottom_nav_bar.dart'; // Adjust path as needed
import 'package:gramvikas/screens/menu_screen.dart';

class View_PostsScreen extends StatefulWidget {
  const View_PostsScreen({super.key});

  @override
  State<View_PostsScreen> createState() => _View_PostsScreenState();
}

class _View_PostsScreenState extends State<View_PostsScreen> {
  int _selectedIndex = 1; // View Posts tab index

  void showMenuSidebar(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const MenuScreen(); // Sidebar widget
      },
    );
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/publicDashboard');
        break;
      case 1:
      // Already on View Posts
        break;
      case 2:
        Navigator.pushNamed(context, '/feedbackHistory');
        break;
      case 3:
        Navigator.pushNamed(context, '/report');
        break;
    }
  }

  Widget buildPostCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Colors.yellow[200],
            ),
            child: Row(
              children: [
                const Icon(Icons.account_circle_outlined, size: 20),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Location',
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                  ],
                )
              ],
            ),
          ),

          // Image Placeholder
          Container(
            height: 120,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.yellow[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.broken_image_outlined,
                  size: 48, color: Colors.black38),
            ),
          ),

          // Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      // TODO: Like logic
                    },
                    icon: const Icon(Icons.thumb_up, color: Colors.black),
                    label: const Text('Like',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      // TODO: Dislike logic
                    },
                    icon: const Icon(Icons.thumb_down, color: Colors.black),
                    label: const Text('Dislike',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/resolvedScreen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Resolved'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: SafeArea(
        child: Column(
          children: [
            // Top header
            Container(
              height: 120,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.yellow[800],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left: Menu + Avatar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => showMenuSidebar(context),
                        child:
                        const Icon(Icons.menu, size: 28, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                      ),
                    ],
                  ),

                  // Center: Title
                  const Text(
                    'View Posts',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Right: Notification
                  IconButton(
                    icon: const Icon(Icons.notifications_none,
                        size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  ),
                ],
              ),
            ),

            // Posts List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: 5, // Can be dynamic
                itemBuilder: (context, index) {
                  return buildPostCard();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PublicBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
