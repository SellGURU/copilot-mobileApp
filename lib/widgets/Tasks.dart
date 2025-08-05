import 'dart:convert';
import 'dart:async';

import 'package:copilet/components/text_style.dart';
import 'package:copilet/constants/endPoints.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/utility/token/getTokenLocaly.dart';
import 'package:copilet/widgets/EmptyBox.dart';
import 'package:copilet/widgets/Tasks/ActivityTaskWrapper.dart';
import 'package:copilet/widgets/Tasks/TaskWrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class Tasks extends StatefulWidget{
  final String title;
  final List<Map<String, dynamic>>? tasksList; // پراپ اختیاری
  final bool readOnly; // پراپ جدید برای حالت فقط خواندن - اگر true باشد، دکمه‌های اکشن غیرفعال می‌شوند
  const Tasks({super.key,required this.title, this.tasksList, this.readOnly = false});

  @override
  State<Tasks> createState() {
    return _TasksState();
  }

  /// Static method to refresh all Tasks widgets
  static void refreshAllTasks() {
    _TasksState.refreshAllTasks();
  }
}

class _TasksState extends State<Tasks> {
  // Static list to track all Tasks instances
  static final List<_TasksState> _instances = [];
  
  Timer? _timer; // Timer for periodic fetch
  List<String> taskTypes = ['Check-In', 'Diet','Activity','Supplement','Lifestyle', 'Questionnaire'];
  List<Map<String, dynamic>> tasks = [
    // { "id": 1, "title": "Daily Check in", "type": "Check-In", "completed": false },
    // { "id": 2, "title": "Profile Data", "type": "Questionary", "completed": true },
    // { "id": 2, "title": "Stability, Mobility", "type": "Questionary", "completed": true },
    // { "id": 3, "title": "Drink the water", "type": "Habits", "completed": false },
    // { "id": 3, "title": "Walk", "type": "Habits", "completed": false },
    // { "id": 3, "title": "Meditate", "type": "Habits", "completed": false }
  ];
  Dio _dio = Dio();

  // Callback to notify parent when task completion changes
  void _onTaskCompletionChanged() {
    setState(() {
      // Force rebuild to update completion count
    });
  }
  
  @override
  void initState() {
    super.initState();
    _instances.add(this);
    if (widget.tasksList != null) {
      // اگر لیست تسک‌ها از پراپ آمد، تبدیل به فرمت داخلی کن
      if (widget.title == 'Daily Tasks') {
        List<Map<String, dynamic>> modifiedData = widget.tasksList!.map((item) {
          if(item['Task_Type'] == 'Checkin'){
            return {
              'id': item['task_id'],
              'task_id': item['task_id'],
              'title': item['Title'],
              'type': "Check-In",
              'completed': item['Status'] ==true?'Done':''
            };
          }
          if(item['Task_Type'] == 'Action'){
            if(item['Category'] == 'Diet' || item['Category'] == 'Supplement' || item['Category'] == 'Lifestyle'){
              return {
                'id': item['task_id'],
                'task_id': item['task_id'],
                'title': item['Title'],
                'type': item['Category'],
                'completed': item['Status'] ==true?'Done':''
              };
            }
            if(item['Category'] == 'Activity'){
              return {
                'id': item['task_id'],
                'task_id': item['task_id'],
                'title': item['Title'],
                'type': "Activity",
                'Sections': item['Sections'],
                'completed': item['Status'] ==true?'Done':''
              };
            }
          }
          return {
            'id': "",
            'title': "test",
            'task_id': item['task_id'],
            'type': "Check-In",
            'completed': "Done"
          };
        }).toList();
        modifiedData.sort((a, b) => a['id'].toString().compareTo(b['id'].toString()));
        tasks = modifiedData;
      } else {
        List<Map<String, dynamic>> modifiedData = widget.tasksList!.map((item) {
          return {
            'id': item['unique_id'],
            'title': item['title'],
            'type': "Questionnaire",
            'completed':item['Status'] ==true || item['status'] =='Done'?'Done':''
          };
        }).toList();
        modifiedData.sort((a, b) => a['id'].toString().compareTo(b['id'].toString()));
        tasks = modifiedData;
      }
      // تایمر را راه‌اندازی نکن
    } else {
      fetchQuestionary();
      _timer = Timer.periodic(const Duration(seconds: 100), (timer) {
        fetchQuestionary();
      });
    }
  }

