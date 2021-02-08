import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Contador de pessoas", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  int _people = 0;
  String _message = "May come in.";

  void _changePeople(int delta) {
    setState(() {
      _people += delta;
      if (_people >= 20) {
        _message = "Crowded, cannot enter.";
        _people = 20;
      } else if (_people < 20 && _people >= 0) {
        _message = "Can entry!";
      } else {
        _people = 0;
      }
    });
  }

  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Stack(children: <Widget>[
          Image.asset(
            "images/beco.jpg",
            fit: BoxFit.cover,
            height: 1000.0,
          ),
          Center(
              child: Container(
            width: 350.0,
            height: 250.0,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.all(Radius.circular(
                      10.0) //                 <--- border radius here
                  ),
            ),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("People: $_people",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              border:
                                  Border.all(width: 2.0, color: Colors.white70),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: FlatButton(
                            child: Text("+1",
                                style: TextStyle(
                                    fontSize: 40.0, color: Colors.white)),
                            onPressed: () {
                              _changePeople(1);
                            },
                          ))),
                  Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              border:
                                  Border.all(width: 2.0, color: Colors.white70),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: FlatButton(
                            child: Text("-1",
                                style: TextStyle(
                                    fontSize: 40.0, color: Colors.white)),
                            onPressed: () {
                              _changePeople(-1);
                            },
                          ))),
                ],
              ),
              Text("$_message",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.yellowAccent,
                      fontSize: 30))
            ],
          )
        ]));
  }
}
