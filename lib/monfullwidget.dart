import 'package:flutter/material.dart';

class Monfullwidget extends StatefulWidget {
  const Monfullwidget({super.key});

  @override
  State<Monfullwidget> createState() => _MonfullwidgetState();
}

// Classe pour représenter une tâche
class Task {
  String title;
  String status;
  Task({required this.title, required this.status});
}

class _MonfullwidgetState extends State<Monfullwidget> {
  // Liste de tâches
  List<Task> tasks = [];
  // Contrôleur pour le champ de texte
  final TextEditingController _controller = TextEditingController();

  // 👉 Méthode pour ajouter une tâche
  void _addTask(String status) {
    if (_controller.text.isEmpty) return;
    setState(() {
      tasks.add(Task(title: _controller.text, status: status));
      _controller.clear();
    });
  }

  // 👉 Fenêtre d’ajout d’une tâche
  void _showAddTaskDialog(String status) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Ajouter une tâche'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Titre de la tâche',
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTask(status);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  // 👇 Interface principale
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion de Tâches'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),

      // 🧭 Menu latéral
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurpleAccent, Colors.purple],
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.task),
              title: const Text('Tâches'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Paramètres'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // 🧱 Corps principal
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenue dans le Dashboard',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),

            // 👉 Ligne des trois cartes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 🔹 Seul ce bouton fonctionne (ajout de tâche)
                _buildDashboardCard(
                  title: 'Ajouter',
                  icon: Icons.add_circle_outline,
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  onTap: () => _showAddTaskDialog('En cours'),
                ),
                // 🔸 Ces deux sont juste visuels
                _buildDashboardCard(
                  title: 'En cours',
                  icon: Icons.play_circle_fill,
                  colors: [Colors.green, Colors.lightGreenAccent],
                  onTap: () {}, // aucune action
                ),
                _buildDashboardCard(
                  title: 'Expiré',
                  icon: Icons.timer_off,
                  colors: [Colors.red, Colors.orangeAccent],
                  onTap: () {}, // aucune action
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Dernières tâches',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            // 👉 Liste des tâches
            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                child: Text(
                  'Aucune tâche pour le moment',
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: const Icon(Icons.task_alt,
                          color: Colors.deepPurple),
                      title: Text(task.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                      subtitle: Text(task.status),
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

  // 🔹 Widget pour créer les petites cartes du haut
  Widget _buildDashboardCard({
    required String title,
    required IconData icon,
    required List<Color> colors,
    required VoidCallback onTap,
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
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
