import 'package:flutter/material.dart';

import 'package:todo/presentation/screens/all_tasks.dart';
import 'package:todo/presentation/screens/task_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Мои дела',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Мои дела'),
      //home: const AllTasksScreen(),
      home: const TaskDetailScreen(),
    );
  }
}