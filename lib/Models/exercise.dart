class Exercise {
  String name;
  int sets;
  int reps;
  double weight;
  String notes;
  bool done;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
    this.notes = "",
    this.done = false,
  });
}
