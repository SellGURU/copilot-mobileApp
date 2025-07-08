import 'package:copilet/components/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyBox extends StatelessWidget {
  final String text;
  final String iconPath;
  final String title;

  const EmptyBox({
    super.key,
    required this.text,
    required this.iconPath,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start,children: [
        const SizedBox(height: 20,),
        Container(alignment: Alignment.centerLeft,child: Text(title,style: AppTextStyles.title1,)),
        const SizedBox(height: 10,),        
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(3, 0),
              ),
            ]),
          height: 144,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconPath,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 8,),
                Text(text,style: AppTextStyles.headline6,),
              ],
            ),
          ),
          )
        ],
      );
  }  
}