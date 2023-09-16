import 'package:ant_manager/utils/routers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AssignCloser extends StatefulWidget {
  AssignCloser({super.key, required this.program});
  String? program;
  @override
  State<AssignCloser> createState() => AssignCloserState();
}

class AssignCloserState extends State<AssignCloser> {
  CollectionReference influencers =
      FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assign Closer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: influencers.where("accounttype", isEqualTo: "closer").get(),
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
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Set Closer"),
                                content: const Text("Assign closer to program"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () async {
                                      await updateAllDocumentsInCollection(
                                              "leads",
                                              "closer",
                                              snapshot.data!.docs[index].id)
                                          .then((value) =>
                                              Navigator.of(ctx).pop());
                                      //Navigator.of(ctx).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(14),
                                      child: const Text("okay"),
                                    ),
                                  ),
                                ],
                              ),
                            );
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
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> updateAllDocumentsInCollection(
      String collectionName, String fieldToUpdate, dynamic newValue) async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);

    final QuerySnapshot snapshot = await collection
        .where('program', isEqualTo: widget.program)
        .get();

    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await collection.doc(doc.id).update({
        fieldToUpdate: newValue,
      });
    }
  }
}
