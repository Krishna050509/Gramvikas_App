import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';    // Adjust path as needed
import 'screens/public_dashboard.dart';
import 'screens/FeedbackScreen.dart';
import 'screens/ReportScreen1.dart';
import 'screens/ProfileScreen.dart';
import 'screens/menu_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/all_activities_screen.dart';
import 'screens/not_completed.dart';
import 'screens/completed.dart';
import 'screens/view_post.dart';


import 'screens1/admin_dashboard.dart';
import 'screens1/adm_menu_screen.dart';
import 'screens1/adm_ProfileScreen.dart';
import 'screens1/adm_notification_screen.dart';
import 'screens1/adm_all_activities_screen.dart';
import 'screens1/adm_reportHistory.dart';
import 'screens1/adm_FeedbackScreen.dart';
import 'screens1/adm_MeetingScheduleScreen.dart';
import 'screens1/adm_NewsUpdateScreen.dart';
import 'screens1/adm_resolved_screen.dart';
import 'screens1/adm_ViewPostsScreen.dart';
import 'screens1/adm_FeedbackHistoryScreen.dart';
import 'screens1/adm_issued.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      debugShowCheckedModeBanner: false,

      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/publicDashboard': (context) => const PublicDashboard(),
        '/feedback': (context) => const FeedbackScreen(),
        '/report': (context) => const ReportScreens(),
        '/profile': (context) => const ProfileScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/menu': (context) => const MenuScreen(), // optional
        '/allActivities': (context) => const AllActivitiesScreen(),
        '/feedbackHistory': (context) => const FeedbackScreen(),
        '/completed': (context) => const CompletedScreen(),
        '/not_completed': (context) => const NotCompletedScreen(),
        '/View_PostsScreen': (context) => const View_PostsScreen(),


        '/adminDashboard': (context) => const AdminDashboard(),
        '/adm_menu': (context) => const adm_MenuScreen(),
        '/adm_profile': (context) => const adm_ProfileScreen(),
        '/adm_notifications': (context) => const adm_NotificationScreen(),
        '/adm_allActivities': (context) => const adm_AllActivitiesScreen(),
        '/admreportHistory': (context) => const adm_reportHistory(),
        '/adm_feedbackHistory': (context) => const adm_FeedbackScreen(),
        '/meetingSchedule': (context) => MeetingScheduleScreen(),
        '/newsUpdate': (context) => NewsUpdateScreen(),
        '/viewPosts': (context) => ViewPostsScreen(),
        '/resolvedScreen': (context) => const ResolvedScreen(),
        '/feedbackreportHistory': (context) =>  adm_FeedbackHistoryScreen(),
        '/issued': (context) =>  IssuedReportScreen(),






      },
    );
  }
}
