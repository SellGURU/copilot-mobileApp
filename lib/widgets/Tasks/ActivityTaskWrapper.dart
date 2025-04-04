import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/widgets/Tasks/TaskItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActivityTaskWrapper extends StatefulWidget {
  final String typeName; // Accept type name as a parameter
  final List<Map<String, dynamic>> tasks;
  const ActivityTaskWrapper({super.key,required this.typeName,required this.tasks});

  @override
  State<ActivityTaskWrapper> createState() {
    return _ActivityTaskWrapperState();
  }  
}

class _ActivityTaskWrapperState extends State<ActivityTaskWrapper> {
  @override
  Widget build(BuildContext context) {
    return  Column(
              children:  [
                Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                        "assets/firstline.svg",
                        fit: BoxFit.cover,
                        width:18,
                        height:18
                    ),
                    Text(widget.typeName,style: AppTextStyles.hintSmalePrimary,)
                  ],
                )
                ,
                Column(
                  children:List.generate(widget.tasks.length, (index) => 
                    Column(   
                      children: [
                        Row(
                          children: [
                            Padding(
                            padding: const EdgeInsets.only(left: 16, top: 4),
                            child: Text('Subtask',style: AppTextStyles.hintMedium,),
                          ),
                          
                        ],
                      )
                        ,
                        Column(
                          children: List.generate(widget.tasks[index]["Sections"].length, (inde) => 
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              padding:const EdgeInsets.only(left: 8),
                              decoration: const BoxDecoration(
                                border: Border(left: BorderSide(color: AppColors.SilverGray,width: 1,))
                              ),
                              child:Column(
                              children: List.generate(widget.tasks[index]["Sections"][inde]["Exercises"].length,
                              (index2) => 
                                Padding(padding: const EdgeInsets.only(bottom: 4),
                                child: TaskItem(task: widget.tasks[index],),
                                ),
                              )
                            )                          
                              )
                            ),
                        ),                    
                        ] 
                    ),
                  ),
                ),
              ],
            );    
  }
}