import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {

  // late DatabaseReference _counterRef;
  // late DatabaseReference _messagesRef;
  // DatabaseError? _error;

  Stream<DocumentSnapshot> documentStream = FirebaseFirestore.instance.collection('user').doc('gnB1oDZIqlgpHVHftjKdmUfOOW23').snapshots();
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('col').doc("doc").collection("col1").snapshots();
  // listen() {
  //   FirebaseDatabase.instance.reference().child('gnB1oDZIqlgpHVHftjKdmUfOOW23').child("ESP8266_Board_1").get().then((DataSnapshot? snapshot) {
  //     // print('Connected to directly configured database and read ${snapshot!.value}');
  //   });
  //   _counterRef.onValue.listen((Event event) {
  //     setState(() {
  //       _error = null;
  //       // _counter = event.snapshot.value ?? 0;
  //       print(event.snapshot.key);
  //       print(event.snapshot.value);
  //     });
  //   }, onError: (Object o) {
  //     final DatabaseError error = o as DatabaseError;
  //     setState(() {
  //       _error = error;
  //     });
  //   });
  // }

  listen() {    // Use this method in pairing mode
    _usersStream.listen((event) {
      if(event.docs.isEmpty) {
        print("Not Exist");
      } else {
        print("Exist");
      }
    });
  }

  @override
  void initState() {
    listen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MaterialButton(onPressed: listen, child: Text("Listen"),),
            StreamBuilder<DocumentSnapshot>(
              stream: documentStream,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Text(snapshot.data!['nBoard'].toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
