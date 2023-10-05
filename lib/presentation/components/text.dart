import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  final String text;
  final double size;
  bool isBold;
  bool isUnderline;
  double width;
  String color;

  MyText({
    super.key,
    required this.text,
    required this.size,
    this.isBold = false,
    this.isUnderline = false,
    this.width = 0,
    this.color = "#000000"
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: size,
        decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
        fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
        color: getColorFromHex(color),
      ),
      textAlign: TextAlign.center
    );
  }
}
