import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/presentation/screens/welcome.dart';
import 'package:cleanarchdemo/presentation/screens/login.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: WelcomeRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page)
  ];
}
final appRouter = AppRouter();
