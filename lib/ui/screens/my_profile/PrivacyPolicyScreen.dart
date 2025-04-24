import 'package:cosmospedia/ui/components/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

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
              'Privacy Policy',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: screenSize.width * 0.045,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        body: _buildPrivacyContent(context),
      ),
    );
  }

  Widget _buildPrivacyContent(BuildContext context) {
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
                'CosmosPedia Privacy Policy',
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
              _buildPrivacySection(
                context,
                '1. Introduction',
                'Welcome to CosmosPedia ("we", "our", or "us"). This Privacy Policy governs your use of the CosmosPedia mobile application (the "App") and outlines how we collect, utilize, disclose, and safeguard your personal information. We are committed to ensuring that your privacy is protected and that your data is handled in accordance with applicable laws and industry standards.',
                Icons.info_outline,
                Colors.blue,
              ),
              _buildPrivacySection(
                context,
                '2. Information Collection and Use',
                'We collect various categories of information to deliver an optimal and personalized user experience:\n'
                    '• Account Information: When registering for an account, we collect your email address, display name, and password to facilitate authentication and account management.\n'
                    '• Usage Data: We automatically collect data relating to your interactions with the App, including device type, operating system, app version, and engagement metrics with features.\n'
                    '• Favorites Data: User-saved preferences, such as selected asteroids, rover imagery, and space weather events, are stored to personalize content and enhance usability.\n'
                    '• Crash Reports: In the event of a system malfunction, diagnostic information is collected to support issue resolution and improve app stability.',
                Icons.data_usage,
                Colors.green,
              ),
              _buildPrivacySection(
                context,
                '3. Firebase Services Integration',
                'We utilize the following Firebase services:\n'
                    '• Firebase Authentication: For secure user sign-in and account management.\n'
                    '• Firebase Analytics: To gain insights into user behavior and app performance.\n'
                    '• Firebase Crashlytics: For real-time crash reporting and issue diagnosis.',
                Icons.cloud_outlined,
                Colors.orange,
              ),
              _buildPrivacySection(
                context,
                '4. How We Use Your Data',
                'We process your personal data for the following legitimate business purposes:\n'
                    '• To deliver, operate, and maintain the App and its features\n'
                    '• To inform users of updates, enhancements, or critical changes to the App\n'
                    '• To enable participation in interactive and personalized features\n'
                    '• To provide responsive customer support\n'
                    '• To perform data analysis to refine and evolve the App\n'
                    '• To monitor overall usage trends and engagement\n'
                    '• To detect, investigate, and mitigate technical issues and security vulnerabilities',
                Icons.psychology_outlined,
                Colors.cyan,
              ),
              _buildPrivacySection(
                context,
                '5. Data Sharing and Disclosure',
                'We do not sell, rent, or lease your personal information. Disclosure of personal data is limited to the following instances:\n'
                    '• Service Providers: Trusted third parties such as Firebase may process your information on our behalf for purposes such as hosting, analytics, and customer support.\n'
                    '• Legal Compliance: We may disclose your data if mandated by law or in response to valid requests from public authorities.',
                Icons.share_outlined,
                Colors.amber,
              ),
              _buildPrivacySection(
                context,
                '6. Data Security',
                'We employ a combination of administrative, technical, and physical safeguards to protect your data. These measures include encrypted data transmission, secure authentication protocols, and regular security assessments. While we strive to use commercially acceptable means to protect your information, no electronic transmission or storage method is entirely foolproof.',
                Icons.security,
                Colors.purple,
              ),
              _buildPrivacySection(
                context,
                '7. Your Data Protection Rights',
                'Depending on your jurisdiction, you may be entitled to exercise certain rights under data protection laws, including:\n'
                    '• The right to access, correct, or delete your personal information\n'
                    '• The right to restrict or object to data processing\n'
                    '• The right to data portability\n'
                    '• The right to withdraw consent where processing is based on consent',
                Icons.gavel_outlined,
                Colors.teal,
              ),
              _buildPrivacySection(
                context,
                '8. Children\'s Privacy',
                'The App is not intended for children under the age of 13. We do not knowingly collect personal data from children. If we become aware that we have collected information from a child without verifiable parental consent, we will take appropriate steps to delete such data promptly.',
                Icons.child_care_outlined,
                Colors.indigo,
              ),
              _buildPrivacySection(
                context,
                '9. Changes to This Privacy Policy',
                'We may revise this Privacy Policy from time to time to reflect changes in legal, regulatory, or operational requirements. We will notify users of significant changes by updating this page and modifying the "Effective Date" above.',
                Icons.update_outlined,
                Colors.deepPurple,
              ),
              _buildPrivacySection(
                context,
                '10. Platform-Specific Disclosures',
                'Google Play Store – Data Safety:\n'
                    '• Data Collected: Email address, usage statistics, crash diagnostics\n'
                    '• Purpose: Authentication, core app functionality, performance analytics\n'
                    '• Third-Party Sharing: Limited to Firebase services (managed by Google)\n'
                    '• Security Practices: Data encrypted in transit, secure authentication protocols employed\n'
                    '• User Control: Data deletion requests may be submitted via in-app settings or by contacting support\n\n'
                    'Apple App Store – Privacy Nutrition Label:\n'
                    '• Identifiers: User ID (for user account functionality)\n'
                    '• Usage Data: Feature interactions, session activity\n'
                    '• Diagnostics: Application crash logs\n'
                    '• Usage Purpose: Functional operation of the app, analytics, and service enhancement',
                Icons.devices_outlined,
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

  Widget _buildPrivacySection(
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
                    '11. Contact Us',
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
              'If you have any questions, concerns, or requests regarding this Privacy Policy, you may contact us:',
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
            'I Accept This Privacy Policy',
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