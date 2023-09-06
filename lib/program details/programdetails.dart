import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/routers.dart';

class ProgramDetails extends StatefulWidget {
  const ProgramDetails({super.key, this.program, this.programName});
  final String? program;
  final String? programName;

  @override
  State<ProgramDetails> createState() => _ProgramDetailsState();
}

class _ProgramDetailsState extends State<ProgramDetails> {
  CollectionReference leads = FirebaseFirestore.instance.collection('leads');
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.programName.toString())),
      body: Column(
        children: [
          Text(
            "Leads",
            style: TextStyle(color: Colors.white),
          ),
          Expanded(
            child: FutureBuilder(
              future: leads
                  .where("program", isEqualTo: widget.program.toString())
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
                                nextPage(
                                    context: context, page: ProgramDetails());
                              },
                              child: Container(
                                decoration:
                                    BoxDecoration(color: Colors.blueGrey),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        data[index].get("name"),
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
          ElevatedButton(
              onPressed: () {
                //_showSimpleDialog();
              },
              child: Text("Assign Closer to all leads"))
        ],
      ),
    );
  }

  }
