// lib/widgets/health_plan_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthPlanCard extends StatelessWidget {
  final Function() onclick;
  const HealthPlanCard({
    super.key,
    required this.onclick,
    });
  static const String url = 'https://www.google.com';
  // Future<void> _openUrl(BuildContext context) async {
  //   final uri = Uri.parse(url);
  //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF89C8FF),
          borderRadius: BorderRadius.circular(25),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [

          //  Positioned(
          //     top: 0,
          //     right: 0,

          //     child: SvgPicture.asset(
          //       'assets/helthPlanCard2.svg', // مسیر تصویرت
          //       width: 80, // اندازه تصویر
          //       height: 80,
          //     ),
          //   ),            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Your Health Plan Is Ready!',
                    style: TextStyle(
                      color: Color(0xFF003366),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      'A personalized health plan has been created for you. Explore your plan and start your journey toward better health.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Color(0xFF003366),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      onclick();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1C3F60),
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(fontSize: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical:0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('View My Health Plan'),
                  ),
                ],
              ),
            ),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: SvgPicture.asset(
            //     'assets/helthplancard.svg', // مسیر تصویرت
            //   ),
            // ),
            //  SvgPicture.asset(
            //     'assets/helthplancard.svg', // مسیر تصویرت
            //   ),
          ],
        ),
      ),
    );
  }
}
