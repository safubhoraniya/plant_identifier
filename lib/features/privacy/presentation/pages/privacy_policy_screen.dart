import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                title: '1. Introduction',
                content:
                    'Plant Identifier ("we", "us", or "our") operates the Plant Identifier application. '
                    'This page informs you of our policies regarding the collection, use, and disclosure of '
                    'personal data when you use our application and the choices you have associated with that data.\n\n'
                    'We are committed to protecting your privacy and ensuring you have a positive experience on our app.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '2. Information Collection and Use',
                content:
                    'We collect and use the following information:\n\n'
                    '• Camera Data: Images you take for plant identification are processed on your device only.\n'
                    '• Device Information: Basic device data to optimize app performance.\n'
                    '• Usage Data: Information about how you use the app (plant searches, favorites).\n'
                    '• Location: Optional location data only if you grant permission.\n\n'
                    'All plant identification data is processed locally on your device and is not stored on our servers.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '3. Data Security',
                content:
                    'The security of your data is important to us but remember that no method of transmission '
                    'over the internet or method of electronic storage is 100% secure. While we strive to use '
                    'commercially acceptable means to protect your personal data, we cannot guarantee its '
                    'absolute security.\n\n'
                    'Your app data is encrypted and stored locally on your device. We do not transmit personal '
                    'plant identification data to external servers.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '4. Children\'s Privacy',
                content:
                    'Our app is designed to be helpful for users of all ages. We do not knowingly collect '
                    'personally identifiable information from anyone under the age of 13. If you are a parent '
                    'or guardian and you are aware that your child has provided us with personal data, please '
                    'contact us at support@plantidentifier.com.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '5. Third-Party Services',
                content:
                    'The app uses Google ML Kit for plant recognition. Google may collect certain data in '
                    'accordance with their privacy policy. Image processing happens on your device, and images '
                    'are not sent to Google\'s servers.\n\n'
                    'We use Firebase for optional analytics (if enabled in app settings). You can disable '
                    'analytics in the settings menu.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '6. Permissions',
                content:
                    'Plant Identifier requests the following permissions:\n\n'
                    '• Camera: To capture plant photos for identification\n'
                    '• Storage: To access and save plant images\n'
                    '• Photos: To identify plants from your photo library\n\n'
                    'All permissions are optional and your app will still function without them.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '7. Data Retention',
                content:
                    'We retain your personal data only for as long as necessary to provide the service '
                    'or as required by law. Plant identification history and favorites are stored locally '
                    'on your device. You can delete this data anytime by clearing the app data in your '
                    'device settings.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '8. Your Privacy Rights',
                content:
                    'You have the right to:\n\n'
                    '• Access your personal data\n'
                    '• Correct inaccurate data\n'
                    '• Request deletion of your data\n'
                    '• Opt-out of data collection\n\n'
                    'To exercise these rights, please contact us at support@plantidentifier.com.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '9. Changes to This Privacy Policy',
                content:
                    'We may update our Privacy Policy from time to time. We will notify you of any changes by '
                    'posting the new Privacy Policy on this page and updating the "Last Updated" date at the '
                    'bottom of this policy.\n\n'
                    'You are advised to review this Privacy Policy periodically for any changes.',
                isDarkMode: isDarkMode,
              ),
              _buildSection(
                title: '10. Contact Us',
                content:
                    'If you have any questions about this Privacy Policy, please contact us at:\n\n'
                    'Email: support@plantidentifier.com\n'
                    'Website: www.plantidentifier.com\n\n'
                    'We will respond to your inquiry within 7 business days.',
                isDarkMode: isDarkMode,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: Text(
                    'Last Updated: January 2024',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required bool isDarkMode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
              ),
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
