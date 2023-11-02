import 'package:cleanarchdemo/domain/models/requests/change_password_request.dart';
import 'package:cleanarchdemo/domain/models/requests/edit_profile_request.dart';
import 'package:cleanarchdemo/domain/models/requests/forgot_password_request.dart';
import 'package:cleanarchdemo/domain/models/requests/verification_request.dart';
import 'package:cleanarchdemo/domain/models/responses/change_password_response.dart';
import 'package:cleanarchdemo/domain/models/responses/delete_account_response.dart';
import 'package:cleanarchdemo/domain/models/responses/edit_profile_response.dart';
import 'package:cleanarchdemo/domain/models/responses/forgot_password_response.dart';
import 'package:cleanarchdemo/domain/models/responses/get_pfp_response.dart';
import 'package:cleanarchdemo/domain/models/responses/get_user_by_id_response.dart';
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

  @PUT('/change_password')
  Future<HttpResponse<ChangePasswordResponse>> chanePassword({
    @Body() required ChangePasswordRequest request
  });

  @PUT('/edit_profile/{id}')
  Future<HttpResponse<EditProfileResponse>> editProfile({
    @Path() required String id,
    @Body() required EditProfileRequest request,
    @Header('Authorization') required String token
  });

  @GET('/user/{id}')
  Future<HttpResponse<GetUserByIdResponse>> getUserById({
    @Path() required String id,
    @Header('Authorization') required String token
  });

  @GET('/images/{id}')
  Future<HttpResponse<GetPFPResponse>> getPFPs({
    @Path() required String id,
    @Header('Authorization') required String token,
  });

  @DELETE('/delete_profile/{id}')
  Future<HttpResponse<DeleteAccountResponse>> deleteAcount({
    @Path() required String id,
    @Header('Authorization') required String token,
  });
}
