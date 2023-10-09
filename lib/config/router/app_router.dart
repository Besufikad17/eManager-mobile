import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/presentation/screens/home.dart';
import 'package:cleanarchdemo/presentation/screens/signup.dart';
import 'package:cleanarchdemo/presentation/screens/welcome.dart';
import 'package:cleanarchdemo/presentation/screens/login.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  AppRouter(this.isLoggedIn);
  final bool isLoggedIn;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, initial: !isLoggedIn),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: HomeRoute.page, initial: isLoggedIn)
  ];
}