  @override
  void dispose() {
    _instances.remove(this);
    _timer?.cancel(); // Cancel timer to avoid memory leaks
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Tasks oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Handle refresh case - when tasksList becomes null or empty
    if (widget.tasksList == null || widget.tasksList!.isEmpty) {
      setState(() {
        tasks.clear();
      });
      return;
    }
    
    if (widget.tasksList != oldWidget.tasksList) {
      // اگر لیست تسک‌ها از پراپ آمد، تبدیل به فرمت داخلی کن
      if (widget.title == 'Daily Tasks') {
        List<Map<String, dynamic>> modifiedData = widget.tasksList!.map((item) {
          if(item['Task_Type'] == 'Checkin'){
            return {
              'id': item['task_id'],
              'task_id': item['task_id'],
              'title': item['Title'],
              'type': "Check-In",
              'completed': item['Status'] ==true?'Done':''
            };
          }
          if(item['Task_Type'] == 'Action'){
            if(item['Category'] == 'Diet' || item['Category'] == 'Supplement' || item['Category'] == 'Lifestyle'){
              return {
                'id': item['task_id'],
                'task_id': item['task_id'],
                'title': item['Title'],
                'type': item['Category'],
                'completed': item['Status'] ==true?'Done':''
              };
            }
            if(item['Category'] == 'Activity'){
              print(item);
              return {
                'id': item['task_id'],
                'task_id': item['task_id'],
                'title': item['Title'],
                'type': "Activity",
                'Sections': item['Sections'],
                'completed': item['Status'] ==true?'Done':''
              };  
            }
          }
          return {
            'id': "",
            'title': "test",
            'task_id': item['task_id'],
            'type': "Check-In",
            'completed': "Done"
          };
        }).toList(); 
        // Sort by id
        modifiedData.sort((a, b) => a['id'].toString().compareTo(b['id'].toString()));
        setState(() {
          tasks = modifiedData;
        });
      } else {
        List<Map<String, dynamic>> modifiedData = widget.tasksList!.map((item) {
          return {
            'id': item['unique_id'],
            'title': item['title'],
            'type': "Questionnaire",
            'completed':item['Status'] ==true || item['status'] =='Done'?'Done':''
          };
        }).toList(); 
        // Sort by id
        modifiedData.sort((a, b) => a['id'].toString().compareTo(b['id'].toString()));
        setState(() {
          tasks = modifiedData;
        });
      }
      // اگر قبلاً تایمر فعال بوده و حالا پراپ آمد، تایمر را متوقف کن
      if (_timer != null) {
        _timer!.cancel();
        _timer = null;
      }
    }
  }

  /// Refresh tasks data from the server
  Future<void> refreshTasks() async {
    if (widget.tasksList != null) return;
    await fetchQuestionary();
  }

