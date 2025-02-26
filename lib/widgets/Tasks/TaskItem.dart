// ignore: file_names
import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
import 'package:copilet/widgets/Tasks/TaskWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskItem extends StatefulWidget {
  final Map<String, dynamic> task;
  const TaskItem({super.key,required this.task});
  @override
  State<TaskItem> createState() {
    return _TaskItemState();
  }  
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                        Row(mainAxisAlignment:MainAxisAlignment.start,spacing: 4 ,children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: AppColors.SilverGray,
                                width: 3,
                              )// Rounded corners
                            ),
                            child: Center(
                              // ignore: deprecated_member_use
                              child:SvgPicture.asset('assets/firstline.svg',width: 16,height: 16,fit: BoxFit.contain,color: AppColors.TextTriarty ,) )
                          )
                          ,
                          Text(widget.task["title"],style: AppTextStyles.hintMedium,)
                        ],)
                        ,
                        Container(
                          width: 24,
                          height: 24,
                          decoration:BoxDecoration(
                            border: Border.all(
                              color:AppColors.SilverGray,
                              width:1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ) ,
                          child: Center(
                            child:SvgPicture.asset('assets/pelas.svg',) ,
                          ),
                        )
                ] ,);
  }  
}