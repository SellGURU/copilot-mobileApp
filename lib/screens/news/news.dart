import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LDLCholesterolScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LDL Cholesterol'),
        centerTitle: true,
        backgroundColor: Color(0xFF673AB7),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Latest'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {},
                      child: Text('History'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LDL Cholesterol',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'LDL, or low-density lipoprotein, is often referred to as the "bad" cholesterol because high levels of it can lead to a buildup of fatty deposits in your arteries...',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('learn more'),
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 200,
                        child: LDLCholesterolChart(),
                      ),
                      SizedBox(height: 16),
                      ExpansionTile(
                        title: Text('What Borderline LDL Cholesterol means for your health?'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Details about what Borderline LDL Cholesterol means...',
                            ),
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Text('What your body says'),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Details about what your body says...',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Overview',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}

class LDLCholesterolChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Placeholder for the chart
      color: Colors.grey[200],
      child: Center(
        child: Text('Chart Placeholder'),
      ),
    );
  }
}