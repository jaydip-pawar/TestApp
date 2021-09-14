import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test/bhome.dart';
import 'package:firebase_test/new_page.dart';
import 'package:firebase_test/realtime_data.dart';
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
      } else {
        print('Document not exists...');
      }
    });
  }

  navigator() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => NewPage()));
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
            MaterialButton(
              onPressed: getData,
              child: Text("Check"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BHome()));
              },
              child: Text("BHome Page"),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RTD()));
              },
              child: Text("RTD"),
            ),
            MaterialButton(
              onPressed: navigator,
              child: Text("Go To new Listener Page"),
            ),
          ],
        ),
      ),
    );
  }
}
