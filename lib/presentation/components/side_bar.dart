import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/domain/models/user.dart';
import 'package:cleanarchdemo/domain/repositories/user_api_repository.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/alert.dart';
import 'package:cleanarchdemo/presentation/components/image_gallary.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySideBar extends StatelessWidget {
  const MySideBar({
    super.key,
    required this.images
  });

  final List<dynamic> images;

  Future<LocalResponseData> getUser() async {
    return (await locator<LocalStorageRepositoryImpl>().getLocalResponseData())!;
  } 

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.all(20),
      child: FutureBuilder(
        future: getUser(),
        builder: (BuildContext context, snapshot) {
          if(snapshot.data != null) {
            return BlocProvider(
              create: (context) => UserBloc(locator<UserApiRepository>())..add(
                GetUserById(
                  snapshot.data!.user.id.toString(), 
                  snapshot.data!.token
                )
              ),
              child: BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {},
                builder: (BuildContext context, UserState state) {
                  if(state is UserLoaded) {
                    return _buildInitial(context, context.read<UserBloc>(), state.user);
                  } else if(state is UserError) {
                    _buildError(context, state.message!);
                  }
                  return Container();
                }, 
              ),
            );
          } else {
            return CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,);
          }
        },
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

  Widget _buildInitial(BuildContext context, UserBloc bloc, User user) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 50,),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return ImageGallery(images: images,);
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
          MyText(text: "${user.fname} ${user.lname}", size: 16, isBold: true,),
          const SizedBox(height: 40,),
          GestureDetector(
            onTap: () {
              context.router.push(const HomeRoute());
            },
            child: Row(
              children: [
                const Icon(Icons.home),
                const SizedBox(width: 10,),
                MyText(text: "Home", size: 16)
              ],
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              context.router.push(
                SettingsRoute(
                  userBloc: bloc,
                  images: images, 
                )
              );
            },
            child: Row(
              children: [
                const Icon(Icons.settings),
                const SizedBox(width: 10,),
                MyText(text: "Settings", size: 16)
              ],
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return MyAlert(
                    title: "About", 
                    type: AlertType.message, 
                    body: Expanded(
                      child: MyText(
                        text: "cleanarchdemo is built for the purpose of learning clean code architecture and " 
                        "other best practices used in flutter. Don't forget to 🌟 the repo 😜.", 
                        size: 12,
                        overflow: TextOverflow.visible
                      ),
                    )
                  );
                }
              );
            },
            child: Row(
              children: [
                const Icon(Icons.info),
                const SizedBox(width: 10,),
                MyText(text: "About", size: 16)
              ],
            ),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
            onTap: () {
              bloc.add(const UserLogoutEvent());
            },
            child: Row(
              children: [
                const Icon(Icons.logout),
                const SizedBox(width: 10,),
                MyText(text: "Logout", size: 16)
              ],
            ),
          ),
          const SizedBox(height: 200,),
          MyText(text: "cleanarchdemo", size: 12),
          const SizedBox(height: 5,),
          MyText(text: "V0.0.1", size: 12,)
        ],
      ) 
    );
  }
}