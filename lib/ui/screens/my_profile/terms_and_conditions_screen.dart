import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final screenSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/background.png"),
          opacity: 0.4,
        ),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppColors.transparentColor,
        appBar: customAppBar(
          scaffoldKey: scaffoldKey,
          context: context,
          titleWidget: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.indigo.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.indigo.withOpacity(0.5), width: 1),
            ),
            child: Text(
              'Terms & Conditions',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: _buildTermsContent(context),
      ),
    );
  }

  Widget _buildTermsContent(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.withOpacity(0.3), Colors.blue.withOpacity(0.3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Center(
              child: Text(
                'CosmosPedia Terms',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildTermsSection(
                context,
                '1. Introduction',
                'Welcome to the CosmosPedia mobile application (hereinafter referred to as the "App"), developed and maintained by CosmosPedia. These Terms and Conditions ("Terms") govern your access to and use of the App. By accessing, installing, or using the App, you agree to be bound by these Terms. We encourage you to read them carefully.',
                Icons.info_outline,
                Colors.blue,
              ),
              _buildTermsSection(
                context,
                '2. Acceptance of Terms',
                'By downloading, installing, or using the App, you acknowledge and affirm that you have read, understood, and agree to comply with these Terms in full. If you do not agree with any part of these Terms, you must refrain from using the App.',
                Icons.check_circle_outline,
                Colors.green,
              ),
              _buildTermsSection(
                context,
                '3. License and Permitted Use',
                'CosmosPedia grants you a limited, revocable, non-exclusive, non-transferable, and non-sublicensable license to use the App strictly for personal, non-commercial purposes, subject to these Terms. You agree not to exploit the App or its content for any unlawful, unauthorized, or prohibited activity.',
                Icons.verified_user_outlined,
                Colors.cyan,
              ),
              _buildTermsSection(
                context,
                '4. User Accounts',
                'Certain functionalities of the App may require you to register an account. You are solely responsible for maintaining the confidentiality and security of your account credentials and for all activities that occur under your account. You agree to promptly notify us of any unauthorized access or security breaches related to your account.',
                Icons.person_outline,
                Colors.orange,
              ),
              _buildTermsSection(
                context,
                '5. Content Disclaimer',
                'All content presented through the App—including text, imagery, data, and multimedia—is provided for general informational purposes only. While we endeavor to ensure accuracy and reliability, CosmosPedia makes no warranties, representations, or guarantees—express or implied—regarding the completeness, precision, or reliability of the content.',
                Icons.warning_amber_outlined,
                Colors.amber,
              ),
              _buildTermsSection(
                context,
                '6. Intellectual Property Rights',
                'The App, including but not limited to its design, functionality, visual elements, codebase, and all associated content, is the exclusive property of CosmosPedia and its licensors. It is protected under applicable intellectual property laws, including copyright, trademark, and patent laws. Unauthorized reproduction, modification, or distribution of any part of the App is strictly prohibited.',
                Icons.copyright_outlined,
                Colors.purple,
              ),
              _buildTermsSection(
                context,
                '7. Third-Party Links and Services',
                'The App may contain links to or integrations with third-party websites, services, or content not operated or controlled by CosmosPedia. We assume no responsibility for the content, privacy practices, or policies of any third parties. Your interaction with such external resources is governed by their respective terms and policies.',
                Icons.link,
                Colors.teal,
              ),
              _buildTermsSection(
                context,
                '8. Limitation of Liability',
                'To the maximum extent permitted by applicable law, CosmosPedia, its affiliates, officers, directors, employees, agents, partners, and licensors shall not be liable for any direct, indirect, incidental, special, consequential, or exemplary damages—including but not limited to loss of revenue, data, or business opportunities—arising from or related to your access to or use of the App.',
                Icons.policy_outlined,
                Colors.indigo,
              ),
              _buildTermsSection(
                context,
                '9. Amendments to the Terms',
                'We reserve the right to amend, revise, or update these Terms at our sole discretion. Material changes will be communicated via the App or by other appropriate means. Continued use of the App after the effective date of the updated Terms constitutes your acceptance of the revised agreement.',
                Icons.update_outlined,
                Colors.deepPurple,
              ),
              _buildTermsSection(
                context,
                '10. Governing Law and Jurisdiction',
                'These Terms shall be governed by and construed in accordance with the laws of the jurisdiction in which CosmosPedia operates, excluding any conflict of laws provisions. You agree to submit to the exclusive jurisdiction of the courts located in said jurisdiction for the resolution of any disputes arising out of or in connection with these Terms or the use of the App.',
                Icons.balance_outlined,
                Colors.blue,
              ),
              _buildContactSection(context),
              const SizedBox(height: 24),
              _buildAcceptanceButton(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection(
      BuildContext context, String title, String content, IconData icon, Color iconColor) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      color: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: iconColor.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [iconColor, iconColor.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: iconColor.withOpacity(0.3), height: 24),
            Text(
              content,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 8,
      color: Colors.black.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.pink.withOpacity(0.3), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.pink, Colors.pink.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.contact_support_outlined,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '11. Contact Information',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.pink.withOpacity(0.3), height: 24),
            Text(
              'For any inquiries, clarifications, or concerns regarding these Terms, please reach out to us via:',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.pink.withOpacity(0.2),
                    Colors.purple.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                children: [
                  _buildFixedContactDetail(
                    context,
                    'Email',
                    'cosmospedia0720@gmail.com',
                    Icons.email_outlined,
                    Colors.pink[300]!,
                  ),
                  Divider(color: Colors.pink.withOpacity(0.2), height: 16),
                  _buildFixedContactDetail(
                    context,
                    'In-app Support',
                    'Available in settings menu',
                    Icons.help_outline,
                    Colors.purple[300]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fixed contact detail widget to prevent overflow
  Widget _buildFixedContactDetail(
      BuildContext context, String label, String value, IconData icon, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptanceButton(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.5),
              blurRadius: 15,
              spreadRadius: 2,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Handle acceptance logic
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
          child: const Text(
            'I Accept These Terms',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}