import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_note/pages/home_page.dart';
import 'package:firebase_note/pages/sign_in_page.dart';
import 'package:firebase_note/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyFirebaseApp());
}

class MyFirebaseApp extends StatelessWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Firebase App",
      home: SignInPage(),
      routes: {
        HomePage.id:(context) => HomePage(),
        SignInPage.id:(context) => SignInPage(),
        SignUpPage.id:(context) => SignUpPage(),
      },
    );
  }
}
