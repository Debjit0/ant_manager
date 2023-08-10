import 'dart:io';

import 'package:ant_manager/Login%20Screen/login_screen.dart';
import 'package:ant_manager/Splash%20Screen/splash_screen.dart';
import 'package:ant_manager/unverified_influencer/unverified_influencer.dart';
import 'package:ant_manager/utils/routers.dart';
import 'package:ant_manager/verified_influencer/verified_influencer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  String csv = "";
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hompage"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              selected: true,
              title: const Text('Home Screen'),
              onTap: () {
                nextPageOnly(context: context, page: HomePage());
              },
            ),
            ListTile(

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
      body: Center(
        child: Text("Home Page",style: TextStyle(color: Colors.white),),
      )
    );
  }
}
