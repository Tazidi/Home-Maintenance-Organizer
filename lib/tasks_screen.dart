import 'package:flutter/material.dart';
import 'package:uts/styles.dart'
    as styles; // Assuming the colors are in this file.

class Task {
  String title;
  String category;
  bool isCompleted;
  DateTime? dueDate;

  Task({
    required this.title,
    required this.category,
    this.isCompleted = false,
    this.dueDate,
  });
}

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<Task> tasks = [
    Task(title: 'Membersihkan AC', category: 'Pemeliharaan Elektrik'),
    Task(title: 'Mengecek Pipa', category: 'Perbaikan Rumah'),
    Task(title: 'Mengganti Filter', category: 'Kebersihan'),
  ];

  String selectedCategory = 'Semua';
  final List<String> categories = [
    'Semua',
    'Kebersihan',
    'Pemeliharaan Elektrik',
    'Perbaikan Rumah'
  ];

  List<Task> get filteredTasks {
    if (selectedCategory == 'Semua') {
      return tasks;
    }
    return tasks.where((task) => task.category == selectedCategory).toList();
  }

  void _selectDate(Task task) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: task.dueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != task.dueDate) {
      setState(() {
        task.dueDate = picked;
      });
    }
  }

  void _addTask() {
    final titleController = TextEditingController();
    String? selectedNewCategory =
        categories[1]; // default to first category after "Semua"

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Tugas Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Nama Tugas'),
            ),
            DropdownButtonFormField<String>(
              value: selectedNewCategory,
              onChanged: (value) {
                selectedNewCategory = value;
              },
              items: categories.where((c) => c != 'Semua').map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  selectedNewCategory != null) {
                setState(() {
                  tasks.add(Task(
                      title: titleController.text,
                      category: selectedNewCategory!));
                });
                Navigator.of(context).pop();
              }
            },
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas Perawatan Rumah'),
        backgroundColor: styles.AppColors.oliveGray, // Set AppBar to oliveGray
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              style: TextStyle(
                  color: styles.AppColors.darkOlive), // DarkOlive text color
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (context, index) {
                final task = filteredTasks[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: styles
                      .AppColors.warmSand, // Use warmSand for card background
                  child: ListTile(
                    leading: Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          task.isCompleted = value ?? false;
                        });
                      },
                    ),
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.bold,
                        color: styles.AppColors.darkOlive, // Text color
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.category,
                          style: TextStyle(
                              color: styles
                                  .AppColors.darkOlive), // DarkOlive color
                        ),
                        Text(
                          task.dueDate != null
                              ? 'Tenggat: ${task.dueDate!.toLocal().toString().split(' ')[0]}'
                              : 'Tidak ada tenggat',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.calendar_today,
                              color: styles
                                  .AppColors.darkOlive), // DarkOlive color
                          onPressed: () => _selectDate(task),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete,
                              color: styles
                                  .AppColors.darkOlive), // DarkOlive color
                          onPressed: () => _deleteTask(task),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor:
            styles.AppColors.oliveGray, // OliveGray color for the FAB
        child: const Icon(Icons.add,
            color: styles.AppColors.white), // White icon color
      ),
    );
  }
}
