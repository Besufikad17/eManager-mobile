import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Card(
              elevation: 12.0,
              margin: const EdgeInsets.only(
                right: 12, 
                left: 12, 
                bottom: 16.0
              ),
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0)
                  )
              ),
              child: WaveWidget(
                config: CustomConfig(
                  colors: [
                    getColorFromHex("#F0922E"),
                    getColorFromHex("#ffffff")
                  ],
                  durations: [
                    5000,
                    4000,
                  ],
                  heightPercentages: [
                    0.65,
                    0.66,
                  ],
                ),
                backgroundColor: getColorFromHex("#F0922E"),
                size: const Size(double.infinity, double.infinity),
                waveAmplitude: 0,
              ),
            ),
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
    );
  }
}