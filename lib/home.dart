import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  getData() {
    FirebaseFirestore.instance
        .collection('boards')
        .doc("gnB1oDZIqlgpHVHftjKdmUfOOW23")
        .collection("ESP8266_Board_1")
        .doc("boardData")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Firebase Test"),
            MaterialButton(onPressed: getData, child: Text("Check"),)
          ],
        ),
      ),
    );
  }
}
