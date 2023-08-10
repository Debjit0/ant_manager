import 'dart:io';

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
      body: StreamBuilder(
          stream: userCollection.snapshots(),
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
                                    if(snapshot.data!.docs[index]['isverified']==true){
                                      changeToFalse(
                                      id: snapshot.data!.docs[index].id,
                                    );
                                    Navigator.pop(context);
                                    setState(() {});
                                    }else{
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
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                        snapshot.data!.docs[index]['isverified'].toString(),
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
