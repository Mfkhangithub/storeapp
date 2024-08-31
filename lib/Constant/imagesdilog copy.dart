import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String link;
  const ImageDialog({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Image.network(link, width: 250, height: 250, fit: BoxFit.cover,),
    );
  }
}