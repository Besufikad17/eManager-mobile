import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/components/app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  String? getToken() {
    return locator<LocalStorageImpl>().getData("token");
  }

  @override
  Widget build(BuildContext context) {
    var token = getToken();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: MyAppBar(
          content: Container(),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            token != null ? Text(token) : const Text("No token!!")
          ],
        ),
      ),
    );
  }
}