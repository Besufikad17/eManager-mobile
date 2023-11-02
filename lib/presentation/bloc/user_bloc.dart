import 'package:bloc/bloc.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/domain/models/requests/change_password_request.dart';
import 'package:cleanarchdemo/domain/models/requests/edit_profile_request.dart';
import 'package:cleanarchdemo/domain/models/requests/forgot_password_request.dart';
import 'package:cleanarchdemo/domain/models/requests/user_login_request.dart';
import 'package:cleanarchdemo/domain/models/requests/user_signup_request.dart';
import 'package:cleanarchdemo/domain/models/requests/verification_request.dart';
import 'package:cleanarchdemo/domain/models/user.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/utils/resources/data_state.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserApiRepository _repository;
  
  UserBloc(this._repository) : super(const UserInitial()) {
    on<UserLoginLoading>((event, emit){
      emit(const UserInitial());
    });

    on<UserRegisterLoading>((event, emit){
      emit(const UserInitial());
    });
    
    on<UserLoginEvent>((event, emit) async {
      emit(const UserLoading());
      final response = await _repository.login(
        request: UserLoginRequest(event.email, event.password)
      );

      if(response is DataSuccess) {
        emit(UserLoaded(response.data!.user!, response.data!.token!));
      }else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });

    on<UserRegisterEvent>((event, emit) async {
      emit(const UserLoading());
      final response = await _repository.signup(
          request: UserSignUpRequest(
              event.fname,
              event.lname,
              event.email,
              event.phonenumber,
              event.password
          )
      );

      if(response is DataSuccess) {
        emit(UserLoaded(response.data!.user, response.data!.token));
      }else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      emit(const UserLoading());
      final response = await _repository.forgotPassword(
        request: ForgotPasswordRequest(event.email)
      );

      if(response is DataSuccess) {
        emit(ForgotPassword(response.data!.code));
      }else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });

    on<VerificationEvent>((event, emit) async {
      emit(const UserLoading());
      final response = await _repository.verify(
        request: VerificationRequest(event.code, event.email)
      );

      if(response is DataSuccess) {
        emit(Verified(response.data!.status));
      }else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(const UserLoading());
      final response = await _repository.changePassword(
        request: ChangePasswordRequest(event.id, event.email, event.newPassword)
      );

      if(response is DataSuccess) {
        emit(PasswordChanged(response.data!.status));
      }else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });

    on<UserLogoutEvent>((event, emit) {
      emit(const UserLoading());
      locator.get<LocalStorageRepositoryImpl>().removeLocalResponseData();
      emit(const UserLoggedOut());
    });

    on<GetPFP>((event, emit) async {
      final response = await _repository.getPFPs(
        id: event.id,
        token: event.token
      );

      if(response is DataSuccess) {
        emit(UserPFP(response.data!.images));
      }else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });

    on<EditProfileEvent>((event, emit) async {
      emit(const UserLoading());
      final response = await _repository.editProfile(
        id: event.id, 
        request: EditProfileRequest(
          event.user.fname!, 
          event.user.lname!, 
          event.user.email!, 
          event.user.phoneNumber!
        ), 
        token: event.token
      );

      if(response is DataSuccess) {
        emit(UserLoaded(
          User(
            id: int.parse(response.data!.id),
            fname: response.data!.fname,
            lname: response.data!.lname,
            email: response.data!.email,
            phoneNumber: response.data!.phonenNumber
          ),
          event.token
        ));
      }else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });

    on<GetUserById>((event, emit) async {
      emit(const UserLoading());
      final response = await _repository.getUserById(id: event.id, token: event.token);

      if(response is DataSuccess) {
        final user =  User(
          id: int.parse(response.data!.id),
          fname: response.data!.fname,
          lname: response.data!.lname,
          email: response.data!.email,
          phoneNumber: response.data!.phonenNumber
        );
        emit(UserLoaded(user, event.token));
      } else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });

    on<RemoveUser>((event, emit) async {
      emit(const UserLoading());
      final response = await _repository.deleteAccount(
        id: event.id, 
        token: event.token
      );

      if(response is DataSuccess) {
        locator<LocalStorageRepositoryImpl>().removeLocalResponseData();
        locator<LocalStorageRepositoryImpl>().removeSettingsData();
      } else if(response is DataFailed) {
        emit(UserError(response.message));
      }
    });
  }
}


