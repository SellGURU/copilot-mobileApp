import 'package:copilet/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class OverlappingCirclesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: 33, // Adjust the overall width of the layout
      height: 20, // Adjust the overall height of the layout
      child: Stack(
        // alignment: Alignment.center,
        children: [
          // Left Circle
          Positioned(
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: AppColors.mainBg,
                  border: Border.all(width: 1.5,color: AppColors.mainBg),
                  borderRadius: BorderRadius.all(Radius.circular(100))
              ),
              child:
              ClipRRect(
                borderRadius: BorderRadius.circular(1000), // Image border

                child: Image.asset(
                  "assets/man2.png",
                  fit:BoxFit.cover,
                ),
              ),
            ),
          ),
          // Right Circle
          Positioned(
            // Adjust right alignment
            left: 13,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  color: AppColors.mainBg,
                  border: Border.all(width: 1.5,color: AppColors.mainBg),
                  borderRadius: BorderRadius.all(Radius.circular(100))
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1000), // Image border
                child: Image.asset(
                  "assets/woman3.png",
                  fit:BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
