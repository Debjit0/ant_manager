import 'package:ant_manager/Check%20Verifiy/check_verify.dart';
import 'package:ant_manager/Signup%20Screen/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUserRegistered extends StatefulWidget {
  const CheckUserRegistered({super.key});

  @override
  State<CheckUserRegistered> createState() => _CheckUserRegisteredState();
}

class _CheckUserRegisteredState extends State<CheckUserRegistered> {
  bool regStatus = false;
  @override
  void initState() {
    // TODO: implement initState
    getRegStatus().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return regStatus == true ? SignupScreen() : CheckVerify();
  }

  Future<bool> getRegStatus() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (document['isRegistered'] == true) {
      regStatus = true;
      return true;
    } else {
      return false;
    }
  }
}
