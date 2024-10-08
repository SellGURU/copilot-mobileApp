import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body: "Explore the features of our app.",
          image: Image.asset("assets/welcome.png", height: 200),
        ),
        PageViewModel(
          title: "Stay Connected",
          body: "Keep in touch with your family and friends.",
          image: Image.asset("assets/connect.png", height: 200),
        ),
        PageViewModel(
          title: "Get Started",
          body: "Start using the app and enjoy!",
          image: Image.asset("assets/start.png", height: 200),
        ),
      ],
      onDone: () {
        // Handle when done button is pressed
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(22.0, 10.0),
        activeColor: Colors.blue,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}