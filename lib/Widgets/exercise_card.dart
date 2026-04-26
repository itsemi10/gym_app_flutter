import 'package:flutter/material.dart';
import '../models/exercise.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onTimer;

  ExerciseCard({
    required this.exercise,
    required this.onToggle,
    required this.onDelete,
    required this.onTimer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.purple.shade900.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onToggle,
                child: Icon(
                  exercise.done ? Icons.check_circle : Icons.circle_outlined,
                  color: Colors.purpleAccent,
                ),
              ),
              SizedBox(width: 10),
              Text(
                exercise.name,
                style: TextStyle(
                  decoration:
                  exercise.done ? TextDecoration.lineThrough : null,
                ),
              ),
              Spacer(),
              IconButton(onPressed: onDelete, icon: Icon(Icons.delete))
            ],
          ),
          Text(
            "${exercise.sets} x ${exercise.reps}   •   ${exercise.weight} kg",
            style: TextStyle(color: Colors.purpleAccent),
          ),
          if (exercise.notes.isNotEmpty)
            Text("🧠 ${exercise.notes}"),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: onTimer,
                icon: Icon(Icons.timer),
                label: Text("60s"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

