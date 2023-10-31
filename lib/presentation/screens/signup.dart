import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
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
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController fullNameTextField = TextEditingController();
  final TextEditingController emailTextField = TextEditingController();
  final TextEditingController phoneNumberTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -height * .25,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()
            ),
            BlocProvider(
              create: (context) => UserBloc(locator<UserApiRepository>())..add(const UserLoginLoading()),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) => {},
                builder: (BuildContext context, UserState state) {
                  if(state is UserInitial) {
                    return _buildForm(context, context.read<UserBloc>());
                  }else if(state is UserLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: getColorFromHex("#F0922E"),
                      ),
                    );
                  }else if(state is UserLoaded) {
                    locator<LocalStorageRepositoryImpl>().addLocalResponseData(
                      LocalResponseData(
                        LocalUser(
                          state.user.id,
                          state.user.fname,
                          state.user.lname,
                          state.user.email,
                          state.user.phoneNumber,
                          state.user.createdAt,
                          state.user.updatedAt
                        ), 
                        state.token
                      )
                    );
                    context.router.push(const HomeRoute());
                  }else if(state is UserError) {
                    _buildError(context, state.message!);
                  }
                  return Container();
                }
              )
            )
          ]
        ),
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
            context.read<UserBloc>().add(const UserRegisterLoading());
          },
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, UserBloc bloc) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          MyRichText(
              primaryColor: "#F0922E",
              baseFontSize: 26,
              recognizer: () {},
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
              type: "first name",
              fontSize: 14,
              height: 40,
              width: 300,
              focusColor: "#000000",
              borderColor: "#000000",
              enabledBorderWidth: 1,
              focusedBorderWidth: 1.5,
              textEditingController: fullNameTextField,
              regexChecker: isValidFullName,
          ),
          MyTextField(
            label: "Email",
            placeholder: "JohnDoe@gmail.com",
            type: "email",
            fontSize: 14,
            height: 40,
            width: 300,
            focusColor: "#000000",
            borderColor: "#000000",
            enabledBorderWidth: 1,
            focusedBorderWidth: 1.5,
            textEditingController: emailTextField,
            regexChecker: isValidEmail,
          ),
          MyTextField(
            label: "Phone Number",
            placeholder: "2519xxxxxx",
            type: "phone number",
            fontSize: 14,
            height: 40,
            width: 300,
            focusColor: "#000000",
            borderColor: "#000000",
            enabledBorderWidth: 1,
            focusedBorderWidth: 1.5,
            textEditingController: phoneNumberTextField,
            regexChecker: isValidPhoneNumber,
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
            textEditingController: passwordTextField,
            regexChecker: isValidPassword,
          ),
          const SizedBox(
            height: 20,
          ),
          MyButton(
              text: "Register",
              borderColor: "#F0922E",
              bgcolor: "#F0922E",
              fgcolor: "#ffffff",
              borderWidth: 2,
              width: 300,
              height: 40,
              onPressed: () {
                if(
                  isValidEmail(emailTextField.text) &&
                      isValidPassword(passwordTextField.text) &&
                        isValidPhoneNumber(phoneNumberTextField.text) &&
                          isValidFullName(fullNameTextField.text)
                ) {
                  bloc.add(UserRegisterEvent(
                      fullNameTextField.text.split(" ")[0],
                      fullNameTextField.text.split(" ")[1],
                      phoneNumberTextField.text,
                      emailTextField.text,
                      passwordTextField.text
                    )
                  );
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
    );
  }
}
