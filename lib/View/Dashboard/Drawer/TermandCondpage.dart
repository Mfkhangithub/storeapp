import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/foother.dart';
import 'package:store_app/Provider/Alllinks.dart';

class TermCondPage extends StatefulWidget {
  const TermCondPage({super.key});

  @override
  State<TermCondPage> createState() => _TermCondPageState();
}

class _TermCondPageState extends State<TermCondPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Terms & Conditions", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryVariant,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              'Terms & Conditions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Please read these Terms and Conditions carefully before using our app.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
                
            _buildSectionTitle('1. Acceptance of Terms'),
            _buildSectionText(
              'By downloading, installing, and using this app, you agree to be bound by these Terms and Conditions. If you do not agree, you should not use the app.',
            ),
            
            SizedBox(height: 24),
                
            _buildSectionTitle('2. Changes to Terms'),
            _buildSectionText(
              'We reserve the right to modify or update these Terms and Conditions at any time. Your continued use of the app after changes are made will signify your acceptance of the new terms.',
            ),
            
            SizedBox(height: 24),
                
            _buildSectionTitle('3. User Accounts'),
            _buildSectionText(
              'You may be required to create an account to use certain features of the app. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
            ),
            
            SizedBox(height: 24),
                
            _buildSectionTitle('4. App Usage'),
            _buildSectionText(
              'You agree to use the app for lawful purposes only. You must not use the app to post or transmit any unlawful, harmful, threatening, abusive, defamatory, or obscene content.',
            ),
                
            SizedBox(height: 24),
                
            _buildSectionTitle('5. Intellectual Property'),
            _buildSectionText(
              'All content in the app, including but not limited to text, images, logos, and trademarks, is the property of the app developers or their licensors and is protected by copyright laws. You may not copy, modify, or distribute any content without permission.',
            ),
                
            SizedBox(height: 24),
                
            _buildSectionTitle('6. Limitation of Liability'),
            _buildSectionText(
              'We are not responsible for any damages or losses arising from your use of the app, including but not limited to direct, indirect, or incidental damages.',
            ),
                
            SizedBox(height: 24),
                
            _buildSectionTitle('7. Termination'),
            _buildSectionText(
              'We reserve the right to terminate or suspend your access to the app at any time, without prior notice, if you violate these Terms and Conditions.',
            ),
                
            SizedBox(height: 24),
                
            _buildSectionTitle('8. Governing Law'),
            _buildSectionText(
              'These Terms and Conditions are governed by and construed in accordance with the laws of [Your Country/State].',
            ),
                
            SizedBox(height: 24),
                
            _buildSectionTitle('9. Contact Information'),
            _buildSectionText(
              'If you have any questions about these Terms and Conditions, please contact us at support@fadiistore.com.',
            ),
            
            SizedBox(height: 24),
                
            Text(
              'By using the app, you agree to these Terms and Conditions.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Gutter(),
            Gutter(),
            Gutter(),
            FooterWidget(provider: provider)
          ],
                ),
        ),
            ));
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16),
    );
  }
}
