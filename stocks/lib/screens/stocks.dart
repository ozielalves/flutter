import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stocks/models/stock_model.dart';
import 'package:stocks/widgets/stock_searchbar.dart';
import 'package:stocks/widgets/stocks_container.dart';
import 'dart:async';
import 'dart:convert';

const request =
    "https://api.hgbrasil.com/finance/stock_price?key=7797da70&symbol="; // COD: bidi4

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();

  static _SearchState of(BuildContext context) =>
      context.findAncestorStateOfType<_SearchState>();
}

class _SearchState extends State<Search> {
  final symbolController = TextEditingController();

  String symbol;
  List<Stock> stocks = [];
  String error = "";

  /* set _symbol(String value) => setState(() => symbol = value);

  set _error(String value) => setState(() => error = value); */

  void _clearField() {
    symbolController.text = "";
  }

  Future<Map> getData(String symbol) async {
    http.Response response = await http.get(request + symbol.toLowerCase());
    return json.decode(response.body)['results'][symbol.toUpperCase()];
  }

  void handleSearch(String symbol) async {
    if (symbol != "") {
      Map newStock = await getData(symbol);
      if (newStock['error'] == true) {
        setState(() => error = "Simbolo não encontrado");
      } else {
        setState(() => error = "");
        setState(() => stocks = [
              ...stocks,
              Stock(newStock['symbol'], newStock['company_name'],
                  newStock['price'], newStock['change_percent'])
            ]);
        for (var s in stocks) print(s);
      }
      _clearField();
    } else {
      setState(() => error = "O campo não pode ser vazio");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50.0),
            Center(
              child: (Text("Stocks",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 50.0,
                    color: Colors.white,
                  ))),
            ),
            SizedBox(height: 30.0),
            StockSearchBar(
              handleSearch: handleSearch,
              symbolController: symbolController,
            ),
            Container(
              height: 20,
              padding: EdgeInsets.only(left: 50.0, top: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                error,
                style: TextStyle(color: Colors.yellow),
              ),
            ),
            SizedBox(height: 40),
            Expanded(child: StocksContainer(stocks: stocks)),
          ],
        ));
  }
}
