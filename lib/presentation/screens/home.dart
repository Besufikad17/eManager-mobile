import 'package:auto_route/auto_route.dart';
import 'package:cleanarchdemo/domain/models/user.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.user});

  final User user;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(user.toString())
        ],
      ),
    );
  }
}