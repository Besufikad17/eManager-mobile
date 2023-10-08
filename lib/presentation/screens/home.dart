import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/data/repository/local_storage_repository_impl.dart';
import 'package:cleanarchdemo/domain/models/user.dart';
import 'package:cleanarchdemo/locator.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  Future<String?> getToken() async {
    return locator<SecureStorageImpl>().getData("token");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50,),
            FutureBuilder(
                future: getToken(),
                builder: (BuildContext context, snapshot) {
                  if(snapshot.data != null) {
                    return Text(snapshot.data!);
                  } else {
                    return const Text("no token!!");
                  }
                }
            )
          ],
        ),
      ),
    );
  }
}