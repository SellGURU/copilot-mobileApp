import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/text_style.dart';


class Mood extends StatefulWidget {
  Mood({super.key});
  @override
  State<Mood> createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  List<String> imagePath = [
    "emoji.png",
    "emoji-1.png",
    "emoji-2.png",
    "emoji-3.png",
    "emoji-4.png",
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
              height: 150,
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
