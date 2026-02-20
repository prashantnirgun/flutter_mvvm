import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Information
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Contact Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildContactItem(
                      Icons.email,
                      'Email Support',
                      'info@tss.net.in',
                      Colors.blue,
                    ),
                    _buildContactItem(
                      Icons.phone,
                      'Phone Support',
                      '+91 (022) 4964 6868',
                      Colors.green,
                    ),
                    _buildContactItem(
                      Icons.chat,
                      'Live Chat',
                      'Available 24/7',
                      Colors.purple,
                    ),
                    _buildContactItem(
                      Icons.location_on,
                      'Office Address',
                      'Office No 11, Central Facility Bldg, APMC Fruit Mkt, Sector 19A, Navi Mumbai - 400705.',
                      Colors.red,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // FAQ Section
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frequently Asked Questions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildFAQItem(
                      'How do I reset my password?',
                      'Go to Login page → Click "Forgot Password" → Enter your email → Check your inbox for reset instructions.',
                    ),
                    _buildFAQItem(
                      'How can I track my order?',
                      'Go to Orders page → Select your order → Click "Track Order" to see real-time delivery status.',
                    ),
                    _buildFAQItem(
                      'What payment methods do you accept?',
                      'We accept Credit/Debit Cards, PayPal, Google Pay, Apple Pay, and Bank Transfers.',
                    ),
                    _buildFAQItem(
                      'What is your return policy?',
                      'You can return items within 30 days of delivery. Items must be unused and in original packaging.',
                    ),
                    _buildFAQItem(
                      'How long does shipping take?',
                      'Standard shipping: 3-5 business days\nExpress shipping: 1-2 business days\nInternational: 7-14 business days',
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Operating Hours
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Support Hours',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildOperatingHours(
                      'Monday - Friday',
                      '10:00 AM - 6:00 PM IST',
                    ),

                    SizedBox(height: 8),
                    Text(
                      'Emergency support available 24/7 for critical issues',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
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

  Widget _buildContactItem(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      onTap: () {
        // Add action for contact methods
      },
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(question, style: TextStyle(fontWeight: FontWeight.w500)),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(answer, style: TextStyle(color: Colors.grey[700])),
        ),
      ],
    );
  }

  Widget _buildOperatingHours(String day, String hours) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(hours, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }
}
