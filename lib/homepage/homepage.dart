
import 'package:ant_manager/Splash%20Screen/splash_screen.dart';
import 'package:ant_manager/buttomnavbar/buttomNavBar.dart';
import 'package:ant_manager/influencer%20details/Influencerdetails.dart';
import 'package:ant_manager/unverified_influencer/unverified_influencer.dart';
import 'package:ant_manager/utils/routers.dart';
import 'package:ant_manager/verified_influencer/verified_influencer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference influencers =
      FirebaseFirestore.instance.collection("Users");
  @override
  String csv = "";
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              selected: true,
              title: const Text('Home Screen'),
              onTap: () {
                nextPageOnly(context: context, page: NavBar());
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future:
              influencers.where("accounttype", isEqualTo: "influencer").get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("No Programs"),
                );
              } else {
                final data = snapshot.data!.docs;
                return Container(
                  child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.8,
                      children: List.generate(data.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            print(snapshot.data!.docs[index].id);
                            nextPage(
                                context: context,
                                page: InfluencerDetails(
                                    id: snapshot.data!.docs[index].id,
                                    infName: snapshot.data!.docs[index]
                                        .get("firstname")));
                          },
                          child: Container(
                            decoration: BoxDecoration(color: Colors.blueGrey),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    data[index].get("firstname"),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    data[index].get("email"),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
