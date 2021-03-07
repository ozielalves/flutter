import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:what_todo/database_helper.dart';
import 'package:what_todo/screens/taskpage.dart';
import 'package:what_todo/widgets/widgets.dart';

import '../models/task.dart';
import '../models/todo.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  Modal modal = new Modal();

  Task _lastRemovedTask;
  List<Todo> _lastRemovedTaskTodos;

  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => modal.mainBottomSheet(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          color: Color(0xFFF6F6F6),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 32.0,
                      bottom: 32.0,
                    ),
                    child: SvgPicture.asset(
                      'assets/images/oziel_logo.svg',
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Taskpage(
                                        task: snapshot.data[index],
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: Dismissible(
                                  background: Container(
                                    child: Align(
                                      alignment: Alignment(-0.9, -0.1),
                                      child: Icon(
                                        Icons.delete,
                                        color: Color(0xFF86829D),
                                      ),
                                    ),
                                  ),
                                  onDismissed: (direction) async {
                                    setState(() async {
                                      _lastRemovedTask = snapshot.data[index];
                                      _lastRemovedTaskTodos = await _dbHelper
                                          .getTodos(snapshot.data[index].id);
                                      await _dbHelper
                                          .deleteTask(snapshot.data[index].id);
                                      setState(() {});

                                      final snack = SnackBar(
                                        content: Text(
                                            "Tarefa ${_lastRemovedTask.title} removida."),
                                        action: SnackBarAction(
                                            label: "Desfazer",
                                            onPressed: () async {
                                              await _dbHelper
                                                  .insertTask(_lastRemovedTask);
                                              await _dbHelper
                                                  .updateTaskDescription(
                                                      _lastRemovedTask.id,
                                                      _lastRemovedTask
                                                          .description);
                                              _lastRemovedTaskTodos
                                                  .forEach((element) async {
                                                await _dbHelper
                                                    .insertTodo(element);
                                              });
                                              setState(() {});
                                            }),
                                        duration: Duration(seconds: 2),
                                      );
                                      Scaffold.of(context)
                                          .removeCurrentSnackBar();
                                      Scaffold.of(context).showSnackBar(snack);
                                    });
                                  },
                                  key: UniqueKey(),
                                  child: TaskCardWidget(
                                    title: snapshot.data[index].title,
                                    desc: snapshot.data[index].description,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Taskpage(
                                task: null,
                              )),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
                          begin: Alignment(0.0, -1.0),
                          end: Alignment(0.0, 1.0)),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Image(
                      image: AssetImage(
                        "assets/images/add_icon.png",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
