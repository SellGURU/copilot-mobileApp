import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/widgets/Tasks/TaskWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class Tasks extends StatefulWidget{
  const Tasks({super.key});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  List<String> taskTypes = ['Check-In', 'Questionary', 'Habits'];
  List<Map<String, dynamic>> tasks = [
    { "id": 1, "title": "Daily Check in", "type": "Check-In", "completed": false },
    { "id": 2, "title": "Profile Data", "type": "Questionary", "completed": true },
    { "id": 2, "title": "Stability, Mobility", "type": "Questionary", "completed": true },
    { "id": 3, "title": "Drink the water", "type": "Habits", "completed": false },
    { "id": 3, "title": "Walk", "type": "Habits", "completed": false },
    { "id": 3, "title": "Meditate", "type": "Habits", "completed": false }
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tasks",style: AppTextStyles.title1,),
            Text("1/6 Completed",style: AppTextStyles.hintSmale,),
          ],
        ),
        Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          margin: EdgeInsets.only(top:8), // Adds top margin
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(3, 0), // changes position of shadow
                ),
            ],
          ),
          child: Column(
            children: List.generate(3, (index) => 
              Padding(
                padding: const EdgeInsets.only(bottom: 10), // Adds gap of 10 pixels
                child: TaskWrapper(typeName: taskTypes[index],tasks: tasks.where((task) => task['type'] == taskTypes[index]).toList(),),
              ),
            ),
          ),
        )
      ],
    );
  }
}