import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/GetInTouch.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Provider/Alllinks.dart';
import 'package:store_app/View/Dashboard/Drawer/TermandCondpage.dart';
import 'package:store_app/View/Dashboard/Drawer/aboutuspage.dart';
import 'package:store_app/View/Dashboard/Drawer/becomeapage.dart';
import 'package:store_app/View/Dashboard/Drawer/contactuspage.dart';
import 'package:store_app/View/Dashboard/Drawer/privacypage.dart';
import 'package:store_app/View/Dashboard/dashboard.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
final provider = Provider.of<ProviderController>(context, listen: false);
          return Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(),
                    child: Center(child: Text('FADII Store', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),)),
                //     CachedNetworkImage(
                //   imageUrl: " ",
                // )
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardScreen()),);
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.home,
                    ),
                    title: Text("Home"),
                  ),
                ),
                 const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                    GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsPage()),);
                  },
                  child: const ListTile(
                    leading: Icon(FontAwesomeIcons.phone),
                    title: Text("Contact"),
                  ),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage()),);
                  },
                  child: const ListTile(
                    leading: Icon(FontAwesomeIcons.person),
                    title: Text("About Us"),
                  ),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BecomePage()),);
                  },
                  child: const ListTile(
                    leading: Icon(FontAwesomeIcons.sellcast),
                    title: Text("Become a Vendor"),
                  ),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                   GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TermCondPage()),);
                  },
                  child: const ListTile(
                    leading: Icon(FontAwesomeIcons.book),
                    title: Text("Term & Condition"),
                  ),
                ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                   GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPage()),);
                  },
                  child: const ListTile(
                    leading: Icon(FontAwesomeIcons.key),
                    title: Text("Privacy Policy"),
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                
                //   },
                //   child: const ListTile(
                //     leading: Icon(Icons.camera_alt),
                //     title: Text(""),
                //   ),
                // ),
                const Divider(
                  thickness: 0.1,
                  color: AppColors.textColor,
                  indent: 20,
                  endIndent: 20,
                ),
                // const Divider(
                //   thickness: 0.1,
                //   color: AppColors.textColor,
                //   indent: 20,
                //   endIndent: 20,
                // ),
                // GestureDetector(
                //   onTap: () {
                   
                //   },
                //   child: const ListTile(
                //     leading: Icon(FontAwesomeIcons.envelope),
                //     title: Text("Offers"),
                //   ),
                // ),
              
                // const Divider(
                //   thickness: 0.1,
                //   color: AppColors.textColor,
                //   indent: 20,
                //   endIndent: 20,
                // ),
               
                // const Divider(
                //   thickness: 0.1,
                //   color: AppColors.textColor,
                //   indent: 20,
                //   endIndent: 20,
                // ),
                const Gutter(),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ... social media icons
                    SocialMediaIcon(
                      ontap: () async {
                        await provider.launchFacebookURL();
                      },
                      icon: FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                    SocialMediaIcon(
                      ontap: () async {
                        await provider.launchyoutubeURL();
                      },
                      icon: FontAwesomeIcons.youtube,
                      color: AppColors.red,
                    ),
                       SocialMediaIcon(
                      ontap: () async {
                        await provider.launchInstagramURL();
                      },
                      icon: FontAwesomeIcons.instagram,
                      color: AppColors.red,
                    ),      
                    ],
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //      SocialMediaIcon(
                //         icon: FontAwesomeIcons.weixin,
                //         color: AppColors.accentColor,
                //         ontap: () async {
                //         provider.launchvchatURL();
                //         },
                //         ),
                //       SocialMediaIcon(
                //         ontap: () async {
                //           await provider.launchtwiURL();
                //         },
                //       icon: FontAwesomeIcons.twitter,
                //       color: Colors.blue,
                //     ),
                //      SocialMediaIcon(
                //        ontap: () async {
                //           await provider.launcholxURL();
                //         },
                //       icon: FontAwesomeIcons.o,
                //       color: Colors.green,
                //     ),
                //      SocialMediaIcon(
                //        ontap: () async {
                //           await provider.launchlinkURL();
                //         },
                //       icon: FontAwesomeIcons.linkedin,
                //       color: AppColors.darkblue,
                //     ),
                //       SocialMediaIcon(
                //           icon: FontAwesomeIcons.ebay,
                //           color: AppColors.textColor,
                //            ontap: () async {
                //           await provider.launchebyURL();
                //         },
                //           ),
                //       GestureDetector(
                //         onTap: ()async{
                //          await provider.launchaliURL();
                //         },
                //         child: CircleAvatar(
                //           backgroundImage: AssetImage("assets/aliexpres.png"),
                //         radius: 13,),
                //       ),
                    
                //   ],

                // ),
                //    Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //       SocialMediaIcon(
                //           icon: FontAwesomeIcons.amazon,
                //           color: Colors.black,
                //            ontap: () async {
                //           await provider.launchAmURL();
                //         },
                //           ),
                //       SocialMediaIcon(
                //           icon: FontAwesomeIcons.d,
                //           color: AppColors.orange,
                //            ontap: () async {
                //           await provider.launchDrazURL();
                //         },
                //           ),
                //           SocialMediaIcon(
                //         ontap: () async {
                //           await provider.launchpriURL();
                //         },
                //         icon: FontAwesomeIcons.pinterest,
                //         color: AppColors.red,
                //       ),
                //       SocialMediaIcon(
                //          ontap: () async {
                //           await provider.launchwhatsappURLwithphone("");
                //         },
                //         icon: FontAwesomeIcons.whatsapp,
                //         color: AppColors.accentColor,
                //       ),
                   
                //       ],
                // ),
             
                const Gutter(),
                Center(
                  child: Text(
                          "Copyright©2024 ",
                          style: TextStyle(fontSize: 12),
                        ),
                ),
                      Center(
                    child: Text(" All rights reserved",
                        style: TextStyle(fontSize: 12))),
                const Gutter()
              ],
            ),
          );
        } 
  }
