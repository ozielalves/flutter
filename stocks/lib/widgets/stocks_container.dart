import 'package:flutter/material.dart';
import 'package:stocks/models/stock_model.dart';
import 'package:stocks/widgets/stock_card.dart';

class StocksContainer extends StatelessWidget {
  List<Stock> stocks;

  StocksContainer({this.stocks});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0))),
      child: ListView(children: <Widget>[
        for (var stock in stocks)
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 15.0),
            child: StockCard(stock),
          ),
      ]),
    );
  }
}
