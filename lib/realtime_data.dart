import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RTD extends StatefulWidget {
  const RTD({Key? key}) : super(key: key);

  @override
  _RTDState createState() => _RTDState();
}

class _RTDState extends State<RTD> {
  final database = FirebaseDatabase.instance.reference();
  late DatabaseReference mydb;
  Map buttons = {};

  updateValue(bool value) async {
    mydb = database.child('ESP8266_Board_1/');
    try {
      await mydb.child('button1').set(value);
      setState(() {

      });
    } catch (e) {
      print("Got an error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<Event>(
              stream: database.child('ESP8266_Board_1/button1').onValue,
              builder: (BuildContext context, AsyncSnapshot<Event> event) {
                buttons.update("button1",
                    (existingValue) => (){
                      return event.data!.snapshot.value;
                    },
                    ifAbsent: () => event.data!.snapshot.value);

                return Transform.scale(
                    scale: 2,
                    child: Switch(
                      onChanged: updateValue,
                      value: event.data!.snapshot.value,
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.yellow,
                      inactiveThumbColor: Colors.redAccent,
                      inactiveTrackColor: Colors.orange,
                    )
                );
              },
            ),

            // MaterialButton(
            //   child: Text(buttons['button1']),
            //   onPressed: updateValue,
            // ),
          ],
        ),
      ),
    );
  }
}
