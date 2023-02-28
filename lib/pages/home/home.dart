import 'package:decoration_plants_store/constants/colors.dart';
import 'package:decoration_plants_store/pages/home/for_home/body_of_home.dart';
import 'package:decoration_plants_store/pages/home/for_home/drawer_of_home.dart';
import 'package:decoration_plants_store/shared/app_bar_actions.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldGrey,
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("Home"),
        actions: const [AppBarActions(),],
      ),
      drawer: const DrawerOfHome(),
      body: const BodyOfHome(),
    );
  }
}