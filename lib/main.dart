import 'package:bookswa/widgets/on_board.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import './firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './views/sign_in_page.dart';
import 'services/auth.dart';
import './views/books_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'BOOKSWAP',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        // home: const OnBoard(),
        home: OnBoard(),
      ),
    );
  }
}
