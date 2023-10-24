import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MySetting extends HookWidget {
  const MySetting({
    super.key,
    required this.title,
    required this.options
  });

  final String title;
  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    var shadowColor = useState(Colors.grey.shade600);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        onHover: (isHovered) {
          shadowColor.value = isHovered ? Colors.black : Colors.grey.shade600;
        },
        child: Container(
          width: 400,
          height: 60,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: getColorFromHex("#ffffff"),
            boxShadow: [
              BoxShadow(
                color: shadowColor.value,
                spreadRadius: 1,
                blurRadius: 1,
                blurStyle: BlurStyle.outer
              )
            ]
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                MyText(
                  text: title, 
                  size: 14,
                ),
                const SizedBox(height: 10,),
                ...(options.map((option) {
                  return (
                    option
                  );
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}