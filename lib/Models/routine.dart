import 'exercise.dart';

class Routine {
  String name;
  String day;
  List<Exercise> exercises;

  Routine({
    required this.name,
    required this.day,
  }) : exercises = [];
}
