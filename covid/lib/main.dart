import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Daily Covid",
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  //const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
          return MyBox(snapshot.data[0]['new_case'], snapshot.data[0]['total_case'], snapshot.data[0]['txn_date']);
      },
            itemCount: snapshot.data.length, );

      },
      future: getData(),
      );
  }
}


Future getData() async {

  var url = Uri.https('covid19.ddc.moph.go.th','/api/Cases/today-cases-all');
  var response = await http.get(url);
  var result = json.decode(response.body);
  return result;
}



Widget MyBox(String newcase, String totalcase, String txndate) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
      newcase,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 5,
    ),
    Text(
      totalcase,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(
      height: 5,
    ),
    Text(
      txndate,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    )
  ]);
}


