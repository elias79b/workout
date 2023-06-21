import 'package:flutter/material.dart';
import 'package:workout/components/exercise_tile.dart';
import 'package:workout/data/workout_data.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  final String workoutName;

  const WorkoutPage({Key? key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  ///
  ///
  ///
  final exerciseNameController = TextEditingController();
  final wightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void creatNewExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add a new exercise"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: exerciseNameController,
                  ),
                  TextField(
                    controller: wightController,
                  ),
                  TextField(
                    controller: repsController,
                  ),
                  TextField(
                    controller: setsController,
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    save();
                  },
                  child: Text("save"),
                ),
                MaterialButton(
                  onPressed: () {
                    cancel();
                  },
                  child: Text("cancel"),
                ),
              ],
            ));
  }

  void goToWorkoutPage(String workoutName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WorkoutPage(workoutName: workoutName)));
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    String newExercisewight = wightController.text;
    String newExercisereps = repsController.text;
    String newExercisesets = setsController.text;
    Provider.of<WorkoutData>(context, listen: false).addExercise(
        widget.workoutName,
        newExerciseName,
        newExercisewight,
        newExercisereps,
        newExercisesets);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
  }

  void clear() {
    exerciseNameController.clear();
    wightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
        builder: (context, value, child) => Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  creatNewExercise();
                },
                child: IconButton(
                    onPressed: () {
                      creatNewExercise();
                    },
                    icon: Icon(Icons.add)),
              ),
              appBar: AppBar(
                title: Text(widget.workoutName),
              ),
              body: ListView.builder(
                  itemCount:
                      value.numberOfExercisesInWorkout(widget.workoutName),
                  itemBuilder: (context, index) => ExerciseTile(
                        exerciseName: value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .name,
                        weghit: value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .weight,
                        reps: value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .reps,
                        sets: value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .sets,
                        isCompleted: value
                            .getRelevantWorkout(widget.workoutName)
                            .exercises[index]
                            .isCompleted,
                        onCheckBoxChanged: (val) {
                          onCheckBoxChanged(
                            widget.workoutName,
                            value
                                .getRelevantWorkout(widget.workoutName)
                                .exercises[index]
                                .name,
                          );
                        },
                      )),
            ));
  }
}
