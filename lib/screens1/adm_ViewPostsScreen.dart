import 'package:flutter/material.dart';
import 'package:gramvikas/screens1/adm_menu_screen.dart'; // import your menu screen
import 'package:gramvikas/screens1/adm_public_bottom_nav_bar.dart'; // Adjust the import path accordingly

class ViewPostsScreen extends StatefulWidget {
  const ViewPostsScreen({super.key});

  @override
  State<ViewPostsScreen> createState() => _ViewPostsScreenState();
}

class _ViewPostsScreenState extends State<ViewPostsScreen> {
  int _selectedIndex = 3; // Default to View Posts tab

  void showMenuSidebar(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const adm_MenuScreen(); // Your actual sidebar widget
      },
    );
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // Avoid redundant navigation

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/adminDashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/meetingSchedule');
        break;
      case 2:
        Navigator.pushNamed(context, '/newsUpdate');
        break;
      case 3:
        Navigator.pushNamed(context, '/viewPosts');
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
          // Top: Name and location row
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
                    Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'location',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Middle: Image placeholder
          Container(
            height: 120,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.yellow[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(
                Icons.broken_image_outlined,
                size: 48,
                color: Colors.black38,
              ),
            ),
          ),

          // Bottom: Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      // TODO: Handle Like action
                    },
                    icon: const Icon(Icons.favorite_border, color: Colors.black),
                    label: const Text('Like', style: TextStyle(color: Colors.black)),
                  ),
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      // TODO: Handle Dislike action
                    },
                    icon: const Icon(Icons.favorite_border, color: Colors.black),
                    label: const Text('Dislike', style: TextStyle(color: Colors.black)),
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
                  // Left side: Menu icon + Profile avatar
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => showMenuSidebar(context),
                        child: const Icon(Icons.menu, size: 28, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/adm_profile');
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

                  // Right side: Notification icon
                  IconButton(
                    icon: const Icon(Icons.notifications_none, size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/adm_notifications');
                    },
                  ),
                ],
              ),
            ),

            // Body content: List of posts
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                itemCount: 5, // Example: 5 post cards
                itemBuilder: (context, index) {
                  return buildPostCard();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: adm_PublicBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
