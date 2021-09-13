import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BHome extends StatefulWidget {
  const BHome({Key? key}) : super(key: key);

  @override
  _BHomeState createState() => _BHomeState();
}

class _BHomeState extends State<BHome> {

  int nBoard = 0;     //Number of boards

  Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance.collection('user').doc('gnB1oDZIqlgpHVHftjKdmUfOOW23').snapshots();
  Stream<DocumentSnapshot> documentStream2 = FirebaseFirestore.instance.collection('user').doc('gnB1oDZIqlgpHVHftjKdmUfOOW23').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BHome"),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: documentStream,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                if(snapshot.data!['nBoard'] == 0) {
                  return Text("Add Device");
                } else if(snapshot.data!['nBoard'] > 0) {
                  nBoard = snapshot.data!['nBoard'];
                  // return Text(nBoard.toString());
                }

                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: nBoard,
                  itemBuilder: (BuildContext context, int index) {
                    print(index);
                    return Text(snapshot.data!['boardNames'][index]);
                  });

                // return Text("No data");
              },
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: documentStream,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                if(snapshot.data!['nBoard'] == 0) {
                  return Text("Add Device");
                } else if(snapshot.data!['nBoard'] > 0) {
                  nBoard = snapshot.data!['nBoard'];
                  // return Text(nBoard.toString());
                }

                return ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    // return Text(snapshot.data!['boardNames'][index]);
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: 30,
                      itemBuilder: (BuildContext context, int index) {
                        return Text("List");
                      }
                    );
                  });

                // return Text("No data");
              },
            ),
          ],
        ),
      ),
    );
  }
}
