import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/presentation/components/bazier.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          Container(
            child: Center(
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
                    height: 70,
                  ),
                ]
              ),
            ),
          ),
        ]
      ),
    );
  }
}