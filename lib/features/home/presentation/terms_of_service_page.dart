import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
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
                      'Terms of Service',
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
                      'Please read these Terms of Service carefully before using our E-Commerce App. By accessing or using our app, you agree to be bound by these terms.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Terms Sections
            _buildTermSection(
              '1. Account Registration',
              'You must create an account to use certain features of our app. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
            ),

            _buildTermSection(
              '2. Order Acceptance',
              'All orders are subject to acceptance and availability. We reserve the right to refuse or cancel any order for any reason, including limitations on quantities available for purchase.',
            ),

            _buildTermSection(
              '3. Pricing and Payments',
              'All prices are shown in your local currency and are subject to change without notice. You agree to pay all charges incurred through your account.',
            ),

            _buildTermSection(
              '4. Shipping and Delivery',
              'Shipping times are estimates and not guaranteed. We are not responsible for delays caused by shipping carriers or unforeseen circumstances.',
            ),

            _buildTermSection(
              '5. Returns and Refunds',
              'Returns are accepted within 30 days of delivery. Items must be unused and in original packaging. Refunds will be processed within 7-10 business days after we receive the returned item.',
            ),

            _buildTermSection(
              '6. Prohibited Uses',
              'You may not use our app:\n• For any illegal purpose\n• To harass, abuse, or harm others\n• To interfere with the app\'s security\n• To attempt to gain unauthorized access\n• To transmit viruses or malicious code',
            ),

            _buildTermSection(
              '7. Intellectual Property',
              'All content on our app, including text, graphics, logos, and software, is our property or the property of our licensors and is protected by copyright and other intellectual property laws.',
            ),

            _buildTermSection(
              '8. Termination',
              'We may terminate or suspend your account and access to the app immediately, without prior notice, for conduct that we believe violates these Terms or is harmful to other users, us, or third parties.',
            ),

            _buildTermSection(
              '9. Limitation of Liability',
              'To the fullest extent permitted by law, we shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use of or inability to use the app.',
            ),

            _buildTermSection(
              '10. Changes to Terms',
              'We reserve the right to modify these Terms at any time. We will notify you of significant changes by posting the new Terms on the app. Your continued use constitutes acceptance of the modified Terms.',
            ),

            _buildTermSection(
              '11. Governing Law',
              'These Terms shall be governed by and construed in accordance with the laws of [Your State/Country], without regard to its conflict of law provisions.',
            ),

            // Agreement Section
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Agreement',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'By using our E-Commerce App, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'If you do not agree with these terms, please do not use our application.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
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

  Widget _buildTermSection(String title, String content) {
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
            Text(content, style: TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
      ),
    );
  }
}
