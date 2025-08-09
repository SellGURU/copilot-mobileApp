import 'package:copilet/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgScreen,
      appBar: AppBar(
        leadingWidth: 60,
        titleSpacing: 0,
        title: const Text(
          'Terms of Service',
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
                '1. Acceptance of Terms',
                'By using this app, you agree to comply with these Terms of Service and all applicable laws and regulations.',
              ),
              _section(
                '2. Description of Services',
                'Our app offers personalized health insights, lifestyle recommendations, and real-time updates to support your longevity journey.',
              ),
              _section(
                '3. User Obligations and Responsibilities',
                'You agree to use the app responsibly and avoid sharing false, harmful, or unauthorized content.',
              ),
              _section(
                '4. Health and Medical Disclaimer',
                'The app provides general health guidance and is not a substitute for professional medical advice or treatment.',
              ),
              _section(
                '5. Subscription, Fees, and Payments',
                'Details of pricing, payment terms, subscription renewals, and refund policies are clearly outlined in this section.',
              ),
              _section(
                '6. Limitation of Liability',
                'We are not liable for any damages resulting from the use or inability to use the app.',
              ),
              _section(
                '7. Contact Information',
                'For questions about these terms, please contact us at the email address :\nHolisticaire@gmail.com',
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
}
