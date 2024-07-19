
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/text_style.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final String status;
  final String average;
  final String current;
  final Widget icon;

  ItemCard({super.key, required this.title, required this.average, required this.current, required this.icon, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))),
      width: 160,
      height: 200,
      child: Padding(

        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                Text(title,style: AppTextStyles.title1,),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Avg",style: AppTextStyles.hint,),
                    Row(
                      children: [
                        Text(average,style: AppTextStyles.title1,),
                        const SizedBox(width: 5,),
                        Text("bpm" ,style: AppTextStyles.hint,)
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Avg",style: AppTextStyles.hint,),
                    Row(
                      children: [
                        Text(average,style: AppTextStyles.title1,),
                        const SizedBox(width: 5,),
                        Text("bpm" ,style: AppTextStyles.hint,)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
