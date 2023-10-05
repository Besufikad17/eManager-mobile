import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/data/repository/base/base_api_repository.dart';
import 'package:cleanarchdemo/data/datasources/remote/user_api_service.dart';
import 'package:cleanarchdemo/utils/resources/data_state.dart';
import 'package:cleanarchdemo/domain/models/responses/user_signup_response.dart';
import 'package:cleanarchdemo/domain/models/requests/user_signup_request.dart';
import 'package:cleanarchdemo/domain/models/responses/user_login_response.dart';
import 'package:cleanarchdemo/domain/models/requests/user_login_request.dart';

class UserApiRepositoryImpl extends BaseApiRepository implements UserApiRepository {
  final UserApiService _apiService;

  UserApiRepositoryImpl(this._apiService);

  @override
  Future<DataState<UserSignUpResponse>> signup({
    required UserSignUpRequest request
  }) {
    return getStateOf<UserSignUpResponse>(
      request: () => _apiService.signup(
        request: request
      ),
      errorMessage: ""
    );
  }

  @override
  Future<DataState<UserLoginResponse>> login({
    required UserLoginRequest request
  }) {
    return getStateOf(
        request: () => _apiService.login(
            request: request
        ),
        errorMessage: "Invalid credentials!!"
    );
  }
}
