import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final VoidCallback onPressed;
  String? bgcolor;
  double? borderRadius;
  double? borderWidth;
  String? borderColor;
  String? fgcolor;
  double? fontSize;

  MyButton({
    super.key,
    required this.text,
    required this.width,
    required this.height,
    this.bgcolor,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.fgcolor,
    this.fontSize,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: borderWidth ?? 0,
            color: borderColor != null ? getColorFromHex(borderColor!) : getColorFromHex(bgcolor!),
          ),
          backgroundColor: bgcolor != null ? getColorFromHex(bgcolor!) : Theme.of(context).iconTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
        ),
        
        child: Text(
          text, 
          style: TextStyle(
            color: fgcolor != null ? getColorFromHex(fgcolor!) : Theme.of(context).colorScheme.onPrimary,
            fontSize: fontSize
          )
        ),
      ),
    );
  }
}