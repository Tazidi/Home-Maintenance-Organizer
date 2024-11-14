import 'package:flutter/material.dart';
import 'package:uts/styles.dart';
import 'package:uts/tasks_screen.dart';
import 'package:uts/calculator_menu.dart';
import 'package:uts/expenses_screen.dart';
import 'package:uts/settings_screen.dart';

class DashboardScreen extends StatefulWidget {
  final String email;
  final String password;

  const DashboardScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, ${widget.email}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
      const TasksScreen(),
      const ExpensesScreen(),
    ];
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '152022047 - Rizki Tazidi Zayd',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.darkOlive,
        iconTheme: IconThemeData(color: AppColors.warmSand),
      ),
      body: Center(
        child: _pages[_selectedIndex],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.oliveGray,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Drawer Header with Username and Password
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.darkOlive,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username: ${widget.email}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Password: ${widget.password}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // ListTile for Calculator
            ListTile(
              leading:
                  Icon(Icons.calculate_outlined, color: AppColors.warmSand),
              title: Text(
                'Calculator',
                style: TextStyle(
                  color: AppColors.warmSand,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CalculatorMenuScreen()),
                );
              },
            ),
            // ListTile for Settings
            ListTile(
              leading: Icon(Icons.settings_outlined, color: AppColors.warmSand),
              title: Text(
                'Settings',
                style: TextStyle(
                  color: AppColors.warmSand,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          navigationBarTheme: NavigationBarThemeData(
            indicatorColor: AppColors.warmSand.withOpacity(0.2),
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(
                color: AppColors.warmSand,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconTheme: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return IconThemeData(color: AppColors.warmSand);
              }
              return IconThemeData(color: AppColors.grey);
            }),
          ),
        ),
        child: NavigationBar(
          backgroundColor: AppColors.oliveGray,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.task_alt_outlined),
              selectedIcon: Icon(Icons.task_alt),
              label: 'Tasks',
            ),
            NavigationDestination(
              icon: Icon(Icons.attach_money_outlined),
              selectedIcon: Icon(Icons.attach_money),
              label: 'Expenses',
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onDestinationSelected,
        ),
      ),
    );
  }
}
