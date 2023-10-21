import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/presentation/components/bazier.dart';
import 'package:cleanarchdemo/presentation/components/rich_text.dart';
import 'package:cleanarchdemo/presentation/components/text_field.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/utils/resources/data.dart';

@RoutePage()
class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  final TextEditingController emailTextField = TextEditingController();

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
                  text: "Forgot",
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
              label: "Email", 
              width: 300,
              height: 40,
              placeholder: "xyz@email.com", 
              type: "email",
              fontSize: 14,
              focusColor: "#000000",
              borderColor: "#000000",
              enabledBorderWidth: 1,
              focusedBorderWidth: 1.5,
              regexChecker: isValidEmail,
              textEditingController: emailTextField,
            ),
            const SizedBox(
              height: 30,
            ),
            MyButton(
              text: "Recover",
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
