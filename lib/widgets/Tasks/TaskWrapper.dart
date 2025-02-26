import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/widgets/Tasks/TaskItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskWrapper extends StatefulWidget {
  final String typeName; // Accept type name as a parameter
  final List<Map<String, dynamic>> tasks;
  const TaskWrapper({super.key,required this.typeName,required this.tasks});

  @override
  State<TaskWrapper> createState() {
    return _TaskWrapperState();
  }  
}

class _TaskWrapperState extends State<TaskWrapper> {
  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
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
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  padding:const EdgeInsets.only(left: 8),
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(color: AppColors.SilverGray,width: 1,))
                  ),
                  child:Column(
                  children: List.generate(widget.tasks.length,
                  (index) => 
                    Padding(padding: const EdgeInsets.only(bottom: 4),
                    child: TaskItem(task: widget.tasks[index],),
                    ),
                  )
                )
                ,
                ),
              ],
            );    
  }
}