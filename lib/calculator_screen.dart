import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:uts/styles.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SimpleCalculator(
          theme: CalculatorThemeData(
            borderColor: AppColors.oliveGray,
            displayColor: Colors.grey[200],
            displayStyle: const TextStyle(fontSize: 24, color: Colors.black),
            operatorColor: AppColors.oliveGray,
            operatorStyle: const TextStyle(fontSize: 20, color: Colors.white),
            commandColor: Colors.grey,
            commandStyle: const TextStyle(fontSize: 18, color: Colors.black),
            numColor: Colors.white,
            numStyle: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
