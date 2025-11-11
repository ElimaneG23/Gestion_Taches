import 'package:flutter/material.dart';
import 'package:gestion_taches/monfullwidget.dart';
import 'package:gestion_taches/pages/dashbord_page.dart';
import 'pages/en_cours_page.dart';
import 'pages/expire_page.dart';

void main() {
  runApp(const MonApp());
}

class MonApp extends StatelessWidget {
  const MonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion de Tâches',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardPage(),
        '/en-cours': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return EnCoursPage(tasks: args['tasks'], onDelete: args['onDelete']);
        },
        '/expire': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map;
          return ExpirePage(tasks: args['tasks']);
        },
      },
    );
  }
}
