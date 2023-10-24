import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/setting.dart';
import 'package:cleanarchdemo/presentation/components/side_bar.dart';
import 'package:cleanarchdemo/presentation/components/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.bloc,
    required this.images,
    required this.user
  });

  final List<dynamic> images;
  final LocalUser user;
  final UserBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        slider: MySideBar(bloc: bloc, images: images, user: user,), 
        appBar: const SliderAppBar(
          title: Text("Settings", style: TextStyle(fontWeight: FontWeight.bold),),
          isTitleCenter: true,
        ),
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: "General", 
                  size: 16,
                  isLight: true,
                ),
                const SizedBox(height: 20,),
                MySetting(
                  title: "Theme", 
                  options: [
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: MyText(
                        text: "Light", 
                        size: 15,
                        isBold: true,
                      ),
                    ),
                  ]
                ),
                const SizedBox(height: 20,),
                MySetting(
                  title: "Language", 
                  options: [
                    GestureDetector(
                      onTap: () {

                      },
                      child: MyText(
                        text: "English", 
                        size: 15,
                        isBold: true,
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}