import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/presentation/components/alert.dart';
import 'package:cleanarchdemo/presentation/components/bazier.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/presentation/components/text_field.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:cleanarchdemo/utils/resources/data.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();

  LoginPage({super.key});

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
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: getColorFromHex("#F0922E")
                    ),
                    children: [
                      TextSpan(
                        text: "Clean",
                        style: TextStyle(
                          color: getColorFromHex("#000000"), 
                          fontSize: 26
                        ),
                      ),
                      const TextSpan(
                        text: "Arch",
                        style: TextStyle(
                          fontSize: 26
                        ),
                      ),
                    ]
                  ),
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
                  regexChecker: isVlaidEmail,
                  textEditingController: emailTextField,
                ),
                MyTextField(
                  label: "Password", 
                  width: 300,
                  height: 40,
                  placeholder: "password", 
                  type: "password",
                  fontSize: 14,
                  focusColor: "#000000",
                  borderColor: "#000000",
                  enabledBorderWidth: 1,
                  focusedBorderWidth: 1.5,
                  regexChecker: isValidPassword,
                  textEditingController: passwordTextField,
                ),
                const SizedBox(
                  height: 30,
                ),
                MyButton(
                  text: "Login",
                  bgcolor: "#F0922E",
                  fgcolor: "#ffffff",
                  borderWidth: 2,
                  width: 300,
                  height: 40,
                  onPressed: () {
                    if(isVlaidEmail(emailTextField.text) && isValidPassword(passwordTextField.text)) {
                      //TODO: call LoginEvent
                    }else {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return const MyAlert(
                            title: "Invalid inputs", 
                            type: AlertType.error, 
                            body: Text("Please enter valid inputs!!")
                          );
                        }
                      );
                    }
                  }
                ),
              ]
            ),
          ),
        ]
      ),
    );
  }
}