import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/data/datasources/local/local_user_data_service.dart';
import 'package:cleanarchdemo/presentation/bloc/user_bloc.dart';
import 'package:cleanarchdemo/presentation/components/side_bar.dart';
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
        child: Center()
      ),
    );
  }
}