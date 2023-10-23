import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  Future<String> getToken() async {
    return (await locator<LocalStorageRepositoryImpl>().getData())!.token;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => UserBloc(locator<UserApiRepository>()),
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) => {},
          builder: (BuildContext context, UserState state) {
            if(state is UserInitial) {
              return _buildInitial(context, context.read<UserBloc>()); 
            }else if(state is UserLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: getColorFromHex("#F0922E"),
                ),
              );
            }else if(state is UserLoggedOut) {
              context.router.push(const WelcomeRoute());
            }else if(state is UserError) {
              _buildError(context, state.message!);
            }
            return Container();
          },
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

  Widget _buildInitial(BuildContext context, UserBloc bloc) {
    return SliderDrawer(
        slider: Container(
          child: Center(
            child: Column(
              children: [
                //Image.network("")
                MyButton(
                  text: "Logout", 
                  width: 200, 
                  height: 40,
                  onPressed: () {
                    bloc.add(const UserLogoutEvent());
                  }
                )
              ],
            ) 
          ),
        ),
        appBar: const SliderAppBar(
          title: Text("Home"),
          isTitleCenter: true,
        ),
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
      );
  }
}
