import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../program details/programdetails.dart';
import '../utils/routers.dart';

class InfluencerDetails extends StatefulWidget {
  const InfluencerDetails({super.key,this.id, this.infName});
  final String? id;
  final String? infName;
  @override
  State<InfluencerDetails> createState() => _InfluencerDetailsState();
}

class _InfluencerDetailsState extends State<InfluencerDetails> {
  final CollectionReference programs = FirebaseFirestore.instance.collection('Programs');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.infName.toString()),),
      body: Column(
        children: [
          Text("Programs",style: TextStyle(color: Colors.white),),
          Expanded(
            child: FutureBuilder(
              future: programs
                  .where("uploader", isEqualTo: widget.id.toString())
                  .get(),

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
                            nextPage(context: context, page: ProgramDetails(program: snapshot.data!.docs[index].id,programName:snapshot.data!.docs[index].get("program name") ,));
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
                                  Text(data[index].get("program name"),style: TextStyle(color: Colors.white),),
                                  Text(data[index].get("program description"),style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
            ),
          ),
        ],
      ),
    );
  }
}