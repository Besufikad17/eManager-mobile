import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    this.elevation = 0,
    this.bgColor = "#ffffff", 
    this.fgColor = "#000000",
    required this.content
  });

  final double elevation;
  final String bgColor;
  final String fgColor;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      toolbarHeight: 50, // Set this height
      flexibleSpace: Container(
        color:  getColorFromHex(bgColor),
        child: Center(
          child: content,
        )
      ),
    );
  }
}
