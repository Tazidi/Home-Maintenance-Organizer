import 'package:flutter/material.dart';
import 'package:uts/styles.dart' as styles;

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmi = 0.0;
  String _result = "";

  void _calculateBMI() {
    final double? height = double.tryParse(_heightController.text);
    final double? weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _result = "Please enter valid values";
        _bmi = 0.0;
      });
      return;
    }

    setState(() {
      _bmi = weight / ((height / 100) * (height / 100));
      if (_bmi < 18.5) {
        _result = "Underweight";
      } else if (_bmi >= 18.5 && _bmi < 24.9) {
        _result = "Normal weight";
      } else if (_bmi >= 25 && _bmi < 29.9) {
        _result = "Overweight";
      } else {
        _result = "Obesity";
      }
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        backgroundColor: styles.AppColors.oliveGray,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [styles.AppColors.ivory, styles.AppColors.lightPink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Calculate Your BMI",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: styles.AppColors.darkOlive,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Height (cm)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon:
                    Icon(Icons.height, color: styles.AppColors.oliveGray),
                filled: true,
                fillColor: styles.AppColors.white,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon: Icon(Icons.fitness_center,
                    color: styles.AppColors.oliveGray),
                filled: true,
                fillColor: styles.AppColors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: styles.AppColors.oliveGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                "Calculate BMI",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: styles.AppColors.white),
              ),
            ),
            const SizedBox(height: 20),
            if (_bmi != 0)
              Card(
                color: styles.AppColors.warmSand,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "BMI: ${_bmi.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: styles.AppColors.oliveGray,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _result,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: _bmi < 18.5
                              ? Colors.blue // Underweight - Blue color
                              : _bmi < 24.9
                                  ? Colors.green // Normal weight - Green color
                                  : _bmi < 29.9
                                      ? Colors
                                          .orange // Overweight - Orange color
                                      : Colors.red, // Obesity - Red color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
