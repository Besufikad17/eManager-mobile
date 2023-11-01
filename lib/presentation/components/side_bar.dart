import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/datasources/local/local_response_data_service.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/alert.dart';
import 'package:cleanarchdemo/presentation/components/image_gallary.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:flutter/material.dart';

class MySideBar extends StatelessWidget {
  const MySideBar({
    super.key,
    required this.images,
    required this.userBloc
  });

  final List<dynamic> images;
  final UserBloc userBloc;

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
                  MyText(text: "${snapshot.data!.user.fname} ${snapshot.data!.user.lname}", size: 16, isBold: true,),
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
                          userBloc: userBloc,
                          images: images, 
                          user: snapshot.data!.user,
                          token: snapshot.data!.token
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
                                text: "cleanarchdemo is built for the purpose of learning clean code architecture and " + 
                                "other best practices used in flutter. Don't forget to 🌟 the repo 😜.", 
                                size: 12,
                                overflow: TextOverflow.visible
                              ),
                              // MyRichText(
                              //   primaryColor: "#000000", 
                              //   baseFontSize: 12, 
                              //    recognizer : () async{
                              //     var url = Uri(scheme: 'https', host: 'github.com/Besufikad17/eManager-mobile');
                              //     if (await canLaunchUrl(url)) {
                              //       await launchUrl(url);
                              //     } else {
                              //       throw 'Could not launch $url';
                              //     }
                              //   },
                              //   children: [
                              //     MyText(text: "Github", size: 12)
                              //   ]),
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
                      userBloc.add(const UserLogoutEvent());
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
          } else {
            return CircularProgressIndicator(color: Theme.of(context).colorScheme.primary,);
          }
        },
      ),
    );
  }
}