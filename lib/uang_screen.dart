import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uts/styles.dart' as styles;

class UangScreen extends StatefulWidget {
  const UangScreen({super.key});

  @override
  _UangScreenState createState() => _UangScreenState();
}

class _UangScreenState extends State<UangScreen> {
  final TextEditingController _controller = TextEditingController();
  double? _result;
  String _fromCurrency = 'USD';
  String _toCurrency = 'IDR';

  // Hardcoded conversion rates (example values)
  final Map<String, double> _conversionRates = {
    'USD_IDR': 15000,
    'USD_EUR': 0.85,
    'USD_JPY': 110,
    'USD_KRW': 1300,
    'IDR_USD': 0.000067,
    'IDR_EUR': 0.000057,
    'IDR_JPY': 0.0073,
    'IDR_KRW': 0.086,
    'EUR_USD': 1.18,
    'EUR_IDR': 17600,
    'EUR_JPY': 129,
    'EUR_KRW': 1520,
    'JPY_USD': 0.0091,
    'JPY_IDR': 137,
    'JPY_EUR': 0.0078,
    'JPY_KRW': 11.8,
    'KRW_USD': 0.00077,
    'KRW_IDR': 11.6,
    'KRW_EUR': 0.00066,
    'KRW_JPY': 0.085,
  };

  void _convertCurrency() {
    setState(() {
      double input = double.tryParse(_controller.text) ?? 0.0;
      if (_fromCurrency == _toCurrency) {
        _result = input;
      } else {
        String conversionKey = '${_fromCurrency}_$_toCurrency';
        double rate = _conversionRates[conversionKey] ?? 1.0;
        _result = input * rate;
      }
    });
  }

  String _formatResult(double? result) {
    if (result == null) return '';
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Mata Uang'),
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
              "Konversi Mata Uang",
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
                labelText: 'Masukkan Jumlah Uang',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                prefixIcon:
                    Icon(Icons.attach_money, color: styles.AppColors.oliveGray),
                filled: true,
                fillColor: styles.AppColors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  value: _fromCurrency,
                  items: const [
                    DropdownMenuItem(value: 'USD', child: Text('USD')),
                    DropdownMenuItem(value: 'IDR', child: Text('IDR')),
                    DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                    DropdownMenuItem(value: 'JPY', child: Text('JPY')),
                    DropdownMenuItem(value: 'KRW', child: Text('KRW')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _fromCurrency = value!;
                    });
                  },
                ),
                const SizedBox(width: 20),
                const Text('to'),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: _toCurrency,
                  items: const [
                    DropdownMenuItem(value: 'USD', child: Text('USD')),
                    DropdownMenuItem(value: 'IDR', child: Text('IDR')),
                    DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                    DropdownMenuItem(value: 'JPY', child: Text('JPY')),
                    DropdownMenuItem(value: 'KRW', child: Text('KRW')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _toCurrency = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertCurrency,
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
                    'Hasil: ${_formatResult(_result)} $_toCurrency',
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
