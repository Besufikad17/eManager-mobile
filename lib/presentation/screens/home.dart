import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/settings_data_service.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/theme_bloc.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/app_bar.dart';
import 'package:cleanarchdemo/presentation/components/side_bar.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:cleanarchdemo/utils/resources/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({
    super.key,
  });

  Future<String> getToken() async {
    return (await locator<LocalStorageRepositoryImpl>().getLocalResponseData())!.token;
  }

  Future<LocalUser> getUser() async {
    return (await locator<LocalStorageRepositoryImpl>().getLocalResponseData())!.user;
  } 


  @override
  Widget build(BuildContext context) {
    var themeIcon = useState(
      locator<AppTheme>() == AppTheme.light ? Icons.dark_mode : Icons.light_mode
    );
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: MyAppBar(
          title: "Home",
          actions: [
            IconButton(
              onPressed: () {
                if(locator<AppTheme>() == AppTheme.light) {
                  themeIcon.value = Icons.dark_mode;
                  locator<ThemeBloc>().add(const ThemeChanged(AppTheme.dark));
                  ThemeManager().toggleTheme(true);
                }else {
                  themeIcon.value = Icons.light_mode;
                  locator<ThemeBloc>().add(const ThemeChanged(AppTheme.light));
                  ThemeManager().toggleTheme(false);
                }
              }, 
              icon: Icon(themeIcon.value)
            )
          ],
        ),
      ),
      drawer:  FutureBuilder(
        future: Future.wait([getUser(), getToken()]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          return BlocProvider(
            create: (context) => UserBloc(locator<UserApiRepository>()),
            child: BlocConsumer<UserBloc, UserState>(
              listener: (context, state) => {},
              builder: (BuildContext context, UserState state) {
                if(state is UserInitial) {
                  context.read<UserBloc>().add(
                    GetPFP(
                      snapshot.data![0].id.toString(), 
                      snapshot.data![1]
                    )
                  );
                }else if(state is UserLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: getColorFromHex("#F0922E"),
                    ),
                  );
                }else if(state is UserPFP) {
                  return _buildInitialWithPFP(context, context.read<UserBloc>(), state.images, snapshot.data![0]);
                }else if(state is UserLoggedOut) {
                  context.router.push(const WelcomeRoute());
                }else if(state is UserError) {
                  _buildError(context, state.message!);
                }
                return Container();
              },
            ),
          );
        },
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              FutureBuilder(
                future: getToken(), 
                builder: ((BuildContext context, snapshot) {
                  return Text(snapshot.data ?? "no token!!");
                })
              )
            ],
          ),
        ),
      ),
    );
  }

  void _buildError(BuildContext context, String message) async {
    await Future.delayed(const Duration(microseconds: 1));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 30, // Adjust the height as needed
          child: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.blue,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          backgroundColor: Colors.black,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.read<UserBloc>().add(const UserLoginLoading());
          },
        ),
      ),
    );
  }

  Widget _buildInitialWithPFP(BuildContext context, UserBloc userBloc, List<dynamic> images, LocalUser user) {
    return Drawer(
      child: MySideBar(images: images, user: user, userBloc: userBloc),
    );
  }
}
