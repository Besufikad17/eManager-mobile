import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/config/theme/app_theme.dart';
import 'package:cleanarchdemo/data/datasources/local/settings_data_service.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/theme_bloc.dart';
import 'package:cleanarchdemo/utils/constants/strings.dart';
import 'package:cleanarchdemo/utils/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initDependency();
  bool isLoggedIn = await locator<LocalStorageRepositoryImpl>().getLocalResponseData() != null;
  final theme = locator<AppTheme>();

  runApp(MyApp(isLoggedIn: isLoggedIn, theme: theme,));
}

class MyApp extends StatefulWidget {
  MyApp({
    required this.isLoggedIn,
    required this.theme
  });

  final bool isLoggedIn;
  final AppTheme theme;

  @override
  _MyAppState createState() => _MyAppState(isLoggedIn: isLoggedIn, theme: theme);
}

class _MyAppState extends State<MyApp> {

  _MyAppState({
    required this.isLoggedIn,
    required this.theme
  });

  final bool isLoggedIn;
  final AppTheme theme;
 

  @override
  void dispose() {
    locator<ThemeManager>().removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    locator<ThemeManager>().addListener(themeListener);
    super.initState();
  }

  themeListener(){
    if(mounted){
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(locator.get<LocalStorageRepositoryImpl>())
        ..add(const GetTheme()),
      child: BlocConsumer<ThemeBloc, ThemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is ThemeInitial) {
            return _buildLoaded(AppTheme.light);
          } else if(state is ThemeLoaded) { 
            return _buildLoaded(state.appTheme);
          } 
          return Container();
        },
      ),
    );
  }

  Widget _buildLoaded(theme) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: applicationTitle,
      routerConfig: AppRouter(isLoggedIn).config(),
      darkTheme: darkTheme,
      theme: theme == AppTheme.light ? lightTheme : darkTheme,
      themeMode: locator<ThemeManager>().themeMode,
    );
  }
}

