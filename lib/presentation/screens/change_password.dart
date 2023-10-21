import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/presentation/components/bazier.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/presentation/components/rich_text.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/presentation/components/text_field.dart';
import 'package:cleanarchdemo/utils/resources/data.dart';
import 'package:flutter/material.dart';

@RoutePage()
class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final TextEditingController passwordTextField = TextEditingController();
  final TextEditingController cpasswordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; 

    return Scaffold(
       body: Stack(
        children: [
          Positioned(
            top: -height * .15,
            right: -MediaQuery.of(context).size.width * .4,
            child: const BezierContainer()
          ),
         Center(
          child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            MyRichText(
              primaryColor: "#F0922E",
              baseFontSize: 26,
              children: [
                MyText(
                  text: "Change",
                  size: 26,
                  color: "#000000",
                ),
                MyText(
                    text: "Password",
                    size: 26,
                    color: "#F0922E",
                )
              ]
            ),
            const SizedBox(
              height: 50,
            ),
            MyTextField(
              label: "New password", 
              width: 300,
              height: 40,
              placeholder: "no 1-8", 
              type: "email",
              fontSize: 14,
              focusColor: "#000000",
              borderColor: "#000000",
              enabledBorderWidth: 1,
              focusedBorderWidth: 1.5,
              regexChecker: isValidPassword,
              textEditingController: passwordTextField,
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextField(
              label: "Confirm password", 
              width: 300,
              height: 40,
              placeholder: "don't forget the new one!!", 
              type: "email",
              fontSize: 14,
              focusColor: "#000000",
              borderColor: "#000000",
              enabledBorderWidth: 1,
              focusedBorderWidth: 1.5,
              regexChecker: isValidPassword,
              textEditingController: passwordTextField,
            ),
            const SizedBox(
              height: 15,
            ),
            MyButton(
              text: "Done",
              borderColor: "#F0922E",
              bgcolor: "#F0922E",
              fgcolor: "#ffffff",
              borderWidth: 2,
              width: 300,
              height: 40,
              onPressed: () {
               
              }
            )
           ]
          )
         )
        ]
      )
    ); 
  }
}