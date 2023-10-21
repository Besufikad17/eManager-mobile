import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/config/router/app_router.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/components/button.dart';
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
                    locator.get<LocalStorageRepositoryImpl>().removeData();
                    context.router.push(const WelcomeRoute());
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
      ),
    );
  }
}
