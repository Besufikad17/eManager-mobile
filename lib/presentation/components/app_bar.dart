import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    this.elevation = 0,
    this.bgColor = "#ffffff", 
    this.fgColor = "#000000",
    this.content,
    this.actions = const[]
  });

  final double elevation;
  final String bgColor;
  final String fgColor;
  final Widget? content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      actions: actions,
      toolbarHeight: 50, // Set this height
      flexibleSpace: Container(
        color:  getColorFromHex(bgColor),
        child: Center(
          child: content ?? Container(),
        )
      ),
    );
  }
}
