import 'dart:convert';

import 'package:api_7_product/first.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool status = false;
  List l = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    var url = Uri.parse("https://dummyjson.com/products/categories");
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    l = jsonDecode(response.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${l[index]}"),
            onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) {
  return products(l[index]);
},));
            },
          );
        },
      ),
    );
  }
}
