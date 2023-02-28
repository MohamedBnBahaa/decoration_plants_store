import 'package:decoration_plants_store/pages/sign_in/sign_in.dart';
import 'package:decoration_plants_store/pages/verify_email/verify_email.dart';
import 'package:decoration_plants_store/provider/cart.dart';
import 'package:decoration_plants_store/provider/google_sign_in.dart';
import 'package:decoration_plants_store/shared/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider(
        create: (context) {return Cart();}),
        ChangeNotifierProvider(
        create: (context) {return GoogleSignInProvider();}),
        ],

    // return ChangeNotifierProvider(
    //   // create: (context) {return Cart();},
    //   create: (_) => Cart(),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            else if (snapshot.hasError) {return showSnackBar(context, "Something went wrong",);}
            else if (snapshot.hasData) {return const VerifyEmailPage();}
            else {return const Login();}
          },
        ),
      ),
    );
  }
}