  /// Static method to refresh all Tasks widgets
  static void refreshAllTasks() {
    for (var instance in _instances) {
      instance.refreshTasks();
    }
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
              'task_id': item['task_id'],
              'title': item['Title'],
              'type': "Check-In",
              'completed': item['Status'] ==true?'Done':'' // Add custom key
            };
            }
          if(item['Task_Type'] == 'Action'){
            if(item['Category'] == 'Diet' || item['Category'] == 'Supplement' || item['Category'] == 'Lifestyle'){
              return {
                'id': item['task_id'],
                'task_id': item['task_id'],
                'title': item['Title'],
                'type': item['Category'],
                'completed': item['Status'] ==true?'Done':'' // Add custom key
              };
            }
            if(item['Category'] == 'Activity'){
              print(item);
              return {
                'id': item['task_id'],
                'task_id': item['task_id'],
                'title': item['Title'],
                'type': "Activity",
                'Sections': item['Sections'],
                'completed': item['Status'] ==true?'Done':'' // Add custom key
              };  
            }
          }
          return {
            'id': "",
            'title': "test",
            'task_id': item['task_id'],
            'type': "Check-In",
            'completed': "Done" // Add custom key
          };
          
        }).toList(); 
        // Sort by id
        modifiedData.sort((a, b) => a['id'].toString().compareTo(b['id'].toString()));
        tasks = modifiedData;
        });
      }else {
      setState((){
        List<Map<String, dynamic>> modifiedData = jsonData.map((item) {
          return {
            'id': item['unique_id'],
            'title': item['title'],
            'type': "Questionnaire",
            'completed':item['Status'] ==true || item['status'] =='Done'?'Done':'' // Add custom key
          };
        }).toList(); 
        // Sort by id
        modifiedData.sort((a, b) => a['id'].toString().compareTo(b['id'].toString()));
        tasks = modifiedData;
        });

      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  int resolveTasksLength() {
    int count = 0;
    if (widget.title == 'Daily Tasks') {
      for (var task in tasks) {
        if (task['type'] != "Questionnaire") {
          if (task['type'] == "Activity" && task['Sections'] != null && task['Sections'] is List) {
            for (var section in task['Sections']) {
              if (section is Map && section['Exercises'] != null && section['Exercises'] is List) {
                count += (section['Exercises'] as List).length;
              }
            }
          } else {
            count++;
          }
        }
      }
    } else {
      count = tasks.where((task) => task['type'] == "Questionnaire").length;
    }
    return count;
  }
  int resolveCompletedTasksLength() {
    int count = 0;
    if (widget.title == 'Daily Tasks') {
      for (var task in tasks) {
        if (task['type'] != "Questionnaire") {
          if (task['type'] == "Activity" && task['Sections'] != null && task['Sections'] is List) {
            for (var section in task['Sections']) {
              if (section is Map && section['Exercises'] != null && section['Exercises'] is List) {
                for (var exercise in section['Exercises']) {
                  if (exercise is Map && (exercise['completed'] == 'Done' || exercise['Status'] == true)) {
                    count++;
                  }
                }
              }
            }
          } else if (task["completed"] == 'Done' || task["Status"] == true) {
            count++;
          }
        }
      }
    } else {
      count = tasks.where((task) =>
        task['type'] == "Questionnaire" &&
        (task["completed"] == 'Done' || task["Status"] == true)
      ).length;
    }
    return count;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child:tasks.isNotEmpty ? Column(children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,style: AppTextStyles.title1,),
                Text(resolveCompletedTasksLength().toString()+"/"+resolveTasksLength().toString()+" Completed",style: AppTextStyles.hintSmale,),
              ],
            ),
          ],):const SizedBox(),
        ),
        Container(
          child: tasks.isNotEmpty ?
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
                child: taskTypes[index] !='Activity'? TaskWrapper(typeName: taskTypes[index],tasks: tasks.where((task) => task['type'] == taskTypes[index]).toList(),readOnly: widget.readOnly,onTaskCompletionChanged: _onTaskCompletionChanged,):ActivityTaskWrapper(typeName: taskTypes[index],tasks: tasks.where((task) => task['type'] == taskTypes[index]).toList(),readOnly: widget.readOnly,onTaskCompletionChanged: _onTaskCompletionChanged,) ,
              ),
            ),
          ): Padding(
                padding: const EdgeInsets.only(bottom: 10), // Adds gap of 10 pixels
                child: TaskWrapper(typeName: taskTypes[5],tasks: tasks.where((task) => task['type'] == taskTypes[5]).toList(),readOnly: widget.readOnly,onTaskCompletionChanged: _onTaskCompletionChanged,),
              ),
        )          
          :
           EmptyBox(iconPath:widget.title == 'Daily Tasks'?"assets/calendar-2.svg":"assets/favrit.svg" ,text:widget.title == 'Daily Tasks'? "No tasks for today yet":"No flexible tasks assigned",title:widget.title ,)
          ,
        ),

      ],
    );
  }
}