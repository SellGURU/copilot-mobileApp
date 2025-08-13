import 'package:flutter/material.dart';
import '../components/text_style.dart';

class VerticalStatusIndicator extends StatelessWidget {
  final String status;
  final String current;
  final String average;
  final String date;
  final List<Map<String, dynamic>>? chartBounds;

  const VerticalStatusIndicator({
    super.key,
    required this.status,
    required this.current,
    required this.average,
    required this.date,
    this.chartBounds,
  });

  List<Map<String, dynamic>> _getStatusLevels() {
    if (chartBounds != null && chartBounds!.isNotEmpty) {
      return chartBounds!.map((bound) {
        Color statusColor = _getStatusColor(bound['status'] ?? '');
        return {
          'name': bound['high'] ?? bound['status'] ?? '',
          'color': statusColor,
          'bgColor': statusColor.withOpacity(0.1),
          'status': bound['status'] ?? '',
        };
      }).toList();
    }
    
    // Fallback to default statuses
    return [
      {'name': 'Good for Gut', 'color': Colors.green, 'bgColor': Colors.green.withOpacity(0.1)},
      {'name': 'Bad for Gut', 'color': Colors.red, 'bgColor': Colors.red.withOpacity(0.1)},
    ];
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
    // --- CriticalRange ---
    case 'critical':
    case 'criticalrange':
    case 'needs focus':
      return const Color.fromRGBO(178, 48, 46, 1);

    // --- DiseaseRange ---
    case 'disease':
    case 'diseaserange':
      return const Color.fromRGBO(186, 82, 37, 1);

    // --- BorderlineRange ---
    case 'borderline':
    case 'borderlinerange':
    case 'ok':
      return const Color.fromRGBO(216, 216, 0, 1);

    // --- HealthyRange ---
    case 'healthy':
    case 'healthyrange':
    case 'good':
      return const Color.fromRGBO(114, 193, 59, 1);

    // --- OptimalRange ---
    case 'optimal':
    case 'optimalrange':
    case 'excellent':
      return const Color.fromRGBO(55, 180, 94, 1);

    default:
      return Colors.grey;
    }
  }

  double _getStatusPosition(String status) {
    switch (status.toLowerCase()) {
      case 'good':
      case 'excellent':
      case 'healthy':
      case 'good for gut':
        return 0.2; // Top 20% of the indicator
      case 'bad':
      case 'poor':
      case 'unhealthy':
      case 'bad for gut':
        return 0.8; // Bottom 80% of the indicator
      case 'warning':
      case 'moderate':
        return 0.5; // Middle of the indicator
      default:
        return 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusLevels = _getStatusLevels();
    final currentPosition = _getStatusPosition(status);

    return Container(
       height: 130, // کاهش ارتفاع برای جلوگیری از overflow
       child: Row(
        children: [
          // Color scale bar
          Container(
            width: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green,
                  Colors.red,
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Main status indicator
          Expanded(
            child: Container(
              child: Column(
                children: statusLevels.map((level) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: level['bgColor'],
                        border: Border(
                           bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1.5),
                         ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                                 child: Row(
                           children: [
                                                           Expanded(
                                child: Tooltip(
                                  message: level['name'],
                                  child: Text(
                                    level['name'].length > 5 
                                        ? '${level['name'].substring(0, 5)}...'
                                        : level['name'],
                                    style: AppTextStyles.hint.copyWith(
                                      color: Colors.grey[600],
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                             // Status dot indicator
                             if (level['name'].toLowerCase() == current.toLowerCase())
                               Container(
                                 width: 8,
                                 height: 8,
                                 decoration: BoxDecoration(
                                   color: _getStatusColor(status.toLowerCase()),
                                   shape: BoxShape.circle,
                                   border: Border.all(color: Colors.white, width: 1),
                                 ),
                               ),
                           ],
                         ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

