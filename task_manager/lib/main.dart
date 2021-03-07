import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red[400],
        accentColor: Colors.redAccent[100]),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List tasks = List();
  String input = '';

  createTask() {
    DocumentReference documentReference =
        Firestore.instance.collection('tasks').document(input);
    Map<String, String> tasks = {'title': input};

    // Debug message
    documentReference.setData(tasks).whenComplete(() {
      print("$input created");
    });
  }

  deleteTask(String id) {
    DocumentReference documentReference =
        Firestore.instance.collection('tasks').document(id);

    // Debug message
    documentReference.delete().whenComplete(() {
      print("$input deleted");
    });
  }

  toggleTaskCheck(String id, bool currentCheckSate) {
    DocumentReference documentReference =
        Firestore.instance.collection('tasks').document(id);

    // Debug message
    documentReference.updateData({'done': !currentCheckSate}).whenComplete(() {
      print("$input deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task Manager"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    title: Text("Add a task"),
                    content: TextField(
                      onChanged: (String value) {
                        input = value;
                      },
                    ),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            createTask();
                            Navigator.of(context).pop();
                          },
                          child: Text('Add'))
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: StreamBuilder(
            stream: Firestore.instance.collection('tasks').snapshots(),
            builder: (context, snapshots) {
              return ListView.builder(
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshots.data.documents[index];
                  return Dismissible(
                      onDismissed: (direction) {
                        deleteTask(documentSnapshot['title']);
                      },
                      key: Key(documentSnapshot['title']),
                      child: Card(
                        elevation: 2,
                        margin: EdgeInsets.all(6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                        child: ListTile(
                            title: Text(documentSnapshot['title']),
                            trailing: Checkbox(
                              value: documentSnapshot['done'],
                              key: documentSnapshot['title'],
                              onChanged: toggleTaskCheck(
                                  documentSnapshot['title'],
                                  documentSnapshot['done']),
                            )),
                      ));
                },
              );
            }));
  }
}
