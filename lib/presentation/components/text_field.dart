import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyTextField extends HookWidget {
  const MyTextField({
    super.key, 
    required this.label, 
    required this.placeholder,
    required this.type,
    required this.fontSize,
    required this.height,
    required this.width,
    required this.focusColor,
    required this.borderColor,
    required this.enabledBorderWidth,
    required this.focusedBorderWidth,
    this.regexChecker,
    required this.textEditingController
  });

  final String label;
  final String placeholder;
  final String type;
  final double fontSize;
  final double width;
  final double height;
  final String focusColor;
  final String borderColor;
  final double enabledBorderWidth;
  final double focusedBorderWidth;
  final Function(String)? regexChecker;
  final TextEditingController textEditingController; 

  @override
  Widget build(BuildContext context) {
    final isError = useState(false);
    final errorMsg = useState("");

    return Padding(
      padding: const EdgeInsets.all(10),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            text: label, 
            size: fontSize,
            isBold: true,
          ),
          const SizedBox(height: 5,),
          SizedBox(
            width: width,
            height: height,
            child: TextField(  
              controller: textEditingController,
              obscureText: type == "password",
              style: TextStyle(
                fontSize: fontSize
              ),  
              decoration: InputDecoration(  
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: getColorFromHex(borderColor),
                    width: enabledBorderWidth
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: isError.value ? getColorFromHex("#FB4934") : getColorFromHex("#83A598"),
                    width: focusedBorderWidth
                  )
                ),
                contentPadding: const EdgeInsets.all(8),
                hintText: placeholder,
              ), 
              onChanged: (query) {
                if (query.isEmpty) {
                  if(type == "password") {
                    errorMsg.value = 'Password length must be between 6 and 15';
                  }else {
                    errorMsg.value = 'Please enter $type';
                  }
                } else if(!regexChecker!(query)) {
                  errorMsg.value = 'Invalid $type field';
                } else {
                  errorMsg.value = '';
                }
              },
            ),
          ),
          const SizedBox(height: 3,),
          MyText(
            text: errorMsg.value, 
            size: 10, 
            color: "#FB4934",
          )
        ]
      ),
    );
  }
}