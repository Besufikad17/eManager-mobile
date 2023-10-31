import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  MyAppBar({
    super.key,
    this.elevation = 0,
    required this.title,
    this.bgColor, 
    this.fgColor,
    this.content,
    this.isCentered = true,
    this.actions = const[]
  });

  final double elevation;
  final String title;
  final String? bgColor;
  final String? fgColor;
  final Widget? content;
  final List<Widget> actions;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      actions: actions,
      toolbarHeight: 50, 
      title: MyText(text: title, size: 16, isBold: true, style: Theme.of(context).textTheme.headlineSmall,),
      flexibleSpace: Container(
        color:  bgColor != null ? getColorFromHex(bgColor!) : Theme.of(context).colorScheme.primary,
        child: Center(
          child: content ?? Container(),
        ) 
      ),
    );
  }
}
