import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:workout/data/workout_data.dart';
import 'package:workout/models/workout.dart';
import 'package:workout/pages/home_page.dart';

void main()async{
  await Hive.initFlutter();
  await Hive.openBox("workout_database1");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> WorkoutData(),
    child: const MaterialApp(
      home: Home_page(),
    ),
    );
  }
}

