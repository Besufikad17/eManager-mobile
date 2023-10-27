import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyMenu extends HookWidget {
  MyMenu({
    super.key,
    required this.options,
    required this.onTap
  });

  final List<String> options;
  Function(String) onTap;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...(options.map((option){
            return Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () {
                  onTap(option);
                },
                child: Container(
                  width: 400,
                  height: 60,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: getColorFromHex("#ffffff"),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 1,
                        blurStyle: BlurStyle.outer
                      )
                    ]
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: MyText(text: option, size: 14)
                  ),
                )
              ),
            );
          }))
        ],
      ),
    );
  }
}