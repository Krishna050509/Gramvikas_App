import 'package:flutter/material.dart';

class MeetingScheduleScreen extends StatefulWidget {
  const MeetingScheduleScreen({super.key});

  @override
  State<MeetingScheduleScreen> createState() => _MeetingScheduleScreenState();
}

class _MeetingScheduleScreenState extends State<MeetingScheduleScreen> {
  final List<Map<String, String>> meetingHistory = [];

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descController = TextEditingController();

  void _addMeeting() {
    if (_dateController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _descController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all fields"),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() {
      meetingHistory.insert(0, {
        'date': _dateController.text,
        'time': _timeController.text,
        'description': _descController.text,
      });
      _dateController.clear();
      _timeController.clear();
      _descController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Meeting Added Successfully"),
      backgroundColor: Colors.green,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final Color green800 = const Color(0xFF006400);

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        title: const Text('Meeting Schedule', style: TextStyle(color: Color(0xFF006400))),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF006400)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Conduct Meeting Section
            Text(
              'Conduct New Meeting',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: green800,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Date (e.g. June 10, 2025)',
                filled: true,
                fillColor: Colors.yellow[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(
                labelText: 'Time (e.g. 2:00 PM - 3:30 PM)',
                filled: true,
                fillColor: Colors.yellow[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.yellow[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton.icon(
                onPressed: _addMeeting,
                icon: const Icon(Icons.add),
                label: const Text("Add Meeting"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: green800,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 24),

            /// Meeting History Section
            Text(
              'Meeting History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: green800,
              ),
            ),
            const SizedBox(height: 10),
            if (meetingHistory.isEmpty)
              const Center(
                child: Text(
                  'No meetings yet',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ...meetingHistory.map((meeting) {
              return Card(
                color: Colors.yellow[100],
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meeting['date'] ?? '',
                        style: TextStyle(
                          color: green800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 18, color: Color(0xFF006400)),
                          const SizedBox(width: 6),
                          Text(meeting['time'] ?? ''),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.description, size: 18, color: Color(0xFF006400)),
                          const SizedBox(width: 6),
                          Expanded(child: Text(meeting['description'] ?? '')),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
