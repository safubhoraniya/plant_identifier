import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Icon
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.local_florist,
                    size: 60,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // App Name
              const Center(
                child: Text(
                  'Plant Identifier',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Version
              Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // About Section
              _buildSection(
                title: 'About Plant Identifier',
                content:
                    'Plant Identifier is an innovative mobile application designed to help '
                    'plant enthusiasts, gardeners, and nature lovers identify plants instantly using '
                    'advanced AI-powered image recognition technology.\n\n'
                    'Simply point your camera at any plant and get instant information about its '
                    'care requirements, characteristics, and growing tips.',
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 20),

              // Features Section
              _buildSection(
                title: 'Key Features',
                content:
                    '• AI-Powered Plant Recognition\n'
                    '• Instant Plant Identification\n'
                    '• Detailed Plant Care Information\n'
                    '• Save Favorite Plants\n'
                    '• View Plant Care Tips\n'
                    '• Dark Mode Support\n'
                    '• Offline Functionality',
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 20),

              // Mission Section
              _buildSection(
                title: 'Our Mission',
                content:
                    'We aim to make plant identification accessible to everyone, helping people '
                    'learn about plants and improve their gardening skills. Our mission is to bridge '
                    'the gap between plant lovers and plant knowledge through innovative technology.',
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 20),

              // Technology Section
              _buildSection(
                title: 'Technology',
                content:
                    'Plant Identifier uses Google ML Kit Vision API for on-device image '
                    'recognition and analysis. All processing happens locally on your device, '
                    'ensuring privacy and fast performance without requiring internet connection.',
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 32),

              // Support
              _buildInfoBox(
                icon: Icons.email,
                title: 'Need Help?',
                subtitle: 'Contact our support team',
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 16),

              // Website
              _buildInfoBox(
                icon: Icons.language,
                title: 'Visit Our Website',
                subtitle: 'www.plantidentifier.com',
                isDarkMode: isDarkMode,
              ),

              const SizedBox(height: 32),

              // Copyright
              Center(
                child: Text(
                  '© 2024 Plant Identifier. All rights reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
            ),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDarkMode,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.green,
            size: 32,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
