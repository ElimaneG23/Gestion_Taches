import 'package:flutter/material.dart';
import 'package:gestion_taches/monfullwidget.dart';

class EnCoursPage extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onDelete;

  const EnCoursPage({super.key, required this.tasks, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tâches en cours'),
        backgroundColor: Colors.green,
      ),
      body: tasks.isEmpty
          ? const Center(
        child: Text('Aucune tâche en cours', style: TextStyle(color: Colors.grey)),
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
              leading: const Icon(Icons.play_circle_fill, color: Colors.green),
              title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(task.status),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: () => onDelete(task),
              ),
            ),
          );
        },
      ),
    );
  }
}
