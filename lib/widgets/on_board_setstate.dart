import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../views/books_view.dart';
import '../views/sign_in_page.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  late bool _isLogged;

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        _isLogged = false;
      } else {
        print('User is signed in!');
        _isLogged = true;
      }

      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLogged == null
        ? Center(child: CircularProgressIndicator())
        : _isLogged
            ? BooksView()
            : const SignInPage();
  }
}
