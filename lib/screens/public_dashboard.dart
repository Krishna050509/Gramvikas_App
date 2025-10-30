import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gramvikas/screens/deal_detail_screen.dart';
import 'public_bottom_nav_bar.dart'; // Adjust the import path accordingly
import 'FeedbackDetailScreen.dart'; // Adjust the import path accordingly
import 'package:gramvikas/screens/menu_screen.dart';

class PublicDashboard extends StatefulWidget {
  const PublicDashboard({Key? key}) : super(key: key);

  @override
  State<PublicDashboard> createState() => _PublicDashboardState();
}
void showMenuSidebar(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.3), // Optional dim background
    barrierDismissible: true, // ✅ Enables tap outside to close
    builder: (BuildContext context) {
      return const MenuScreen(); // Your sidebar widget
    },
  );
}


class _PublicDashboardState extends State<PublicDashboard> {
  final PageController _pageController = PageController();
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
        Navigator.pushNamed(context, '/publicDashboard'); // Make sure route exists
        break;
      case 1:
        Navigator.pushNamed(context, '/View_PostsScreen'); // Replace with your Report screen route
        break;
      case 2:
        Navigator.pushNamed(context, '/feedbackHistory'); // Make sure route exists
        break;
      case 3:
        Navigator.pushNamed(context, '/report'); // Replace with your Report screen route
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
                          Navigator.pushNamed(context, '/profile'); // Navigate to profile
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
                      Navigator.pushNamed(context, '/notifications'); // Notifications screen
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
                      "Development Activities Section",
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
                                  builder: (context) => DealDetailScreen(dealId: index + 1),
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
                          Navigator.pushNamed(context, '/allActivities');
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
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    color: Colors.green.withOpacity(0.8),
                                    child: const Text(
                                      "New Update",
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
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
                      "Pening Review",
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
                                builder: (context) => FeedbackDetailScreen(
                                  title: "Feedback ${index + 1}",
                                  date: "25 May 2025", // Replace with real date if available
                                  comment: "Very informative session on water conservation.", // Replace with real comment
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
                          Navigator.pushNamed(context, '/feedbackHistory');
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
                    Text(
                      "Officer Contacts",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    const SizedBox(height: 10),

                    SizedBox(
                      height: 200, // Adjust height based on content
                      child: ListView.builder(
                        itemCount: 5, // Update with actual number of officers
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.yellow[100],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green[800]!),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.account_circle, size: 40, color: Colors.green),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Officer Name',
                                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Contact: +91-1234567890',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.phone, color: Colors.green),
                                  onPressed: () {
                                    // Optional: launch call using url_launcher
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),


                  ],
                ),
              ),
            )
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: PublicBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
