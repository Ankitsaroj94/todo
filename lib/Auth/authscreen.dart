import 'package:flutter/material.dart';
import 'package:todo/Auth/authform.dart';


class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        foregroundColor: Colors.blue,
        title: Center(child: Text('Authentication')),

      ),
      body: AuthForm(),
    );
  }
}
