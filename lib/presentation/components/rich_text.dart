import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  const MyRichText({
    super.key,
    this.primaryColor,
    required this.baseFontSize,
    required this.children,
    required this.recognizer
  });

  final String? primaryColor;
  final double baseFontSize;
  final List<MyText> children;
  final VoidCallback recognizer;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          style: TextStyle(
            color: primaryColor != null ? getColorFromHex(primaryColor!) : 
                   Theme.of(context).colorScheme.onPrimary,
          ),
          children: [
            ...(children.map((myText) =>
              TextSpan(
                text: myText.text,
                recognizer: TapGestureRecognizer()..onTap = recognizer,
                style: TextStyle(
                    color: myText.color != null ? getColorFromHex(myText.color!) : 
                           Theme.of(context).colorScheme.onPrimary,
                    fontSize: myText.size
                ),
              )
            ))
          ]
        ),
    );
  }
}
