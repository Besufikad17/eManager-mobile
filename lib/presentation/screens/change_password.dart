import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/alert.dart';
import 'package:cleanarchdemo/presentation/components/bazier.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/presentation/components/rich_text.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:cleanarchdemo/presentation/components/text_field.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:cleanarchdemo/utils/resources/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({
    super.key,
    required this.email
  });

  final String email;
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
                } else if(state is PasswordChanged) {
                  context.router.push(LoginRoute());
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
    return Center(
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
          height: 15,
        ),
        MyTextField(
          label: "Confirm password", 
          type: "password",
          width: 300,
          height: 40,
          placeholder: "don't forget the new one!!", 
          fontSize: 14,
          focusColor: "#000000",
          borderColor: "#000000",
          enabledBorderWidth: 1,
          focusedBorderWidth: 1.5,
          regexChecker: isValidPassword,
          textEditingController: cpasswordTextField,
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
            if(passwordTextField.text == cpasswordTextField.text) {
              if(isValidPassword(passwordTextField.text)) {
                bloc.add(ChangePasswordEvent(null, email, passwordTextField.text));
              } else {
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
            } else {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return const MyAlert(
                    title: "Invalid inputs", 
                    type: AlertType.error, 
                    body: Text("Confirm your password properly!!")
                  );
                }
              );
            }
          }
        )
        ]
      )
    );
  }
}