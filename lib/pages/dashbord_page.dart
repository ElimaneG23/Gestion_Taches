import 'package:flutter/material.dart';
import 'package:gestion_taches/monfullwidget.dart';
import 'en_cours_page.dart';
import 'expire_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Task> tasksEnCours = [];
  List<Task> tasksExpirees = [];
  final TextEditingController _controller = TextEditingController();

  // ➕ Ajouter une tâche
  void _addTask() {
    if (_controller.text.isEmpty) return;
    setState(() {
      tasksEnCours.add(Task(title: _controller.text, status: 'En cours'));
      _controller.clear();
    });
  }

  // 🗑️ Supprimer une tâche → Expiré
  void _moveToExpired(Task task) {
    setState(() {
      tasksEnCours.remove(task);
      tasksExpirees.add(Task(title: task.title, status: 'Expiré'));
    });
  }

  // 📋 Fenêtre d’ajout
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Ajouter une tâche'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Titre de la tâche',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Annuler')),
            ElevatedButton(
              onPressed: () {
                _addTask();
                Navigator.pop(context);
              },
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  // 🧱 Interface principale
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion de Tâches'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Bienvenue dans le Dashboard',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDashboardCard(
                  title: 'Ajouter',
                  icon: Icons.add_circle_outline,
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  onTap: _showAddTaskDialog,
                ),
                _buildDashboardCard(
                  title: 'En cours',
                  icon: Icons.play_circle_fill,
                  colors: [Colors.green, Colors.lightGreenAccent],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/en-cours',
                      arguments: {
                        'tasks': tasksEnCours,
                        'onDelete': (Task task) => _moveToExpired(task),
                      },
                    );
                  },
                  count: tasksEnCours.length,
                ),
                _buildDashboardCard(
                  title: 'Expiré',
                  icon: Icons.timer_off,
                  colors: [Colors.red, Colors.orangeAccent],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/expire',
                      arguments: {'tasks': tasksExpirees},
                    );
                  },
                  count: tasksExpirees.length,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Utilisez les icônes ci-dessus pour gérer vos tâches.',
                style: TextStyle(color: Colors.grey[700], fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required List<Color> colors,
    required VoidCallback onTap,
    int count = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 130,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors.last.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
            if (count > 0)
              Text('($count)',
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
