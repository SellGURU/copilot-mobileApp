import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccordionPage extends StatelessWidget{

  const AccordionPage({super.key});

  @override
  build(context) => Accordion(
      headerBorderColor: Colors.blueGrey,
      headerBorderColorOpened: Colors.transparent,
      // headerBorderWidth: 1,
      headerBackgroundColorOpened: Colors.green,
      contentBackgroundColor: Colors.white,
      contentBorderColor: Colors.green,
      contentBorderWidth: 3,
      contentHorizontalPadding: 20,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      headerPadding:
      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: [
        AccordionSection(
          isOpen: false,
          leftIcon: const Icon(Icons.circle, color: Colors.white),
          headerBackgroundColor: Colors.green[900],
          headerBackgroundColorOpened: Colors.lightBlue,
          headerBorderColorOpened: Colors.yellow,
          headerBorderWidth: 10,
          contentBackgroundColor: Colors.lightBlue,
          contentBorderColor: Colors.yellow,
          contentBorderWidth: 10,
          contentVerticalPadding: 30,
          header: const Text('Custom: Heavy Borders', style: headerStyle),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.label_important_outline_rounded,
                size: 50,
                color: Colors.white54,
              ),
              const Flexible(
                child: Text(
                  slogan,
                  maxLines: 4,
                  style: TextStyle(color: Colors.white54, fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ],
  );
} //__
