import 'package:flutter/material.dart';
import 'package:copilet/res/colors.dart';
import 'package:flutter_svg/svg.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      appBar: AppBar(
        leadingWidth: 60,
        titleSpacing: 0,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.bgScreen,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 7, bottom: 7),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: SizedBox(
              height: 20,
              width: 20,
              child: SvgPicture.asset('assets/arrow-left.svg'),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 28, right: 28, top: 0, bottom: 28),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x11000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section(
                '1. Types of information we collected online',
                'We collect personal details (name, email), usage data, and preferences to improve user experience.',
              ),
              _section(
                '2. What is our purpose of data collection?',
                'The purpose of data collection in a longevity application is to help users improve their overall health, extend their lifespan, and enhance their quality of life.\nHere are some specific goals:',
              ),
              _subpoints([
                'Personalized Health Insights',
                'Monitoring Health Metrics',
                'Preventive Care Suggestions',
                'Real-Time Alerts and Notifications',
                'Progress Tracking',
                'Research and Development (if applicable and with consent)',
                'Behavioral Pattern Analysis',
              ]),
              _section(
                '3. What are our user’s rights?',
                'Users can access, update, or delete their data and manage preferences.',
              ),
              _section(
                '4. Data Storage and Protection',
                'We store data securely using encryption and access controls.',
              ),
              _section(
                '5. Policy Updates',
                'We may update this policy periodically and notify users of significant changes.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  height: 1.5,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(body,
              style: const TextStyle(
                  fontSize: 12, height: 1.5, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _subpoints(List<String> points) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: points
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text('• $e',
                      style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: AppColors.textSecondary)),
                ))
            .toList(),
      ),
    );
  }
}
