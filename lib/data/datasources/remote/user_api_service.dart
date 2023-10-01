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

  @POST('/user/signup')
  Future<HttpResponse<UserSignUpResponse>> signup({
    @Body() UserSignUpRequest request
  });

  @POST('/user/login')
  Future<HttpResponse<UserLoginResponse>> login({
    @Body() UserLoginRequest request 
  });
}
