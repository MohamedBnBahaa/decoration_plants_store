import 'package:decoration_plants_store/pages/check_out/check_out.dart';
import 'package:decoration_plants_store/pages/home/home.dart';
import 'package:decoration_plants_store/pages/profile/profile.dart';
import 'package:decoration_plants_store/pages/profile/for_profile/user_email_from_fire_store.dart';
import 'package:decoration_plants_store/shared/user_img_from_fire_store.dart';
import 'package:decoration_plants_store/pages/profile/for_profile/user_name_from_fire_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerOfHome extends StatelessWidget {
  const DrawerOfHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/background_decoration_plants.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),

                currentAccountPicture: UserImg(),

                accountName: UserName(),

                accountEmail: UserEmail(),

              ),
              ListTile(
                title: const Text("Home"),
                leading: const Icon(Icons.home),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text("My products"),
                leading: const Icon(Icons.add_shopping_cart),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckOut(),
                    ),
                  );
                },
              ),
              ListTile(
                  title: const Text("About"),
                  leading: const Icon(Icons.help_center),
                  onTap: () {}
              ),
              ListTile(
                  title: const Text("Profile Page"),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  }
              ),
              ListTile(
                  title: const Text("Logout"),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  }
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: const Text("Developed by Mohamed Bahaa © 2023",
                style: TextStyle(fontSize: 16),),
          ),
        ],
      ),
    );
  }
}
