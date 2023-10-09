import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/utils/constants/strings.dart';
import 'package:flutter/material.dart';

void main() async {
  await initDependency();
  bool isLoggedIn = locator<LocalStorageImpl>().contains("token");
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: applicationTitle,
      routerConfig: AppRouter(isLoggedIn).config(),
    );
  }
}
