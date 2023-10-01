import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key, 
    this.bgColor = "#ffffff", 
    this.fgColor = "#000000"
  });

  final String bgColor;
  final String fgColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 50, // Set this height
      flexibleSpace: Container(
        color:  getColorFromHex(bgColor),
        child: const Center()
      ),
    );
  }
}
