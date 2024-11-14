import 'package:flutter/material.dart';
import 'package:uts/login_screen.dart';
import 'package:uts/styles.dart'; // Pastikan styles.dart berisi AppColors

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture
            const CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage('assets/images/profil.jpeg'),
            ),
            const SizedBox(height: 16),

            // Name
            const ListTile(
              leading: Icon(Icons.person, color: AppColors.oliveGray),
              title: Text(
                'Rizki Tazidi Zayd',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(),

            // Email
            const ListTile(
              leading: Icon(Icons.email, color: AppColors.oliveGray),
              title: Text(
                'rizki.tazidi@itenas.mhs.ac.id',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(),

            // Phone Number
            const ListTile(
              leading: Icon(Icons.phone, color: AppColors.oliveGray),
              title: Text(
                '+6287728476945',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(),

            // Address
            const ListTile(
              leading: Icon(Icons.home, color: AppColors.oliveGray),
              title: Text(
                'Bandung',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            const Divider(),

            // Logout Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
