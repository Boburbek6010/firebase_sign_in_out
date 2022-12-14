import 'package:firebase_note/services/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const id = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _logout(){
    AuthService.signOutUser(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
        actions: [
          IconButton(
            splashRadius: 27,
              onPressed: () => _logout,
              icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
