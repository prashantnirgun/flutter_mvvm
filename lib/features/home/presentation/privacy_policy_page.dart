import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Last Updated: January 1, 2024',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our E-Commerce App.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Information Collection
            _buildPolicySection('1. Information We Collect', [
              'Personal Information: Name, email address, phone number, shipping address, billing information.',
              'Payment Information: Credit/debit card details, PayPal account information (securely processed by our payment partners).',
              'Usage Data: IP address, browser type, device information, pages visited, time spent on pages.',
              'Cookies and Tracking: We use cookies to enhance your shopping experience and analyze site traffic.',
            ]),

            // How We Use Information
            _buildPolicySection('2. How We Use Your Information', [
              'To process and fulfill your orders and transactions.',
              'To provide customer support and respond to your inquiries.',
              'To send you important updates about your orders and account.',
              'To personalize your shopping experience and show relevant products.',
              'To improve our app functionality and user experience.',
              'To detect and prevent fraud and unauthorized activities.',
              'To comply with legal obligations and enforce our terms.',
            ]),

            // Information Sharing
            _buildPolicySection('3. Information Sharing', [
              'We do not sell your personal information to third parties.',
              'We may share information with trusted service providers (payment processors, shipping carriers).',
              'We may disclose information when required by law or to protect our rights.',
              'In case of business transfer (merger, acquisition), your information may be transferred.',
            ]),

            // Data Security
            _buildPolicySection('4. Data Security', [
              'We implement industry-standard security measures to protect your data.',
              'All sensitive information is encrypted using SSL technology.',
              'Regular security assessments and monitoring are conducted.',
              'Access to personal information is restricted to authorized personnel only.',
            ]),

            // Your Rights
            _buildPolicySection('5. Your Rights', [
              'Access and review your personal information.',
              'Update or correct inaccurate information.',
              'Request deletion of your personal data.',
              'Opt-out of marketing communications.',
              'Data portability - request a copy of your data.',
            ]),

            // Contact Information
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'If you have any questions about this Privacy Policy, please contact us:',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text('Email: info@tss.net.in'),
                    Text('Phone: +91 (022) 4964 6868'),
                    Text(
                      'Address: Office No 11, Central Facility Bldg, APMC Fruit Mkt, Sector 19A, Navi Mumbai - 400705.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, List<String> points) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: points
                  .map(
                    (point) => Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '• ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Expanded(child: Text(point)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
