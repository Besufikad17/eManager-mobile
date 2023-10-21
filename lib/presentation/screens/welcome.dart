import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                getColorFromHex("#F9AF44"),
                getColorFromHex("#E56E12"),
              ],
            )),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 200,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: getColorFromHex("#000000")
                      ),
                      children: [
                        TextSpan(
                          text: "Clean",
                          style: TextStyle(
                            color: getColorFromHex("#ffffff"), 
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
                    height: 70,
                  ),
                  MyButton(
                    text: "Login",
                    borderColor: "#ffffff",
                    bgcolor: "#ffffff",
                    fgcolor: "#F0922E",
                    width: 300,
                    height: 40,
                    onPressed: () {
                      context.router.push(LoginRoute());
                    }),
                  const SizedBox(
                    height: 30,
                  ),
                  MyButton(
                    text: "Register now",
                    bgcolor: "#F0922E",
                    fgcolor: "#ffffff",
                    borderWidth: 2,
                    borderColor: "#ffffff",
                    width: 300,
                    height: 40,
                    onPressed: () {
                      context.router.push(SignUpRoute());
                    }
                  ),
              ],
            ),
          )
        )
      )
    );
  }
}
