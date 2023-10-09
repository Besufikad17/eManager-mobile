import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:cleanarchdemo/data/datasources/remote/user_api_service.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/data/repository/user_api_repository_impl.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

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

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(LocalUserAdapter());
  Hive.registerAdapter(LocalResponseDataAdapter());
  await Hive.openBox<LocalResponseData>("response");
  locator.registerSingleton<Box<LocalResponseData>>(
    Hive.box("response")
  );

  locator.registerSingleton<LocalStorageRepositoryImpl>(
     LocalStorageRepositoryImpl(locator.get<Box<LocalResponseData>>())
  );

}