import 'dart:convert';

import 'package:copilet/components/text_style.dart';
import 'package:copilet/constants/endPoints.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/utility/token/getTokenLocaly.dart';
import 'package:copilet/widgets/Tasks/TaskWrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class Tasks extends StatefulWidget{
  final String title;
  const Tasks({super.key,required this.title});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }
}

class _TasksState extends State<Tasks> {
  List<String> taskTypes = ['Check-In', 'Diet','Activity','Supplement','Lifestyle', 'Questionary'];
  List<Map<String, dynamic>> tasks = [
    // { "id": 1, "title": "Daily Check in", "type": "Check-In", "completed": false },
    // { "id": 2, "title": "Profile Data", "type": "Questionary", "completed": true },
    // { "id": 2, "title": "Stability, Mobility", "type": "Questionary", "completed": true },
    // { "id": 3, "title": "Drink the water", "type": "Habits", "completed": false },
    // { "id": 3, "title": "Walk", "type": "Habits", "completed": false },
    // { "id": 3, "title": "Meditate", "type": "Habits", "completed": false }
  ];
  Dio _dio = Dio();
  
  @override
  void initState() {
    super.initState();
    fetchQuestionary();
  }

  Future<void>  fetchQuestionary() async {
    var token = await getTokenLocally();
    _dio.options.headers['Authorization'] = "bearer $token";
    final response = await _dio.post(widget.title == 'Daily Tasks'? Endpoints.getTodaysTasks:Endpoints.getQuestionary);

    if (response.statusCode == 200) {
      List<dynamic> jsonData =response.data;
     
      if(widget.title == 'Daily Tasks'){
      setState((){
        List<Map<String, dynamic>> modifiedData = jsonData.map((item) {
          if(item['Task_Type'] == 'Checkin'){
            return {
              'id': item['task_id'],
              'title': item['Title'],
              'type': "Check-In",
              'completed': item['Status'] ==true?'Done':'' // Add custom key
            };
          }
          if(item['Task_Type'] == 'Action'){
            if(item['Category'] == 'Diet' || item['Category'] == 'Supplement' || item['Category'] == 'Lifestyle'){
              return {
                'id': item['task_id'],
                'title': item['Title'],
                'type': item['Category'],
                'completed': item['Status'] ==true?'Done':'' // Add custom key
              };
            }
            if(item['Category'] == 'Activity'){
              return {
                'id': item['task_id'],
                'title': item['Title'],
                'type': "Activity",
                'completed': item['Status'] // Add custom key
              };  
            }
          }
          return {
            'id': "",
            'title': "test",
            'type': "Check-In",
            'completed': "Done" // Add custom key
          };
          
        }).toList(); 
        tasks = modifiedData;
        });
      }else {
      setState((){
        List<Map<String, dynamic>> modifiedData = jsonData.map((item) {
          return {
            'id': item['unique_id'],
            'title': item['title'],
            'type': "Questionary",
            'completed': item['status'] // Add custom key
          };
        }).toList(); 
        tasks = modifiedData;
        });

      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  int resolveTasksLength (){
    if(widget.title == 'Daily Tasks'){
      return tasks.where((task) => task['type'] !="Questionary").length;
    }
    return tasks.where((task) => task['type'] =="Questionary").length;
  }
  int resolveCompletedTasksLength (){
    if(widget.title == 'Daily Tasks'){
      return tasks.where((task) => task['type'] !="Questionary" && task["completed"] =='Done').length;
    }
    return tasks.where((task) => task['type'] =="Questionary"  && task["completed"] =='Done').length;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title,style: AppTextStyles.title1,),
            Text(resolveCompletedTasksLength().toString()+"/"+resolveTasksLength().toString()+" Completed",style: AppTextStyles.hintSmale,),
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
          child:widget.title =='Daily Tasks'? Column(
            children: List.generate(5, (index) => 
              Padding(
                padding: const EdgeInsets.only(bottom: 10), // Adds gap of 10 pixels
                child: TaskWrapper(typeName: taskTypes[index],tasks: tasks.where((task) => task['type'] == taskTypes[index]).toList(),),
              ),
            ),
          ): Padding(
                padding: const EdgeInsets.only(bottom: 10), // Adds gap of 10 pixels
                child: TaskWrapper(typeName: taskTypes[5],tasks: tasks.where((task) => task['type'] == taskTypes[5]).toList(),),
              ),
        )
      ],
    );
  }
}