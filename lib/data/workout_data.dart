import 'package:flutter/cupertino.dart';
import 'package:workout/data/hive_database.dart';
import 'package:workout/models/exercise.dart';
import 'package:workout/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();
  List<Workout> WorkoutList = [
    /// default workout
    Workout(
      name: "Upper Body",
      exercises: [
        Exercise(name: "Bicep Curls", weight: "10", reps: "10", sets: "3")
      ],
    )
  ];

  ///
  void initalizeWorkoutList() {
    if(db.previousDataExists()){
      WorkoutList = db.readFormDatabase();
    } else{
      db.saveToDatabase(WorkoutList);
    }
  }

  ///get the list of workout
  List<Workout> getWorkoutList() {
    return WorkoutList;
  }

  ///
  ///get lenght of a given workout
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    return relevantWorkout.exercises.length;
  }

  ///add a workout
  void addWorkout(String name) {
    WorkoutList.add(Workout(name: name, exercises: []));

    notifyListeners();
    db.saveToDatabase(WorkoutList);
  }

  ///add an Exercise to a workout
  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    ///find the relevant workout
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));
    notifyListeners();

    db.saveToDatabase(WorkoutList);
  }

  ///
  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);

    relevantExercise.isCompleted = !relevantExercise.isCompleted;

    notifyListeners();
    db.saveToDatabase(WorkoutList);
  }

  ///
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        WorkoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  ///
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);

    Exercise relrvantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);

    return relrvantExercise;
  }
}
