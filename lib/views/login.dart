import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:rasoi/constant.dart';
import 'package:rasoi/home.dart';
import 'package:rasoi/localdb.dart';
//import 'package:rasoi/home.dart';
//import 'package:rasoi/services/auth.dart';
import 'package:rasoi/views/profile.dart';

class Login extends StatefulWidget {


  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
 // Future<void> signInMethod(context) async
 //  {
 //    await SignInWithGoogle();
 //    constant.name = (await LocalDataSaver.getName())!;
 //    constant.email = (await LocalDataSaver.getEmail())!;
 //    constant.img = (await LocalDataSaver.getImg())!;
 //    Navigator.pushReplacementNamed(context, MaterialPageRoute(builder: (context) => (Profile)))
 //  }
  Future<void> checkUserLog() async
  {
    final FirebaseAuth auth = await FirebaseAuth.instance;
    final user = await auth.currentUser;
    if(user != null)
    {
      constant.name = (await LocalDataSaver.getName())!;
      constant.email = (await LocalDataSaver.getEmail())!;
      constant.img = (await LocalDataSaver.getImg())!;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN TO APP"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(Buttons.Google, onPressed:()async{

              Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home()));
            })
          ],
        ),
      ),
    );
  }
}
