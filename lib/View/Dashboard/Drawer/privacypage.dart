import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/foother.dart';
import 'package:store_app/Provider/Alllinks.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({super.key});

  @override
  State<PrivacyPage> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<PrivacyPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Privacy Policy", style: TextStyle(color: Colors.white),),
      backgroundColor: AppColors.primaryVariant),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Last Updated: September 4, 2024',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 24),
            Text(
              '1. Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'At FADII Store, we value your privacy. This Privacy Policy outlines the types of '
              'information we collect, how we use it, and how we ensure your data is protected.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '2. Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We may collect the following information when you use our app:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Personal Information: Name, email address, phone number.'),
            _buildBulletPoint(
                'Profile Information: Images you upload, titles, and other details.'),
            _buildBulletPoint(
                'Location Data: GPS data, addresses, or other location information.'),
            _buildBulletPoint('Device Information: IP address, operating system, and browser type.'),
            _buildBulletPoint(
                'Usage Data: Information on how you interact with the app, such as the pages you visit.'),
            SizedBox(height: 16),
            Text(
              '3. How We Use Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We use the collected data to improve your experience and the overall quality of our services. '
              'This may include:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Personalizing content and services.'),
            _buildBulletPoint('Providing customer support.'),
            _buildBulletPoint('Improving app performance and user experience.'),
            _buildBulletPoint('Marketing and promotional purposes.'),
            _buildBulletPoint('Ensuring the security of your data and our app.'),
            SizedBox(height: 16),
            Text(
              '4. Sharing Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We do not share your personal information with third parties except as needed for the '
              'following situations:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('With service providers to process your data on our behalf.'),
            _buildBulletPoint(
                'To comply with legal obligations or respond to lawful requests by public authorities.'),
            _buildBulletPoint('To protect the rights and safety of our users and app.'),
            SizedBox(height: 16),
            Text(
              '5. Data Security',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We implement appropriate security measures to protect your data from unauthorized access, '
              'disclosure, or destruction. However, no security measures are perfect, and we cannot guarantee '
              'the absolute security of your data.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '6. Your Rights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'You have the right to access, correct, or delete your personal data. If you wish to exercise '
              'any of these rights, please contact us at support@fadiistore.com.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '7. Changes to This Privacy Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'We may update this Privacy Policy from time to time. Any changes will be posted on this page, '
              'and we encourage you to review it periodically.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '8. Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'If you have any questions about this Privacy Policy, please contact us at '
              'support@fadiistore.com.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Thank you for trusting FADII Store with your information!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Gutter(),
            Divider(),
            Gutter(),
            FooterWidget(provider: provider)
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ', style: TextStyle(fontSize: 16)),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}