import 'dart:io';

import 'package:ant_manager/Login%20Screen/login_screen.dart';
import 'package:ant_manager/Splash%20Screen/splash_screen.dart';
import 'package:ant_manager/homepage/homepage.dart';
import 'package:ant_manager/unverified_influencer/unverified_influencer.dart';
import 'package:ant_manager/utils/routers.dart';
import 'package:ant_manager/verification_details/verification%20details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class VerifiedInfluencers extends StatefulWidget {
  const VerifiedInfluencers({super.key});

  @override
  State<VerifiedInfluencers> createState() => _VerifiedInfluencersState();
}

class _VerifiedInfluencersState extends State<VerifiedInfluencers> {
  @override
  String csv = "";
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verified Influencers"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Home Screen'),
              onTap: () {
                nextPageOnly(context: context, page: HomePage());
              },
            ),
            ListTile(
              selected: true,
              title: const Text('Verified Influencers'),
              onTap: () {
                nextPageOnly(context: context, page: VerifiedInfluencers());
              },
            ),
            ListTile(
              title: const Text('Unverified Influencers'),
              onTap: () {
                nextPageOnly(context: context, page: UnverifiedInfluencers());
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                nextPageOnly(context: context, page: SplashScreen());
              },
            ),
            
          ],
        ),
      ),
      body: StreamBuilder(
          stream: userCollection.where('isverified', isEqualTo: true).where('accounttype', isEqualTo: 'influencer').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
              
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                print(snapshot.data!.docs.length);
                return GestureDetector(
                  onTap: () {
                    nextPage(context: context, page: VerificationDetails(data: snapshot.data!.docs[index]));
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text("Are you sure?"),
                              content: Text("Update verification status"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                  onPressed: () {
                                    if (snapshot.data!.docs[index]
                                            ['isverified'] ==
                                        true) {
                                      changeToFalse(
                                        id: snapshot.data!.docs[index].id,
                                      );
                                      Navigator.pop(context);
                                      setState(() {});
                                    } else {
                                      changeToTrue(
                                        id: snapshot.data!.docs[index].id,
                                      );
                                      Navigator.pop(context);
                                      setState(() {});
                                    }
                                  },
                                  child: Text("ok"),
                                )
                              ],
                            ));
                  },
                  child: ListTile(
                    title: Text(
                      snapshot.data!.docs[index]['firstname'],
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "Long Press to change verification status",
                        style: TextStyle(color: Colors.white)),
                  ),
                );
              },
            );
          }),
    );
  }

  changeToTrue({@required String? id}) async {
    print(id);
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .update({"isverified": true});
      print("trued");
    } catch (e) {
      print(e);
    }
  }

  changeToFalse({@required String? id}) async {
    print(id);
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(id)
          .update({"isverified": false});
      print("falsed");
    } catch (e) {
      print(e);
    }
  }
}
