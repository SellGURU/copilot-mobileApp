import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_copilet/components/text_style.dart';

import '../res/colors.dart'; // Assuming you are using an Accordion package

class DynamicAccordion extends StatelessWidget {
  final List<Map<String, dynamic>> sections;

  DynamicAccordion({
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Accordion(
      headerBackgroundColor: AppColors.mainBg,

      // headerBorderColorOpened: Colors.transparent,
      // headerBorderWidth: 1,
      // headerBackgroundColorOpened: Colors.green,

      contentBackgroundColor: Colors.white,
      // contentBorderColor: Colors.green,
      // contentBorderWidth: 3,
      rightIcon: const Icon(
        Icons.keyboard_arrow_down_sharp,
        color: Color.fromRGBO(48, 68, 91, 1),
        size: 24.0,
      ),
      contentHorizontalPadding: 20,
      scaleWhenAnimating: true,

      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: sections.map((section) {
        return AccordionSection(

          isOpen: false,
          // leftIcon: const Icon(Icons.circle, color: Colors.white),
          headerBackgroundColor: AppColors.mainBg,
          // headerBackgroundColorOpened: Colors.lightBlue,
          // headerBorderColorOpened: Colors.yellow,
          headerBorderWidth: 10,
          // contentBackgroundColor: Colors.lightBlue,
          // contentBorderColor: Colors.yellow,
          contentBorderWidth: 0,
          contentVerticalPadding: 30,
          header: Text(
            section['headerText'],
            style: AppTextStyles.title1,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  section['contentText'],
                  maxLines: section['contentMaxLines'] ?? 2,
                  style: AppTextStyles.hintBlack,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
