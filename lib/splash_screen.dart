import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman Login

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Menunda perpindahan ke halaman login selama 3 detik
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/splash.png', // Ganti dengan path foto latar belakang
            fit: BoxFit.cover, // Membuat gambar sesuai dengan ukuran layar
          ),
        ],
      ),
    );
  }
}
