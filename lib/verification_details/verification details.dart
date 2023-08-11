import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerificationDetails extends StatefulWidget {
  const VerificationDetails({super.key, this.data});
  final QueryDocumentSnapshot<Object?>? data;
  @override
  State<VerificationDetails> createState() => _VerificationDetailsState();
}

class _VerificationDetailsState extends State<VerificationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data!.get("firstname")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 212, 38, 38),
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: NetworkImage(widget.data!.get("aadharfront")),
                      fit: BoxFit.cover)),
              width: 350,
              height: 500,
              //color: Colors.yellow,
            ),
      
            Container(
              decoration: BoxDecoration(
                  //color: Color.fromARGB(255, 212, 38, 38),
                  borderRadius: BorderRadius.circular(25),
                  image: DecorationImage(
                      image: NetworkImage(widget.data!.get("aadharback")),
                      fit: BoxFit.cover)),
              width: 350,
              height: 500,
              //color: Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }
}
