import 'package:flutter/material.dart';
import '../models/routine.dart';
import '../models/exercise.dart';
import '../widgets/exercise_card.dart';

class RoutinePage extends StatefulWidget {
  final Routine routine;

  RoutinePage({required this.routine});

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  int timer = 0;

  void startTimer() {
    setState(() => timer = 60);
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (timer > 0) {
        setState(() => timer--);
        return true;
      }
      return false;
    });
  }

  void addExercise(Exercise e) {
    setState(() {
      widget.routine.exercises.add(e);
    });
  }

  void showDialogAdd() {
    TextEditingController name = TextEditingController();
    TextEditingController sets = TextEditingController();
    TextEditingController reps = TextEditingController();
    TextEditingController weight = TextEditingController();
    TextEditingController notes = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Nuevo ejercicio"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: name, decoration: InputDecoration(hintText: "Nombre")),
              TextField(controller: sets, decoration: InputDecoration(hintText: "Series")),
              TextField(controller: reps, decoration: InputDecoration(hintText: "Reps")),
              TextField(controller: weight, decoration: InputDecoration(hintText: "Peso")),
              TextField(
                controller: notes,
                decoration: InputDecoration(hintText: "Notas"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              addExercise(
                Exercise(
                  name: name.text,
                  sets: int.parse(sets.text),
                  reps: int.parse(reps.text),
                  weight: double.parse(weight.text),
                  notes: notes.text,
                ),
              );
              Navigator.pop(context);
            },
            child: Text("Agregar"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int total = widget.routine.exercises.length;
    int done = widget.routine.exercises.where((e) => e.done).length;
    double progress = total == 0 ? 0 : done / total;

    return Scaffold(
      appBar: AppBar(title: Text(widget.routine.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text("$done / $total completados"),
                LinearProgressIndicator(value: progress),
                if (timer > 0)
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Descanso: $timer s",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.routine.exercises.length,
              itemBuilder: (_, i) => ExerciseCard(
                exercise: widget.routine.exercises[i],
                onToggle: () => setState(() => widget.routine.exercises[i].done = !widget.routine.exercises[i].done),
                onDelete: () => setState(() => widget.routine.exercises.removeAt(i)),
                onTimer: startTimer,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showDialogAdd,
        child: Icon(Icons.add),
      ),
    );
  }
}
