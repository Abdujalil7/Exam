import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:imtihon/Json/words.dart';
import 'package:http/http.dart' as http;
import 'package:imtihon/Ui/Secondpage.dart';

class Uigame extends StatefulWidget {
  @override
  _UigameState createState() => _UigameState();
}

class _UigameState extends State<Uigame> {
  TextEditingController _controller = TextEditingController();
  int uriniw = 1;
  int index = 0;
  String malumot = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Icon(Icons.gamepad),
        title: Text(
          "Quick Type",
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 300.0,
              width: 300.0,
              child: FutureBuilder(
                future: _getApi(),
                builder: (BuildContext context, AsyncSnapshot<Words> snap) {
                  var data = snap.data;
                  malumot = data!.joke.toString();
                  if (snap.hasData) {
                    return Container(
                      alignment: Alignment.center,
                      height: 300.0,
                      width: double.infinity,
                      child: Text(
                        data.joke.toString(),
                      ),
                    );
                  } else if (snap.hasError) {
                    return Center(
                      child: Text(snap.error.toString()),
                    );
                  } else {
                    return CupertinoActivityIndicator();
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 70.0,
            width: 360.0,
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.border_color),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          ElevatedButton(
              onPressed: () {
                if (_controller.text.toLowerCase() == malumot.toLowerCase()) {
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text(
                        uriniw.toString(),
                      ),
                    ),
                  );
                  _controller.clear();
                  uriniw += 1;
                }
              },
              child: Text("Enter")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Secondpage()));
              },
              child: Text("Second Page")),
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
// ("${_controller.text}",style: TextStyle(color: Colors.white),),