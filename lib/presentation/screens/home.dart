import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
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

  Future<LocalUser> getUser() async {
    return (await locator<LocalStorageRepositoryImpl>().getData())!.user;
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
                  return _buildInitialWithPFP(context, context.read<UserBloc>(), state.images);
                }else if(state is UserLoggedOut) {
                  context.router.push(const WelcomeRoute());
                }else if(state is UserError) {
                  _buildError(context, state.message!);
                }
                return Container();
              },
            ),
          );
        }
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

  Widget _buildInitialWithPFP(BuildContext context, UserBloc bloc, List<dynamic> images) {
    return SliderDrawer(
        slider: Container(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          child: Image.network(
                            images[0],
                            width: 50,
                            height: 50,
                          )
                        );
                      }
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(75)),
                    child: Image.network(
                      images[0],
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                MyButton(
                  text: "Logout", 
                  width: 150, 
                  height: 30,
                  borderRadius: 5,
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
