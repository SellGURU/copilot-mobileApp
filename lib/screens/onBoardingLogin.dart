import 'package:flutter/material.dart';

class onboarddinglogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // Back functionality here
              },
              child: Text(
                "Back",
                style: TextStyle(color: Colors.purple, fontSize: 16),
              ),
            ),
            Row(
              children: [
                Icon(Icons.circle, size: 8, color: Colors.purple),
                SizedBox(width: 4),
                Icon(Icons.circle, size: 8, color: Colors.purple.withOpacity(0.5)),
                SizedBox(width: 4),
                Icon(Icons.circle, size: 8, color: Colors.purple.withOpacity(0.3)),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Skip functionality here
              },
              child: Text(
                "Skip",
                style: TextStyle(color: Colors.purple, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Your Journey To A ',
                style: TextStyle(color: Colors.black, fontSize: 22),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Healthier',
                    style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    text: 'Balanced',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' Life Begins Here',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: 400, // Adjust size based on the image
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/journey_image.png', fit: BoxFit.cover), // Replace with your image
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  // Next button functionality
                },
                style: ElevatedButton.styleFrom(
                  // primary: Colors.purple, // Button color
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(fontSize: 18),
                ),
                child: Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
