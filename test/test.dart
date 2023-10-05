import 'package:cleanarchdemo/data/datasources/remote/user_api_service.dart';
import 'package:cleanarchdemo/data/repository/user_api_repository_impl.dart';
import 'package:cleanarchdemo/domain/models/requests/user_login_request.dart';
import 'package:dio/dio.dart';

void main() async {
  const UserLoginRequest request = UserLoginRequest("JaneDoe@gmail.com", "azx1231");
  final dio = Dio();
  final service = UserApiService(dio);
  final repo = UserApiRepositoryImpl(service);
  await repo.login(request: request);
  // print(response!.toMap());
}