import 'package:flutter/material.dart';
import 'package:workout/data/workout_data.dart';
import 'package:provider/provider.dart';
import 'package:workout/pages/WorkoutPage.dart';

class ExerciseTile extends StatefulWidget {
  final String exerciseName;
  final String weghit;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;

   ExerciseTile({super.key,
    required this.exerciseName,
    required this.weghit,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onCheckBoxChanged,

  });

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListTile(
        title: Text(widget.exerciseName),
        subtitle: Row(
          children: [
            Chip(
              label: Text("${widget.weghit}kg"),),
            Chip(
                label: Text("${widget.reps}reps"), ),
            Chip(
              label: Text("${widget.sets}sets"),)

          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted,
          onChanged: (value)=> widget.onCheckBoxChanged!(value),
        ),
      ),
    );
  }
}
