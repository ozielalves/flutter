import 'package:flutter/material.dart';
import 'package:stocks/widgets/button_container.dart';
import 'package:stocks/styles/svgs.dart';

void main() async {
  runApp(MaterialApp(
    title: 'Stocks',
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
        hintColor: Color(0xFFFEC64E),
        accentColor: Colors.white,
        primaryColor: Color(0xFF9592C9),
        fontFamily: 'Montserrat'),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /* Stack(
            children: [
              ClipPath(
                  clipper: TopRightClipper(),
                  child: Container(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    height: 20,
                    width: 206,
                  )),
              ClipPath(
                  clipper: TopRightClipperBottom(),
                  child: Container(
                    color: Color.fromRGBO(255, 255, 255, 0.3),
                    height: 20,
                    width: 206,
                  )),
            ],
          ), */
          SizedBox(height: 50.0),
          Container(
              width: 200.0,
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Stocks",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 50.0,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    SizedBox(height: 27.0),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Um novo jeito de consultar a bolsa de valores",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22.0,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          SizedBox(height: 100.0),
          Expanded(
            child: ButtonContainer(),
          ),
        ],
      ),
    );
  }

  Widget buildTextFormField(String label, String prefix,
      TextEditingController controller, Function f) {
    return TextField(
      onChanged: f,
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(),
          prefixText: "$prefix "),
      style: TextStyle(color: Colors.white, fontSize: 25.0),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
    );
  }
}
