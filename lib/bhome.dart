import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BHome extends StatefulWidget {
  const BHome({Key? key}) : super(key: key);

  @override
  _BHomeState createState() => _BHomeState();
}

class _BHomeState extends State<BHome> {
  int nBoard = 0; //Number of boards
  int nButtons = 0; //Number of buttons

  final database = FirebaseDatabase.instance.reference();
  late DatabaseReference mydb;
  Map buttons = {};

  updateValue(bool value, String boardName, int button) async {
    mydb = database.child('$boardName/');
    try {
      await mydb.child("button" + button.toString()).set(value);
      setState(() {

      });
    } catch (e) {
      print("Got an error");
    }
  }

  Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance
      .collection('user')
      .doc('gnB1oDZIqlgpHVHftjKdmUfOOW23')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BHome"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: documentStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Error found");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (snapshot.data!['nBoard'] == 0) {
            return Text("Add Device");
          } else if (snapshot.data!['nBoard'] > 0) {
            nBoard = snapshot.data!['nBoard'];
            // return Text(nBoard.toString());
          }

          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: nBoard,
              itemBuilder: (BuildContext context, int index) {
                return StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('boards')
                      .doc("gnB1oDZIqlgpHVHftjKdmUfOOW23")
                      .collection(snapshot.data!['boardNames'][index])
                      .doc("boardData")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot1) {

                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('boardNames')
                          .doc(snapshot.data!['boardNames'][index])
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot2) {

                        if(!snapshot1.hasData || !snapshot2.hasData) return Container();

                        return Column(
                          children: [
                            Text("Board Name: " +
                                snapshot.data!['boardNames'][index]),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot1.data!['buttons'],
                              itemBuilder: (BuildContext context, int index2) {
                                print(index2);
                                int ind = index2 + 1;
                                String path = snapshot.data!['boardNames'][index] + "/button" + ind.toString();
                                print(path);
                                return StreamBuilder<Event>(
                                  stream: database.child(path).onValue,
                                  builder: (BuildContext context, AsyncSnapshot<Event> event) {
                                    buttons.update("button1",
                                            (existingValue) => (){
                                          return event.data!.snapshot.value;
                                        },
                                        ifAbsent: () => event.data!.snapshot.value);

                                    return Transform.scale(
                                        scale: 2,
                                        child: Switch(
                                          onChanged: (value) => updateValue(value, snapshot.data!['boardNames'][index], index2 + 1),
                                          value: event.data!.snapshot.value,
                                          activeColor: Colors.blue,
                                          activeTrackColor: Colors.yellow,
                                          inactiveThumbColor: Colors.redAccent,
                                          inactiveTrackColor: Colors.orange,
                                        )
                                    );
                                  },
                                );
                                  // Text(snapshot2.data!['button${index+1}']['name']);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
