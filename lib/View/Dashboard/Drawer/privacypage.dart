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
      body:    Padding(
         padding: const EdgeInsets.all(8.0),
         child: SingleChildScrollView(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gutter(),
              Gutter(),
              Gutter(),
              Center(child: Text('Privacy', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),)),
              Gutter(),
              Text('Welcome to https://fadiishop.com (the “Site”). We understand that privacy online is important to users of our Site, especially when conducting business. This statement governs our privacy policies with respect to those users of the Site (“Visitors”) who visit without transacting business and Visitors who register to transact business on the Site and make use of the various services offered by FADII Store (collectively, “Services”) (“Authorized Customers”).'),
              Gutter(),
              Text('“Personally Identifiable Information”', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              Gutter(),
              Text('refers to any information that identifies or can be used to identify, contact, or locate the person to whom such information pertains, including, but not limited to, name, address, phone number, fax number, email address, financial profiles, social security number, and credit card information. Personally Identifiable Information does not include information that is collected anonymously (that is, without identification of the individual user) or demographic information not connected to an identified individual.'),
              Gutter(),
              Gutter(),
              Text('What Personally Identifiable Information is collected?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              Gutter(),
              Text('We may collect basic user profile information from all of our Visitors. We collect the following additional information from our Authorized Customers: the name, email address, phone number, address, social media profile information,'),
              Gutter(),
              Gutter(),
              Text('What organizations are collecting the information?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              Gutter(),
              Text('In addition to our direct collection of information, our third party service vendors (such as credit card companies, clearinghouses and banks) who may provide such services as credit, insurance, and escrow services may collect this information from our Visitors and Authorized Customers. We do not control how these third parties use such information, but we do ask them to disclose how they use personal information provided to them from Visitors and Authorized Customers. Some of these third parties may be intermediaries that act solely as links in the distribution chain, and do not store, retain, or use the information given to them.'),
              Gutter(),
              Gutter(),
              Text('How does the Site use Personally Identifiable Information?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              Gutter(),
              Text('We use Personally Identifiable Information to customize the Site, to make appropriate service offerings, and to fulfill buying and selling requests on the Site. We may email Visitors and Authorized Customers about research or purchase and selling opportunities on the Site or information related to the subject matter of the Site. We may also use Personally Identifiable Information to contact Visitors and Authorized Customers in response to specific inquiries, or to provide requested information.'),
              Gutter(),
              Gutter(),
              Text('With whom may the information may be shared?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              Gutter(),
              Text('Personally Identifiable Information about Authorized Customers may be shared with other Authorized Customers who wish to evaluate potential transactions with other Authorized Customers. We may share aggregated information about our Visitors, including the demographics of our Visitors and Authorized Customers, with our affiliated agencies and third party vendors. We also offer the opportunity to “opt out” of receiving information or being contacted by us or by any agency acting on our behalf.'),
              Gutter(),
              Gutter(),
              Text('How is Personally Identifiable Information stored?', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),),
              Gutter(),
              Text('Personally Identifiable Information collected by FADII Store is securely stored and is not accessible to third parties or employees of FADII Store except for use as indicated above.'),
              Gutter(),
              Gutter(),
              Text(
            'What choices are available to Visitors regarding collection, use and distribution of the information?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'Visitors and Authorized Customers may opt out of receiving unsolicited information from or being contacted by us and/or our vendors and affiliated agencies by responding to emails as instructed, or by contacting us at fadii.shoponline1@gmail.com.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Google AdSense & DoubleClick Cookie',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'Google, as a third party vendor, uses cookies to serve ads on our Service.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Cookies',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'A cookie is a string of information that a website stores on a visitor’s computer, and that the visitor’s browser provides to the website each time the visitor returns.',
          ),
          Gutter(),
          Text(
            'We use “cookies” to collect information. You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our Service.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Are Cookies Used on the Site?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Cookies are used for a variety of reasons. We use Cookies to obtain information about the preferences of our Visitors and the services they select. We also use Cookies for security purposes to protect our Authorized Customers. For example, if an Authorized Customer is logged on and the site is unused for more than 10 minutes, we will automatically log the Authorized Customer off. Visitors who do not wish to have cookies placed on their computers should set their browsers to refuse cookies before using https://fadiishop.com, with the drawback that certain features of website may not function properly without the aid of cookies.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Cookies used by our service providers',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'Our service providers use cookies and those cookies may be stored on your computer when you visit our website. You can find more details about which cookies are used in our cookies info page.',
          ),
          SizedBox(height: 16.0),
          Text(
            'How does FADII Store use login information?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'FADII Store uses login information, including, but not limited to, IP addresses, ISPs, and browser types, browser version, pages visited, date and time of visit, to analyze trends, administer the Site, track a user’s movement and use, and gather broad demographic information.',
          ),
          SizedBox(height: 16.0),
          Text(
            'What partners or service providers have access to Personally Identifiable Information from Visitors and/or Authorized Customers on the Site?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'FADII Store has entered into and will continue to enter into partnerships and other affiliations with a number of vendors. Such vendors may have access to certain Personally Identifiable Information on a need to know the basis for evaluating Authorized Customers for service eligibility. Our privacy policy does not cover their collection or use of this information.',
          ),
          SizedBox(height: 16.0),
          Text(
            'How does the Site keep Personally Identifiable Information secure?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'All of our employees are familiar with our security policy and practices. The Personally Identifiable Information of our Visitors and Authorized Customers is only accessible to a limited number of qualified employees who are given a password in order to gain access to the information. We audit our security systems and processes on a regular basis. Sensitive information, such as credit card numbers or social security numbers, is protected by encryption protocols, in place to protect information sent over the Internet. While we take commercially reasonable measures to maintain a secure site, electronic communications and databases are subject to errors, tampering, and break-ins, and we cannot guarantee or warrant that such events will not take place and we will not be liable to Visitors or Authorized Customers for any such occurrences.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'How can Visitors correct any inaccuracies in Personally Identifiable Information?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'Visitors and Authorized Customers may contact us to update Personally Identifiable Information about them or to correct any inaccuracies by emailing us at fadii.shoponline1@gmail.com.',
          ),
          SizedBox(height: 16.0),
          Text(
            'Can a Visitor delete or deactivate Personally Identifiable Information collected by the Site?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'We provide Visitors and Authorized Customers with a mechanism to delete/deactivate Personally Identifiable Information from the Site’s database by contacting. However, because of backups and records of deletions, it may be impossible to delete a Visitor’s entry without retaining some residual information. An individual who requests to have Personally Identifiable Information deactivated will have this information functionally deleted, and we will not sell, transfer, or use Personally Identifiable Information relating to that individual in any way moving forward.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Your rights',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'These are summarized rights that you have under data protection law',
          ),
          Gutter(),
          Text(
            'The right to access\nThe right to rectification\nThe right to erasure\nThe right to restrict processing\nThe right to object to processing\nThe right to data portability\nThe right to complain to a supervisory authority\nThe right to withdraw consent',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Children’s Privacy',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'Our Service does not address “Children”, anyone under the age of 18 years, and we do not knowingly collect personally identifiable information from children under 18 years.',
          ),
          SizedBox(height: 16.0),
          Text(
            'If you are a parent or guardian and you are aware that your child has provided us with Personal Information, please get in touch with us immediately in the contact details provided. If we come to know that children below 18 years have provided personal information, we will delete the information from our servers immediately.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Compliance With Laws',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'Disclosure of Personally Identifiable Information to comply with the law. We will disclose Personally Identifiable Information in order to comply with a court order or subpoena or a request from a law enforcement agency to release information. We will also disclose Personally Identifiable Information when reasonably necessary to protect the safety of our Visitors and Authorized Customers.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'What happens if the Privacy Policy Changes?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'We will let our Visitors and Authorized Customers know about changes to our privacy policy by posting such changes on the Site. However, if we are changing our privacy policy in a manner that might cause disclosure of Personally Identifiable Information that a Visitor or Authorized Customer has previously requested not be disclosed, we will contact such Visitor or Authorized Customer to allow such Visitor or Authorized Customer to prevent such disclosure.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Links',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'https://fadiishop.com contains links to other websites. Please note that when you click on one of these links, you are moving to another website. We encourage you to read the privacy statements of these linked sites as their privacy policies may differ from ours.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Contact Us',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
          ),
          Gutter(),
          Text(
            'If you have any questions about this Privacy Policy, please contact us at fadii.shoponline1@gmail.com.',
          ),
          Gutter(),
          Gutter(),
          Text(
            'Last Updated: October 16, 2023',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
              Gutter(),
              Divider(),
              Gutter(),
              FooterWidget(provider: provider),
            ],
           ),
         ),
       )
       ,
    );
  }
}