import 'package:flutter/material.dart';
import 'package:gestion_taches/monfullwidget.dart';
class ExpirePage extends StatelessWidget {
  final List<Task> tasks;

  const ExpirePage({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tâches expirées'),
        backgroundColor: Colors.redAccent,
      ),
      body: tasks.isEmpty
          ? const Center(
        child: Text('Aucune tâche expirée', style: TextStyle(color: Colors.grey)),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: const Icon(Icons.timer_off, color: Colors.redAccent),
              title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(task.status),
            ),
          );
        },
      ),
    );
  }
}
