import 'package:flutter/material.dart';
import 'package:s_kart/services/firebase_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
              FirebaseServices.signOut();
            },
            icon: Icon(Icons.logout))
      ]),
      body: Center(
        child: Text("Welcome To Home Screen "),
      ),
    );
  }
}
