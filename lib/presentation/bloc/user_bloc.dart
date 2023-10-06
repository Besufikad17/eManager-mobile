import 'package:bloc/bloc.dart';
import 'package:cleanarchdemo/domain/models/requests/user_login_request.dart';
import 'package:cleanarchdemo/domain/models/user.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/utils/resources/data_state.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserApiRepository _repository;
  
  UserBloc(this._repository) : super(const UserInitial()) {
    on<UserLoginLoading>((event, emit) async {
      emit(const UserInitial());
    });

    on<UserLoginEvent>((event, emit) async {
      final response = await _repository.login(
        request: UserLoginRequest(event.email, event.password)
      );

      if(response is DataSuccess) {
        emit(UserLoaded(response.data!.user!));
      }else if(response is DataFailed) {
        emit(UserError(response.error!.message));
      }
    });

    on<UserRegisterEvent>((event, emit) {
      
    });

    on<UserLogoutEvent>((event, emit) {
      
    });
  }
}
