import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Welcome'),
            Text('${AuthController.instance.firebaseAuth.currentUser!.email}'),

            IconButton(
              onPressed: (){
                AuthController.instance.logOut();
              },
              icon: Icon(Icons.login_outlined),
            ),
          ],
        ),
      ),
    );
  }
}