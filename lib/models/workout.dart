import 'package:workout/models/exercise.dart';

class Workout {
  late final String name;
  late final List<Exercise> exercises;

  Workout({required this.name, required this.exercises});
}
