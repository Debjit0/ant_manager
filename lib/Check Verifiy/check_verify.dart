import 'package:ant_manager/homepage/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Login Screen/login_screen.dart';
import '../utils/routers.dart';

class CheckVerify extends StatefulWidget {
  const CheckVerify({super.key});

  @override
  State<CheckVerify> createState() => _CheckVerifyState();
}

class _CheckVerifyState extends State<CheckVerify> {

  bool isVerified= false;
  @override
  void initState() {
    // TODO: implement initState
    getVerificationStatus();
    super.initState();
    //getVerificationStatus();
  }

    @override
  Widget build(BuildContext context) {
    return
    isVerified==false?
    
    Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Wait until u get verified",
          style: TextStyle(color: Colors.white),
        ),
        ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              nextPageOnly(context: context, page: LoginScreen());
            },
            child: Text("Logout")),
        ElevatedButton(onPressed: (){setState(() {
          
        });}, child: Text("Refresh"))
      ],
    ),):
    HomePage();
  }

  Future getVerificationStatus() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    isVerified = document['isverified'];
    print(isVerified);
  }
}
