import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/presentation/components/alert.dart';
import 'package:cleanarchdemo/presentation/components/bazier.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/presentation/components/rich_text.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/presentation/components/text_field.dart';
import 'package:cleanarchdemo/utils/resources/data.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final TextEditingController fullNameTextField = TextEditingController();
    final TextEditingController emailTextField = TextEditingController();
    final TextEditingController phoneNumberTextField = TextEditingController();
    final TextEditingController passwordTextField = TextEditingController();

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -height * .25,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  MyRichText(
                      primaryColor: "#F0922E",
                      baseFontSize: 26,
                      children: [
                        MyText(
                          text: "Regis",
                          size: 26,
                          color: "#000000",
                        ),
                        MyText(
                            text: "ter",
                            size: 26,
                            color: "#F0922E",
                        )
                      ]
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                      label: "Full name",
                      placeholder: "John Doe",
                      type: "text",
                      fontSize: 14,
                      height: 40,
                      width: 300,
                      focusColor: "#000000",
                      borderColor: "#000000",
                      enabledBorderWidth: 1,
                      focusedBorderWidth: 1.5,
                      textEditingController: fullNameTextField
                  ),
                  MyTextField(
                      label: "Email",
                      placeholder: "JohnDoe@gmail.com",
                      type: "text",
                      fontSize: 14,
                      height: 40,
                      width: 300,
                      focusColor: "#000000",
                      borderColor: "#000000",
                      enabledBorderWidth: 1,
                      focusedBorderWidth: 1.5,
                      textEditingController: emailTextField
                  ),
                  MyTextField(
                      label: "Phone Number",
                      placeholder: "09xxxxxx",
                      type: "text",
                      fontSize: 14,
                      height: 40,
                      width: 300,
                      focusColor: "#000000",
                      borderColor: "#000000",
                      enabledBorderWidth: 1,
                      focusedBorderWidth: 1.5,
                      textEditingController: phoneNumberTextField
                  ),
                  MyTextField(
                      label: "Password",
                      placeholder: "password",
                      type: "password",
                      fontSize: 14,
                      height: 40,
                      width: 300,
                      focusColor: "#000000",
                      borderColor: "#000000",
                      enabledBorderWidth: 1,
                      focusedBorderWidth: 1.5,
                      textEditingController: passwordTextField
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButton(
                      text: "Register",
                      bgcolor: "#F0922E",
                      fgcolor: "#ffffff",
                      borderWidth: 2,
                      width: 300,
                      height: 40,
                      onPressed: () {
                        if(isVlaidEmail(emailTextField.text) && isValidPassword(passwordTextField.text)) {

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
                  const SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      context.router.push(LoginRoute());
                    },
                    child: MyText(
                      text: "Already have account?",
                      size: 12,
                      color: "#F0922E",
                      isUnderline: true,
                    ),
                  )
                ],
              ),
            )
          ]
        ),
    );
  }
}
