import 'package:flutter/material.dart';
import 'package:uts/calculator_screen.dart';
import 'package:uts/bmi_screen.dart';
import 'package:uts/styles.dart';
import 'package:uts/suhu_screen.dart';
import 'package:uts/uang_screen.dart';

class CalculatorMenuScreen extends StatelessWidget {
  const CalculatorMenuScreen({super.key});

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator Menu'),
        backgroundColor:
            Colors.purple[50], // Sesuaikan dengan warna yang diinginkan
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          children: [
            ElevatedButton(
              onPressed: () =>
                  _navigateToScreen(context, const CalculatorScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oliveGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.calculate, size: 40, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Calculator',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _navigateToScreen(context, const BMIScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oliveGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.person, size: 40, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'BMI Calculator',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _navigateToScreen(context, const SuhuScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oliveGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.thermostat, size: 40, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Konversi Suhu',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _navigateToScreen(context, const UangScreen()),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.oliveGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.attach_money, size: 40, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Konversi Mata Uang',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
