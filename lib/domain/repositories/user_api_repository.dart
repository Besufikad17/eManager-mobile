import 'package:cleanarchdemo/domain/models/requests/change_password_request.dart';
import 'package:cleanarchdemo/domain/models/requests/edit_profile_request.dart';
import 'package:cleanarchdemo/domain/models/requests/forgot_password_request.dart';
import 'package:cleanarchdemo/domain/models/requests/verification_request.dart';
import 'package:cleanarchdemo/domain/models/responses/change_password_response.dart';
import 'package:cleanarchdemo/domain/models/responses/edit_profile_response.dart';
import 'package:cleanarchdemo/domain/models/responses/forgot_password_response.dart';
import 'package:cleanarchdemo/domain/models/responses/get_pfp_response.dart';
import 'package:cleanarchdemo/domain/models/responses/verification_response.dart';
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

  Future<DataState<VerificationResponse>> verify({
    required VerificationRequest request
  });

  Future<DataState<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest request
  });

  Future<DataState<EditProfileResponse>> editProfile({
    required String id,
    required EditProfileRequest request,
    required String token
  });

  Future<DataState<GetPFPResponse>> getPFPs({
    required String id,
    required String token
  });
}
