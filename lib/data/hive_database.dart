import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:workout/data/workout_data.dart';
import 'package:workout/datetime/date_time.dart';
import 'package:workout/models/exercise.dart';
import 'package:workout/models/workout.dart';

class HiveDatabase {
  final _myBox = Hive.box("workout_database1");

  bool previousDataExists() {
    if (_myBox.isEmpty) {
      print("previous data does Not exist");
      _myBox.put("START_DATE", todayDateYYYMMDD());
      return false;
    } else {
      print("previous data does does exist");
      return true;
    }
  }

  String getStartDate() {
    return _myBox.get("START_DATE");
  }

  void saveToDatabase(List<Workout> workout) {
    final workoutList = convertoObjecttoWorkoutList(workout);
    final exerciseList = convertObjectToExerciseList(workout);

    if (exerciseCompleted(workout)) {
      _myBox.put("COMPLETION_STATUS_${todayDateYYYMMDD()}", 1);
    } else {
      _myBox.put("COMPLETION_STATUS_${todayDateYYYMMDD()}", 0);
    }
    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);

    ///
    ///
  }

  List<Workout> readFormDatabase() {
    List<Workout> mySavedWorkouts = [];
    List<String> workoutNames = _myBox.get("WORKOUTS");
    final exercisesDetails = _myBox.get("EXERCISES");
    for (int i = 0; i < workoutNames.length; i++) {
      List<Exercise> exercisesInEachWorkout = [];
      for (int j = 0; j < exercisesDetails[i].lenght; j++) {
        exercisesInEachWorkout.add(
          Exercise(
            name: exercisesDetails[i][j][0],
            weight: exercisesDetails[i][j][1],
            reps: exercisesDetails[i][j][2],
            sets: exercisesDetails[i][j][3],
            isCompleted: exercisesDetails[i][j][4] == "true" ? true : false,
          ),
        );
      }
      Workout workout =
          Workout(name: workoutNames[i], exercises: exercisesInEachWorkout);
      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts;
  }

  bool exerciseCompleted(List<Workout> workouts) {
    for (var workout in workouts) {
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  int getCompletionStatus(String yyyymmdd){
    int completionStatus = _myBox.get("COMPLETION_STATUS_" + yyyymmdd) ?? 0;
    return completionStatus;
  }
}

List<String> convertoObjecttoWorkoutList(List<Workout> workouts) {
  List<String> workList = [

  ];

  for (int i = 0; i < workouts.length; i++) {
    workList.add(
      workouts[i].name,
    );
  }
  return workList;
}

List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];
  for (int i = 0; i < workouts.length; i++) {
    List<Exercise> exercisesInWorkout = workouts[i].exercises;
    List<List<String>> individualWorkout = [];
    for (int j = 0; j < exercisesInWorkout.length; j++) {
      List<String> individualExercise = [];

      individualExercise.addAll([
        exercisesInWorkout[j].name,
        exercisesInWorkout[j].weight,
        exercisesInWorkout[j].reps,
        exercisesInWorkout[j].sets,
        exercisesInWorkout[j].isCompleted.toString(),
      ]);
      individualWorkout.add(individualExercise);
    }
    return exerciseList;
  }
}
