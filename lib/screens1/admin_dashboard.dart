

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gramvikas/screens1/adm_deal_detail_screen.dart';
import 'package:gramvikas/screens1/adm_public_bottom_nav_bar.dart'; // Adjust the import path accordingly
import 'package:gramvikas/screens1/adm_FeedbackDetailScreen.dart'; // Adjust the import path accordingly
import 'package:gramvikas/screens1/adm_menu_screen.dart';
import 'package:gramvikas/screens1/adm_ProofDetailScreen.dart';
import 'package:gramvikas/screens1/adm_AllCompletedProjectsScreen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);


  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}
void showMenuSidebar(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.3), // Optional dim background
    barrierDismissible: true, // ✅ Enables tap outside to close
    builder: (BuildContext context) {
      return const adm_MenuScreen(); // Your sidebar widget
    },
  );
}


class _AdminDashboardState extends State<AdminDashboard> {
  final PageController _pageController = PageController();
  final List<String> completedProjects = [
    'Water Supply Restoration',
    'Road Repair - Sector 3',
    'Community Park Cleanup',
  ];

  int _currentPage = 0;
  late Timer _timer;
  int _selectedIndex = 0;

  final List<String> imagePaths = [
    'assets/banner1.jpg',
    'assets/banner2.jpg',
    'assets/banner3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/AdminDashboard'); // Make sure route exists
        break;
      case 1:
        Navigator.pushNamed(context, '/meetingSchedule'); // Make sure route exists
        break;
      case 2:
        Navigator.pushNamed(context, '/newsUpdate'); // Replace with your Report screen route
        break;
      case 3:
        Navigator.pushNamed(context, '/viewPosts'); // Replace with your Report screen route
        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showMenuSidebar(context); // Open half-screen sidebar
                        },
                        child: const Icon(Icons.menu, size: 28, color: Colors.white),
                      ),

                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/adm_profile'); // Navigate to profile
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/user.png'),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none, size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, '/adm_notifications'); // Notifications screen
                    },
                  ),
                ],
              ),

            ),

            // Auto-Scrolling Banner
            // Auto-Scrolling Banner with Dots
            Column(
              children: [
                SizedBox(
                  height: 250, // Increased height
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imagePaths.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(imagePaths[index]),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: Colors.green[800]!),
                        ),
                      );
                    },
                  ),
                ),

                // Dot Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imagePaths.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index ? Colors.green[800] : Colors.green[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ],
            ),


            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Development Activities Section
                    const SizedBox(height: 10),
                    // Development Activities Section
                    Text(
                      "Report Pending  List",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => adm_DealDetailScreen(dealId: index + 1),
                                ),
                              );
                            },
                            child: Container(
                              width: 160,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: Colors.yellow[100],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.green[800]!),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

// Bottom-right 'View All' button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/adm_allActivities');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[800],
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'View All',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),



                    const SizedBox(height: 0),
                    // Village Place Section
                    Text(
                      "village Place",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: const DecorationImage(
                          image: AssetImage('assets/featured.jpg'),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.green[800]!),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 12,
                            right: 12,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[800],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                // Handle select action here
                              },
                              child: const Text(
                                'Select',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

// "What's New?" Section Title
                    Text(
                      "What's New?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 10),

// Auto-scrolling "What's New?" Horizontal List
                    SizedBox(
                      height: 160,
                      child: PageView.builder(
                        itemCount: 5, // You can change this to your actual item count
                        controller: PageController(viewportFraction: 0.9),
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index) {
                          // Optional: handle page change if needed
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.green[800]!),
                              image: const DecorationImage(
                                image: AssetImage('assets/banner1.jpg'), // Replace with dynamic image
                                fit: BoxFit.cover,
                              ),
                            ),

                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

// Upcoming Meetings Section Title
                    Text(
                      "Upcoming Meetings",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 10),

// Horizontal Scrollable Meeting Cards
                    SizedBox(
                      height: 130,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5, // Replace with your actual meeting count
                        itemBuilder: (context, index) {
                          return Container(
                            width: 240,
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green[800]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Meeting ${index + 1}", // Replace with meeting title
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[900],
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Date: 12 June 2025", // Replace with dynamic data
                                  style: TextStyle(fontSize: 13, color: Colors.green[700]),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Time: 10:00 AM", // Replace with dynamic data
                                  style: TextStyle(fontSize: 13, color: Colors.green[700]),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Location: Hall A", // Replace with dynamic data
                                  style: TextStyle(fontSize: 13, color: Colors.green[700]),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

// Feedback History Section Title
                    Text(
                      "Review Completed",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 10),

// Vertical List of Feedback Cards
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => adm_FeedbackDetailScreen(
                                  title: "Feedback ${index + 1}",
                                  date: "25 May 2025",
                                  description:"ggg",
                                  category:"hhh",// Replace with real date if available
                                  status: "rejected",
                                    image:"gg",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green[800]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Feedback ${index + 1}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.green[900],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Date: 25 May 2025",
                                  style: TextStyle(fontSize: 13, color: Colors.green[700]),
                                ),
                                Text(
                                  "status:completed",
                                  style: TextStyle(fontSize: 13, color: Colors.green[700]),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Comment: Very informative session on water conservation.",
                                  style: TextStyle(fontSize: 14, color: Colors.green[800]),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

// "View All History" Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/adm_feedbackHistory');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[800],
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'View All History',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

// Officer Contacts Section
                    const SizedBox(height: 32),
                    Text(
                      'Project Completed Proofs',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
                    ),
                    const SizedBox(height: 12),

// List of proof cards (only first 2 shown for preview)
                    ...completedProjects.take(2).map((project) {
                      return Card(
                        color: Colors.yellow[100],
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          title: Text(
                            project,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32), // This is equivalent to Colors.green[800]
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => adm_ProofDetailScreen(title: project),
                              ),
                            );
                          },
                        ),
                      );


                    }).toList(),

// View All Button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => adm_AllCompletedProjectsScreen(projects: completedProjects),
                          ),
                        );
                      },
                      child: const Text('View All', style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold)),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: adm_PublicBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
