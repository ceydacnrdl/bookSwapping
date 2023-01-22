import 'package:bookswa/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/auth_screen.dart';
import '../services/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(actions: [
        //   IconButton(
        //     onPressed: () async {
        //       //Auth _auth = Auth();
        //       //_auth.signOut();
        //       Provider.of<Auth>(context, listen: false).signOut();
        //       print('logout tıklandı');
        //     },
        //     icon: Icon(Icons.logout),
        //   ),
        // ]),
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Text(
              'W E L C O M E',
              style: TextStyle(
                  fontFamily: 'pasific',
                  fontSize: 40.0,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            ),
          ),
          MyElevatedButton(
            child: Text('Sign in Anonymously'),
            color: Colors.deepPurple,
            onPressed: () async {
              final user = await Provider.of<Auth>(context, listen: false)
                  .signInAnonymously();
              print(user!.uid);
            },
          ),
          MyElevatedButton(
            child: Text('Sign with Email/Password'),
            color: Colors.deepPurple,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AuthScreen()));
            },
          )
        ],
      ),
    ));
  }

  Future<void> call() async {
    final user =
        await Provider.of<Auth>(context, listen: false).signInAnonymously();
    print(user!.uid);
  }
}
