import 'package:flutter/material.dart';

class CheckUserRegistered extends StatefulWidget {
  const CheckUserRegistered({super.key});

  @override
  State<CheckUserRegistered> createState() => _CheckUserRegisteredState();
}

class _CheckUserRegisteredState extends State<CheckUserRegistered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}