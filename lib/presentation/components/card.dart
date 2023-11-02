import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    super.key,
    required this.image,
    required this.fullName    
  });

  final String image;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(image),
      title: MyText(text: fullName, size: 13),
    );
  }
}