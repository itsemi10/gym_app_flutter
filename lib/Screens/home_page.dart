import 'package:flutter/material.dart';
import '../models/routine.dart' as model;
import '../widgets/routine_card.dart';
import 'routine_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<model.Routine> routines = [];

  void addRoutine(String name, String day) {
    setState(() {
      routines.add(model.Routine(name: name, day: day));
    });
  }

  void showDialogAdd() {
    TextEditingController name = TextEditingController();
    String selectedDay = "Lunes";

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Nueva rutina"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: name, decoration: InputDecoration(hintText: "Nombre")),
            DropdownButton<String>(
              value: selectedDay,
              items: ["Lunes","Martes","Miércoles","Jueves","Viernes","Sábado","Domingo"]
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (val) {
                selectedDay = val!;
              },
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (name.text.isNotEmpty) {
                addRoutine(name.text, selectedDay);
              }
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
    return Scaffold(
      appBar: AppBar(title: Text("Gym Pro 💜")),
      body: routines.isEmpty
          ? Center(child: Text("No hay rutinas aún 💀"))
          : ListView.builder(
        itemCount: routines.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => RoutinePage(routine: routines[i]),
            ),
          ),
          child: RoutineCard(routine: routines[i]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showDialogAdd,
        child: Icon(Icons.add),
      ),
    );
  }
}
