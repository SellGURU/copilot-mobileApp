import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_copilet/components/text_style.dart';
import 'package:test_copilet/res/colors.dart';

class Mood extends StatefulWidget {
  Mood({super.key});
  @override
  State<Mood> createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  List<String> imagePath = [
    "1-emoji.png",
    "2-emoji.png",
    "3-emoji.png",
    "4-emoji.png",
    "5-emoji.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                "Mood",
                style: AppTextStyles.title1,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "Please select your mood yesterday",
                style: AppTextStyles.hint,
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Image.asset("assets/${imagePath[index]}",scale: .7,);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    width: 0,
                  );
                },
                itemCount: imagePath.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
