import 'package:flutter/material.dart';
import '../models/routine.dart';

class RoutineCard extends StatelessWidget {
  final Routine routine;

  const RoutineCard({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.purple.shade900.withOpacity(0.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            routine.name,
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            routine.day,
            style: const TextStyle(color: Colors.purpleAccent),
          ),
        ],
      ),
    );
  }
}
