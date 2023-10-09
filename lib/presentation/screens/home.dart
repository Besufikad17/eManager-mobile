import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:flutter/material.dart';
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
      body: SliderDrawer(
        slider: Container(),
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
      ),
    );
  }
}