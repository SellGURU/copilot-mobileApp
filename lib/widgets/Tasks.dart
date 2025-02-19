import 'package:copilet/components/text_style.dart';
import 'package:copilet/res/colors.dart';
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
  List<Map<String, dynamic>> tasks = [
    { "id": 1, "title": "Morning Check-In", "type": "Check-In", "completed": false },
    { "id": 2, "title": "Daily Questionnaire", "type": "Questionary", "completed": true },
    { "id": 3, "title": "Drink Water", "type": "Habits", "completed": false }
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
            children:[Column(
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
                    Text('Check-In',style: AppTextStyles.hintSmalePrimary,)
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
                  children: [
                    Row(
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
                          Text("Daily Check in",style: AppTextStyles.hintMedium,)
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
                      ],)
                  ],
                )
                ,
                ),

              ],
            )]
          ),
        )
      ],
    );
  }
}