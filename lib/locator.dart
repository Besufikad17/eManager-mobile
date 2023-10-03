import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:cleanarchdemo/data/datasources/remote/user_api_service.dart';
import 'package:cleanarchdemo/data/repository/user_api_repository_impl.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> initDependency() async {
  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());
  locator.registerSingleton<Dio>(dio);

  locator.registerSingleton<UserApiService>(
    UserApiService(locator<Dio>())
  );

  locator.registerSingleton<UserApiRepository>(
    UserApiRepositoryImpl(locator<UserApiService>())
  );
}