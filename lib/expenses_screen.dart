import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package for formatting
import 'calculator_screen.dart'; // Import layar kalkulator
import 'package:uts/styles.dart' as styles;

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final _taskController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  final List<Map<String, dynamic>> _expenses = [];
  double _monthlyTotal = 0.0;
  double _yearlyTotal = 0.0;

  void _pickDate(BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }

  void _addExpense() {
    if (_taskController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedDate == null) return;

    final double amount = double.tryParse(_amountController.text) ?? 0.0;
    final DateTime date = _selectedDate!;

    setState(() {
      _expenses.add({
        'task': _taskController.text,
        'amount': amount,
        'date': date,
      });
      _taskController.clear();
      _amountController.clear();
      _selectedDate = null;
      _calculateTotals();
    });
  }

  void _calculateTotals() {
    double monthlyTotal = 0.0;
    double yearlyTotal = 0.0;

    for (var expense in _expenses) {
      final DateTime date = expense['date'];
      final double amount = expense['amount'];

      if (date.month == DateTime.now().month &&
          date.year == DateTime.now().year) {
        monthlyTotal += amount;
      }

      if (date.year == DateTime.now().year) {
        yearlyTotal += amount;
      }
    }

    setState(() {
      _monthlyTotal = monthlyTotal;
      _yearlyTotal = yearlyTotal;
    });
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat('#,##0.00', 'id_ID'); // Using IDR formatting
    return formatter.format(amount);
  }

  void _navigateToCalculator() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CalculatorScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengeluaran'),
        backgroundColor: styles.AppColors.oliveGray,
        actions: [
          IconButton(
            icon: const Icon(Icons.calculate, color: styles.AppColors.warmSand),
            iconSize: 30.0,
            onPressed: _navigateToCalculator,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [styles.AppColors.ivory, styles.AppColors.lightPink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tambah Pengeluaran",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: styles.AppColors.darkOlive,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Nama Tugas',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: styles.AppColors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Rincian Biaya',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: styles.AppColors.white,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Pilih Tanggal'
                        : 'Tanggal: ${DateFormat('dd-MM-yyyy').format(_selectedDate!)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: styles.AppColors.darkOlive,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _pickDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: styles.AppColors.oliveGray,
                    foregroundColor: Colors.white, // Set text color to white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: styles.AppColors.oliveGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text(
                'Tambah Pengeluaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: styles.AppColors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Biaya Bulanan: Rp${_formatCurrency(_monthlyTotal)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Total Biaya Tahunan: Rp${_formatCurrency(_yearlyTotal)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return Card(
                    color: styles.AppColors.warmSand,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        expense['task'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Rp ${_formatCurrency(expense['amount'])} - ${DateFormat('dd-MM-yyyy').format(expense['date'])}',
                        style:
                            const TextStyle(color: styles.AppColors.darkOlive),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
