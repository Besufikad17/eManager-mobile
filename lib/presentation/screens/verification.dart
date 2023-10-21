import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/utils/resources/data.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/presentation/components/bazier.dart';
import 'package:cleanarchdemo/presentation/components/rich_text.dart';
import 'package:cleanarchdemo/presentation/components/text_field.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';

@RoutePage()
class VerificationPage extends StatelessWidget {
  VerificationPage({
    super.key
  });

  final TextEditingController codeTextField = TextEditingController();  

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
                    text: "Veri",
                    size: 26,
                    color: "#000000",
                  ),
                  MyText(
                    text: "fy",
                    size: 26,
                    color: "#F0922E",
                  )
                ]
              ),
              const SizedBox(height: 20,),
              MyTextField(
                label: "Code",
                placeholder: "verification code",
                type: "text", 
                fontSize: 14, 
                height: 40, 
                width: 300, 
                focusColor: "#000000", 
                borderColor: "#000000", 
                enabledBorderWidth: 1,
                focusedBorderWidth: 1.5, 
                textEditingController: codeTextField,
                regexChecker: isValidVerificationCode,
              ),
              const SizedBox(height: 15,),
              MyButton(
                text: "Verify",
                borderColor: "#F0922E",
                bgcolor: "#F0922E",
                fgcolor: "#ffffff",
                borderWidth: 2,
                width: 300,
                height: 40,
                onPressed: () {
                  print(codeTextField.text);
                  context.router.push(ChangePasswordRoute());
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
