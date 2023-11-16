import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Login Screen/login_screen.dart';
import '../buttomnavbar/buttomNavBar.dart';
import '../utils/routers.dart';

class CheckVerify extends StatefulWidget {
  const CheckVerify({super.key});

  @override
  State<CheckVerify> createState() => _CheckVerifyState();
}

class _CheckVerifyState extends State<CheckVerify> {
  bool conditions = false;
  bool isVerified = false;
  String accounttype = "";
  @override
  void initState() {
    // TODO: implement initState
    //super.initState();

    getVerificationStatus().then((value) => setState(
          () {},
        ));

    super.initState();
    //getVerificationStatus();
  }

  @override
  Widget build(BuildContext context) {
    return conditions == false
        ? Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Wait until u get verified, And make sure you are using the current app, if you are a closer or a influencer please use the respective app. This App is only for Managers",
                  style: TextStyle(color: Colors.white),
                ),
                ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      nextPageOnly(context: context, page: LoginScreen());
                    },
                    child: Text("Logout")),
                ElevatedButton(
                    onPressed: () {
                      
                      getVerificationStatus();
                    },
                    child: Text("Refresh"))
              ],
            ),
          )
        : NavBar();
  }

  Future<bool> getVerificationStatus() async {
    DocumentSnapshot document = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    isVerified = document['isverified'];
    accounttype = document["accounttype"];

    print(FirebaseAuth.instance.currentUser!.uid);
    print("Is Verified $isVerified");
    print("Account Type $accounttype");
    print(FirebaseAuth.instance.currentUser!.uid);
    if (isVerified == true && accounttype == "manager") {
      conditions = true;
      return true;
    } else {
      conditions = false;
      return false;
    }
  }

  
}
