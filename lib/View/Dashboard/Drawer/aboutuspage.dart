import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:provider/provider.dart';
import 'package:store_app/Constant/colorpage.dart';
import 'package:store_app/Constant/foother.dart';
import 'package:store_app/Provider/Alllinks.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("About Us", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryVariant,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gutter(),
              Gutter(),
              Gutter(),
              Text(
                'Welcome to the FADII Store, your premier destination for a diverse range of high-quality cosmetics and skincare products. We are committed to bringing you the finest brands from around the world, ensuring that you receive products that meet the highest standards of beauty and care. Whether you’re looking for the latest trends or timeless classics, the FADII Store is your go-to source for all things beauty.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'Mission',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'At FADII Store, our mission is to empower individuals to look and feel their best by providing access to a wide selection of top-tier cosmetic brands. We believe that beauty is personal, and our goal is to cater to every unique need and preference with products that are as effective as they are luxurious.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'Vision',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'Our vision is to become the leading retailer of cosmetic products, recognized for our commitment to quality, innovation, and customer satisfaction. We aim to create a seamless shopping experience where beauty enthusiasts can discover and explore the products that best suit their individual styles and needs.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'The Essence of Beauty',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'At FADII Store, we believe in “The Essence of Beauty.” Every product we offer is carefully curated to ensure it meets our standards of excellence. From skincare essentials to the latest in makeup, we are dedicated to providing products that enhance natural beauty and promote well-being.',
              ),
              Gutter(),
              Gutter(),
              Text(
                'Stay Connected',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
              ),
              Gutter(),
              Text(
                'The FADII Store is more than just a beauty retailer; we are a community that celebrates diversity, inclusivity, and the transformative power of beauty. Join us on this journey and stay connected with the latest trends, tips, and products that make you shine.',
              ),
              Gutter(),
              Text(
                'Explore our carefully curated range of cosmetics and skincare products and discover the essence of beauty with FADII Store. We are here to make you look and feel your best every day.',
              ),
              Gutter(),
              Gutter(),
              Divider(),
              Gutter(),
              Gutter(),
              FooterWidget(provider: provider),
            ],
          ),
        ),
      ),
    );
  }
}
