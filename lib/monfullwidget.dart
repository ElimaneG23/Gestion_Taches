import 'package:flutter/material.dart';

// Définition de la classe Task

class Monfullwidget extends StatefulWidget {
  const Monfullwidget({super.key});

  @override
  State<Monfullwidget> createState() => _MonfullwidgetState();
}
class Task {
  String title;
  String status; // "En cours" ou "Expiré"
  Task({required this.title, required this.status});
}


class _MonfullwidgetState extends State<Monfullwidget> {
  List<Task> tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addTask(String status) {
    if (_controller.text.isEmpty) return;
    setState(() {
      tasks.add(Task(title: _controller.text, status: status));
      _controller.clear();
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void _showAddTaskDialog(String status) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Ajouter une tâche ($status)'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Titre de la tâche',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                _addTask(status);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion de Tâches'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.purple])),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.task),
              title: Text('Tâches'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenue dans le Dashboard',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDashboardCard(
                  title: 'Ajouter',
                  icon: Icons.add_circle_outline,
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  onTap: () => _showAddTaskDialog('En cours'),
                ),
                _buildDashboardCard(
                  title: 'En cours',
                  icon: Icons.play_circle_fill,
                  colors: [Colors.green, Colors.lightGreenAccent],
                  onTap: () {},
                  count: tasks.where((t) => t.status == 'En cours').length,
                ),
                _buildDashboardCard(
                  title: 'Expiré',
                  icon: Icons.timer_off,
                  colors: [Colors.red, Colors.orangeAccent],
                  onTap: () {},
                  count: tasks.where((t) => t.status == 'Expiré').length,
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              'Dernières tâches',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Expanded(
              child: tasks.isEmpty
                  ? Center(
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
                    margin: EdgeInsets.symmetric(vertical: 6),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: Icon(
                        task.status == 'En cours'
                            ? Icons.check_circle
                            : Icons.error,
                        color: task.status == 'En cours'
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(task.title,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(task.status),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.grey[700]),
                        onPressed: () => _deleteTask(index),
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
              color: colors.last.withOpacity(0.5),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Icon(icon, size: 50, color: Colors.white),
                if (count > 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      '$count',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
