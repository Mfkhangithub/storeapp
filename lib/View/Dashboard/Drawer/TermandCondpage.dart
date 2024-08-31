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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gutter(),
              Gutter(),
              Gutter(),
              Center(
                child: Text(
                  'Terms of Use',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Gutter(),
              Text(
                'These Terms govern your access to and usage of all content, products, and services available at the FADII Store website (the “Service”) operated by FADII Store (“us”, “we”, or “our”).',
              ),
              Gutter(),
              Text(
                'Your access to our services is subject to your acceptance, without modification, of all of the terms and conditions contained herein and all other operating rules and policies published by us.',
              ),
              Gutter(),
              Text(
                'Please read the Agreement carefully before accessing or using our Services. By accessing or using any part of our Services, you agree to be bound by these Terms. If you do not agree to any part of the terms of the Agreement, then you may not access or use our Services.',
              ),
              Gutter(),
              Text(
                'Intellectual Property',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'The Agreement does not transfer from Us to you any of our or third-party intellectual property, and all right, title, and interest in and to such property will remain (as between the parties) solely with FADII Store and its licensors.',
              ),
              Gutter(),
              Text(
                'Third-Party Services',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'In using the Services, you may use third-party services, products, software, embeds, or applications developed by a third party (“Third-Party Services”).',
              ),
              Gutter(),
              Text(
                'If you use any Third-Party Services, you understand that:',
              ),
              Gutter(),
              Text(
                'Any use of a Third-Party Service is at your own risk, and we shall not be responsible or liable to anyone for Third-Party websites or Services. You acknowledge and agree that we shall not be responsible or liable for any damage or loss caused or alleged to be caused by or in connection with the use of any such content, goods, or services available on or through any such websites or services.',
              ),
              Gutter(),
              Text(
                'Accounts',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'Where use of any part of our Services requires an account, you agree to provide us with complete and accurate information when you register for an account.',
              ),
              Gutter(),
              Text(
                'You will be solely responsible and liable for any activity that occurs under your account. You are responsible for keeping your account information up-to-date and for keeping your password secure.',
              ),
              Gutter(),
              Text(
                'You are responsible for maintaining the security of your account that you use to access the Service. You shall not share or misuse your access credentials. You must notify us immediately of any unauthorized uses of your account or upon becoming aware of any other breach of security.',
              ),
              Gutter(),
              Text(
                'Links To Other Websites',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'Our Service may contain links to third-party websites or services that are not owned or controlled by FADII Store.',
              ),
              Gutter(),
              Text(
                'FADII Store assumes no responsibility for the content, privacy policies, or practices of any third-party websites or services. FADII Store shall also not be responsible or liable, directly or indirectly, for any damage or loss caused or alleged to be caused by or in connection with the use of or reliance on any such content, goods, or services available on or through any such websites or services.',
              ),
              Gutter(),
              Text(
                'We advise you to read the terms and conditions and privacy policies of any third-party websites or services that you visit.',
              ),
              Gutter(),
              Text(
                'Termination',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'We may terminate or suspend your access to all or any part of our Services at any time, with or without cause, with or without notice, effective immediately.',
              ),
              Gutter(),
              Text(
                'If you wish to terminate the Agreement or your FADII Store account, you may simply discontinue using our Services.',
              ),
              Gutter(),
              Text(
                'All provisions of the Agreement which by their nature should survive termination shall survive termination, including, without limitation, ownership provisions, warranty disclaimers, indemnity, and limitations of liability.',
              ),
              Gutter(),
              Text(
                'Disclaimer',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'Our Services are provided on an “AS IS” and “AS AVAILABLE” basis. FADII Store and its suppliers and licensors hereby disclaim all warranties of any kind, express or implied, including, without limitation, the warranties of merchantability, fitness for a particular purpose, and non-infringement. Neither FADII Store, nor its suppliers and licensors, makes any warranty that our Services will be error-free or that access thereto will be continuous or uninterrupted.',
              ),
              Gutter(),
              Text(
                'You understand that you download from, or otherwise obtain content or services through, our Services at your own discretion and risk.',
              ),
              Gutter(),
              Text(
                'Jurisdiction and Applicable Law',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'Except to the extent any applicable law provides otherwise, the Agreement and any access to or use of our Services will be governed by the laws of New York.',
              ),
              Gutter(),
              Text(
                'The proper venue for any disputes arising out of or relating to the Agreement and any access to or use of our Services will be the state and federal courts located in New York.',
              ),
              Gutter(),
              Text(
                'Changes',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'FADII Store reserves the right, at our sole discretion, to modify or replace these Terms at any time.',
              ),
              Gutter(),
              Text(
                'If we make changes that are material, we will let you know by posting on our website, or by sending you an email or other communication before the changes take effect. The notice will designate a reasonable period of time after which the new terms will take effect.',
              ),
              Gutter(),
              Text(
                'We will try to provide at least 30 days notice prior to the effective changes. If you disagree with our changes, then you should stop using our Services within the designated notice period, or once the changes become effective.',
              ),
              Gutter(),
              Text(
                'Your continued use of our Services will be subject to the new terms.',
              ),
              Gutter(),
              Text(
                'Contact Us',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Gutter(),
              Text(
                'If you have any questions about these Terms of Use, please contact us at fadii.store@gmail.com.',
              ),
              Gutter(),
              Text(
                'Last Updated: August 23, 2024',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Gutter(),
              Divider(),
              Gutter(),
              FooterWidget(provider: provider),
            ],
          ),
        ),
      ),
    );
  }
}
