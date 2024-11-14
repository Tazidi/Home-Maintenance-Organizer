import 'package:flutter/material.dart';
import 'package:uts/styles.dart' as styles;

class SuhuScreen extends StatefulWidget {
  const SuhuScreen({super.key});

  @override
  _SuhuScreenState createState() => _SuhuScreenState();
}

class _SuhuScreenState extends State<SuhuScreen> {
  final TextEditingController _controller = TextEditingController();
  double? _result;
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';

  // Function to convert temperature
  void _convertTemperature() {
    setState(() {
      double input = double.tryParse(_controller.text) ?? 0.0;

      if (_fromUnit == _toUnit) {
        _result = input; // If the units are the same, result is the same
      } else if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
        _result = (input * 9 / 5) + 32;
      } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
        _result = input + 273.15;
      } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
        _result = (input - 32) * 5 / 9;
      } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Kelvin') {
        _result = (input - 32) * 5 / 9 + 273.15;
      } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
        _result = input - 273.15;
      } else if (_fromUnit == 'Kelvin' && _toUnit == 'Fahrenheit') {
        _result = (input - 273.15) * 9 / 5 + 32;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Suhu'),
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
              "Konversi Suhu",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: styles.AppColors.darkOlive,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Suhu',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon:
                    Icon(Icons.thermostat, color: styles.AppColors.oliveGray),
                filled: true,
                fillColor: styles.AppColors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  items: const [
                    DropdownMenuItem(
                      value: 'Celsius',
                      child: Text('Celsius'),
                    ),
                    DropdownMenuItem(
                      value: 'Fahrenheit',
                      child: Text('Fahrenheit'),
                    ),
                    DropdownMenuItem(
                      value: 'Kelvin',
                      child: Text('Kelvin'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _fromUnit = value!;
                    });
                  },
                ),
                const SizedBox(width: 20),
                const Text('to'),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: _toUnit,
                  items: const [
                    DropdownMenuItem(
                      value: 'Celsius',
                      child: Text('Celsius'),
                    ),
                    DropdownMenuItem(
                      value: 'Fahrenheit',
                      child: Text('Fahrenheit'),
                    ),
                    DropdownMenuItem(
                      value: 'Kelvin',
                      child: Text('Kelvin'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _toUnit = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: styles.AppColors.oliveGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                "Konversi",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: styles.AppColors.white),
              ),
            ),
            const SizedBox(height: 20),
            if (_result != null)
              Card(
                color: styles.AppColors.warmSand,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Hasil: ${_result!.toStringAsFixed(2)} $_toUnit',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: styles.AppColors.oliveGray,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
