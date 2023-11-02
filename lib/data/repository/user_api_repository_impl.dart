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
      )
    );
  }

  @override
  Future<DataState<UserLoginResponse>> login({
    required UserLoginRequest request
  }) {
    return getStateOf(
        request: () => _apiService.login(
            request: request
        )
    );
  }

  @override
  Future<DataState<ForgotPasswordResponse>> forgotPassword({
    required ForgotPasswordRequest request
  }) {
    return getStateOf(
      request: () => _apiService.forgotPassword(
        request: request
      )
    );
  }

  @override
  Future<DataState<VerificationResponse>> verify({
    required VerificationRequest request
  }) {
    return getStateOf(
      request: () => _apiService.verify(
        request: request
      )
    );
  }

  @override
  Future<DataState<ChangePasswordResponse>> changePassword({
    required ChangePasswordRequest request
  }) {
    return getStateOf(
      request: () => _apiService.chanePassword(
        request: request
      )
    );
  }

  @override
  Future<DataState<EditProfileResponse>> editProfile({
    required String id,
    required EditProfileRequest request,
    required String token
  }) {
    return getStateOf(
      request: () => _apiService.editProfile(
        id: id, 
        request: request, 
        token: "Bearer $token"
      )
    );
  }

  @override
  Future<DataState<GetPFPResponse>> getPFPs({
    required String id,
    required String token
  }) {
    return getStateOf(
      request: () => _apiService.getPFPs(
        id: id,
        token: "Bearer $token"
      )
    );
  }

  @override
  Future<DataState<GetUserByIdResponse>> getUserById({
    required String id,
    required String token
  }) {
    return getStateOf(
      request: () => _apiService.getUserById(
        id: id, 
        token: "Bearer $token"
      )
    );
  }

  @override
  Future<DataState<DeleteAccountResponse>> deleteAccount({
    required String id,
    required String token
  }) {
    return getStateOf(
      request: () => _apiService.deleteAcount(
        id: id, 
        token: "Bearer $token"
      )
    );
  }
}
