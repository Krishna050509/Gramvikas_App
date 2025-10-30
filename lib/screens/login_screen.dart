import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedRole;

  void _handleLogin() {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a role.")),
      );
      return;
    }

    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all login details.")),
      );
      return;
    }

    // Username format check
    if (_selectedRole == 'Admin' && !RegExp(r'^govadm\w{3,}\d{2}$').hasMatch(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Admin usernames must follow format: govadmXXX88")),
      );
      return;
    }

    if (_selectedRole == 'Public' && !RegExp(r'^pub\w{3,}\d{3}$').hasMatch(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Public usernames must follow format: pubXXX999")),
      );
      return;
    }

    // Simulated successful login (in real apps, add authentication and storage)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged in as $_selectedRole')),
    );

    // Navigate to dashboards
    if (_selectedRole == 'Admin') {
      Navigator.pushNamed(context, '/adminDashboard');
    } else {
      Navigator.pushNamed(context, '/publicDashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          },
        ),

        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 90), // Less vertical padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo Image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/login_banner.png', // Replace with your actual path
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),

            // Telugu Desam Party text
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Telugu Desam ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[700],
                      ),
                    ),
                    TextSpan(
                      text: 'Party',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Select Role',
                border: OutlineInputBorder(),
              ),
              value: _selectedRole,
              items: ['Admin', 'Public']
                  .map((role) => DropdownMenuItem(
                value: role,
                child: Text(role),
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username or Phone Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                minimumSize: const Size.fromHeight(50),
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: _handleLogin,
            ),
            // Add this below the ElevatedButton.icon for Login inside your Column:

            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');

              },
              child: const Text(
                "Not registered? Register here",
                style: TextStyle(color: Colors.green),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
