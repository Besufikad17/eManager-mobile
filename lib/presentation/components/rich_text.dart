import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  const MyRichText({
    super.key,
    required this.primaryColor,
    required this.baseFontSize,
    required this.children,
    required this.recognizer
  });

  final String primaryColor;
  final double baseFontSize;
  final List<MyText> children;
  final VoidCallback recognizer;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          style: TextStyle(
            color: getColorFromHex(primaryColor)
          ),
          children: [
            ...(children.map((myText) =>
              TextSpan(
                text: myText.text,
                recognizer: TapGestureRecognizer()..onTap = recognizer,
                style: TextStyle(
                    color: getColorFromHex(myText.color ?? "#000000"),
                    fontSize: myText.size
                ),
              )
            ))
          ]
        ),
    );
  }
}
