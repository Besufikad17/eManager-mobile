import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/alert.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:cleanarchdemo/utils/resources/data.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/presentation/components/bazier.dart';
import 'package:cleanarchdemo/presentation/components/rich_text.dart';
import 'package:cleanarchdemo/presentation/components/text_field.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class VerificationPage extends StatelessWidget {
  VerificationPage({
    super.key,
    required this.email
  });
  
  final String email;
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
          BlocProvider(
            create: (context) => UserBloc(locator<UserApiRepository>()),
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) => {},
              builder: (BuildContext context, UserState state) {
                if(state is UserInitial) {
                  return _buildInitial(context, context.read<UserBloc>()); 
                }else if(state is UserLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: getColorFromHex("#F0922E"),
                    ),
                  );
                } else if(state is Verified) {
                  context.router.push(ChangePasswordRoute(email: email));
                } else if(state is UserError) {
                  _buildError(context, state.message!);
                }
                return Container();
              },
            ),
          ),
        ]
       )
    );
  }

  void _buildError(BuildContext context, String message) async {
    await Future.delayed(const Duration(microseconds: 1));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 30, // Adjust the height as needed
          child: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          backgroundColor: Colors.black,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.read<UserBloc>().add(const UserLoginLoading());
          },
        ),
      ),
    );
  }

  Widget _buildInitial(BuildContext context, UserBloc bloc) {
    return  Center(
      child: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          MyRichText(
            primaryColor: "#F0922E",
            baseFontSize: 26,
            recognizer: () {},
            children: [
              MyText(
                text: "Veri",
                size: 26
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
            borderRadius: 5,
            width: 300,
            height: 40,
            onPressed: () {
              if(isValidVerificationCode(codeTextField.text)) {
                bloc.add(VerificationEvent(codeTextField.text, email));
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
          Container(
            padding: const EdgeInsets.all(10),
            child: MyRichText(
              recognizer: () {},
              baseFontSize: 14,
              children: [
                MyText(
                  text: "Check your email ",
                  size: 14,
                ),
                MyText(
                  text: email,
                  color: "#F0922E",
                  size: 14,
                ),
              ]
            ),
          )
        ]
      )
    );
  }
}
