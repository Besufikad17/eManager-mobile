import 'package:cleanarchdemo/domain/models/requests/forgot_password_request.dart';
import 'package:cleanarchdemo/domain/models/requests/verification_request.dart';
import 'package:cleanarchdemo/domain/models/responses/forgot_password_response.dart';
import 'package:cleanarchdemo/domain/models/responses/verification_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cleanarchdemo/utils/constants/strings.dart';
import 'package:cleanarchdemo/domain/models/requests/user_signup_request.dart';
import 'package:cleanarchdemo/domain/models/requests/user_login_request.dart';
import 'package:cleanarchdemo/domain/models/responses/user_signup_response.dart';
import 'package:cleanarchdemo/domain/models/responses/user_login_response.dart';

part 'user_api_service.g.dart';

@RestApi(baseUrl: baseUrl, parser: Parser.MapSerializable)
abstract class UserApiService {
  factory UserApiService(Dio dio, {String baseUrl}) = _UserApiService;

  @POST('/signup')
  Future<HttpResponse<UserSignUpResponse>> signup({
    @Body() required UserSignUpRequest request
  });

  @POST('/login')
  Future<HttpResponse<UserLoginResponse>> login({
    @Body() required UserLoginRequest request 
  });

  @POST('/request_recover')
  Future<HttpResponse<ForgotPasswordResponse>> forgotPassword({
    @Body() required ForgotPasswordRequest request
  });

  @PUT('/verify')
  Future<HttpResponse<VerificationResponse>> verify({
    @Body() required VerificationRequest request
  });
}
