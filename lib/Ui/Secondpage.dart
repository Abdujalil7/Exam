import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imtihon/Json/words.dart';
import 'package:http/http.dart' as http;

class Secondpage extends StatefulWidget {
  const Secondpage({Key? key}) : super(key: key);

  @override
  _SecondpageState createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  double korish = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100.0,),
          Container(
            height: 300.0,
            width: 300.0,
            child: FutureBuilder(
                future: _getApi(),
                builder: (BuildContext context, AsyncSnapshot<Words> snap) {
                  var data = snap.data;
                  if (snap.hasData) {
                    return Container(
                      alignment: Alignment.center,
                      height: 300.0,
                      width: double.infinity,
                      child: Text(
                        data!.joke.toString(),
                        style: TextStyle(fontSize: korish),
                      ),
                    );
                  } else {
                    return CupertinoActivityIndicator();
                  }
                },
              ),
          ),
          SizedBox(height: 40.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),
                    onPressed: () {
                      setState(() {
                        korish -= 1;
                      });
                    },
                    child: Text(
                      "-",
                      style: TextStyle(color: Colors.green, fontSize: 35.0),
                    )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.grey),

                    onPressed: () {
                      setState(() {
                        korish += 1;
                      });
                    },
                    child: Text(
                      "+",
                      style: TextStyle(color: Colors.red, fontSize: 35.0),
                    )),
              ]),
        ],
      ),
    );
  }
  Future<Words> _getApi() async {
    var _response = await http.get(
        Uri.parse("https://geek-jokes.sameerkumar.website/api?format=json"));
    if (_response.statusCode == 200) {
      return Words.fromJson(json.decode(_response.body));
    } else {
      throw Exception("ERROR");
    }
  }
}
