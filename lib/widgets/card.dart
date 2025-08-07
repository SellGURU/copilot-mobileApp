import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../components/text_style.dart';
import 'chart.dart';
import 'vertical_status_indicator.dart';

/*
Example usage of ItemCard with chartBounds:

List<Map<String, dynamic>> chartBounds = [
  {
    "high": "Enhanced Outcome",
    "low": "Enhanced Outcome", 
    "label": "",
    "status": "Excellent",
    "color": ""
  },
  {
    "high": "Moderately Enhanced Outcome",
    "low": "Moderately Enhanced Outcome",
    "label": "",
    "status": "Good", 
    "color": ""
  },
  {
    "high": "Moderately Compromised Outcome",
    "low": "Moderately Compromised Outcome",
    "label": "",
    "status": "Ok",
    "color": ""
  },
  {
    "high": "Compromised Outcome", 
    "low": "Compromised Outcome",
    "label": "",
    "status": "Needs Focus",
    "color": ""
  }
];

ItemCard(
  title: "Your Title",
  status: "Good", // This will show the dot in the "Good" section
  current: "Current Value",
  average: "Average Value", 
  scale: "", // Empty scale will show VerticalStatusIndicator
  icon: YourIcon(),
  valuesData: [1.0, 2.0, 3.0],
  chartBounds: chartBounds, // Pass the dynamic status data
)
*/



// New widget to display status-based string values
class StatusDisplayWidget extends StatelessWidget {
  final String status;
  final String current;
  final String average;

  const StatusDisplayWidget({
    super.key,
    required this.status,
    required this.current,
    required this.average,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'good':
      case 'excellent':
      case 'healthy':
        return Colors.green;
      case 'bad':
      case 'poor':
      case 'unhealthy':
        return Colors.red;
      case 'warning':
      case 'moderate':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'good':
      case 'excellent':
      case 'healthy':
        return Icons.check_circle;
      case 'bad':
      case 'poor':
      case 'unhealthy':
        return Icons.error;
      case 'warning':
      case 'moderate':
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: _getStatusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _getStatusColor(status).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getStatusIcon(status),
                color: _getStatusColor(status),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                status,
                style: AppTextStyles.title1.copyWith(
                  color: _getStatusColor(status),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Current",
                    style: AppTextStyles.hint,
                  ),
                  Text(
                    current,
                    style: AppTextStyles.title1.copyWith(
                      color: _getStatusColor(status),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Average",
                    style: AppTextStyles.hint,
                  ),
                  Text(
                    average,
                    style: AppTextStyles.title1.copyWith(
                      color: _getStatusColor(status),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  final String title;
  final String status;
  final String average;
  final String current;
  String scale;
  final Widget icon;
  final List<double> valuesData;
  final List<Map<String, dynamic>>? chartBounds; // New property for dynamic status data

  ItemCard({
    super.key,
    required this.scale,
    required this.title,
    required this.average,
    required this.current,
    required this.icon,
    required this.status,
    required this.valuesData,
    this.chartBounds, // Optional parameter
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late List<FlSpot> spots; // State variable for spots

  @override
  void initState() {
    super.initState();
    spots = getSpots(); // Generate spots once during initialization
  }

  double nextGaussian() {
    final random = Random();
    double u1 = random.nextDouble();
    double u2 = random.nextDouble();
    return sqrt(-2 * log(u1)) * cos(2 * pi * u2); // Box-Muller transform
  }

  double getRandomY() {
    double mean = 120; // Average heart rate (center of the range)
    double stdDev = 30; // Standard deviation for wider spread
    double randomValue = mean + stdDev * nextGaussian();
    return randomValue.clamp(60, 180); // Clamp values between 60 and 180
  }

  List<FlSpot> getSpots() {
    return List.generate(
      widget.valuesData.length,
      (index) => FlSpot(
        index.toDouble(),
        widget.valuesData[index], // Convert to double for FlSpot
      ),
    );
  }

  double calculateAverageY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0; // Handle empty spots list
    double total = spots.fold(0, (sum, spot) => sum + spot.y);
    return total / spots.length;
  }

  @override
  Widget build(BuildContext context) {
    double averageY = calculateAverageY(spots); // Calculate average once

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      width: 200,
      height: widget.average!='Bad for gut' && widget.average!='Good for gut' ? 100 : 200,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 15, right: 15, bottom: 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: widget.icon,
                ),
                SizedBox(width: 8,),
                Tooltip(
                  message: widget.title.length > 13 ? widget.title : '',
                  child: Text(
                    widget.title.length > 13 ? '${widget.title.substring(0, 13)}...' : widget.title,
                    style: AppTextStyles.title1.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              child: widget.scale != "" ?
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Avg",
                          style: AppTextStyles.hint,
                        ),
                        Row(
                          children: [
                            Text(
                              "${widget.average}", // Display average Y
                              style: AppTextStyles.title1,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.scale,
                              style: AppTextStyles.hintSmale,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Current",
                          style: AppTextStyles.hint,
                        ),
                        Row(
                          children: [
                            Text(
                              widget.current, // Display current value
                              style: AppTextStyles.title1,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.scale,
                              style: AppTextStyles.hintSmale,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              : VerticalStatusIndicator(
                  status: widget.status,
                  current: widget.current,
                  average: widget.average,
                  date: "30.06.2025", // You can make this dynamic
                  chartBounds: widget.chartBounds,
                ),
            ),
            const SizedBox(height: 30),
            Container(
              child: widget.scale != "" ?
                ChartDot(spots: spots, labels:['1','2','3','4','5','6','7','8','9','10']) // Pass the same spots to ChartDot
              : const SizedBox.shrink(), // Empty space when scale is empty
            )
          ],
        ),
      ),
    );
  }
}
