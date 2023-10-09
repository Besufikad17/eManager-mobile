import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:cleanarchdemo/presentation/components/app_bar.dart';
import 'package:cleanarchdemo/utils/resources/colors.dart';
import 'package:flutter/material.dart';

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
    var token = getToken();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: MyAppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              color: getColorFromHex("#000000"),
              onPressed: () {}
            )
          ],
        ),
      ),
      body: Center(
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