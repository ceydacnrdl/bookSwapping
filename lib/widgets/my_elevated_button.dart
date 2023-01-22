import 'package:flutter/material.dart';

class MyElevatedButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final VoidCallback onPressed;

  const MyElevatedButton(
      {super.key,
      required this.child,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          width: 300,
          child: ElevatedButton(
              onPressed: onPressed,
              child: child,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(color),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.transparent))))),
        ));
  }
}
