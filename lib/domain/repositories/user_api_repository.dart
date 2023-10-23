import 'package:cleanarchdemo/domain/models/requests/forgot_password_request.dart';
import 'package:cleanarchdemo/domain/models/responses/forgot_password_response.dart';
import 'package:cleanarchdemo/utils/resources/data_state.dart';
import 'package:cleanarchdemo/domain/models/responses/user_signup_response.dart';
import 'package:cleanarchdemo/domain/models/requests/user_signup_request.dart';
import 'package:cleanarchdemo/domain/models/responses/user_login_response.dart';
import 'package:cleanarchdemo/domain/models/requests/user_login_request.dart';
     
abstract class UserApiRepository { 
  Future<DataState<UserSignUpResponse>> signup({
    required UserSignUpRequest request
  });

  Future<DataState<UserLoginResponse>> login({
    required UserLoginRequest request
  });

  Future<DataState<ForgotPasswordResponse>> forgotPassword({
    required ForgotPasswordRequest request
  });
}
