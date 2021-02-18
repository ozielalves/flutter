import 'package:flutter/material.dart';
import 'package:stocks/models/stock_model.dart';

class StockCard extends StatelessWidget {
  final Stock stock;

  StockCard(this.stock);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 26.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  this.stock.companyName,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18.0),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                this.stock.symbol.toUpperCase(),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.0,
                ),
              )
            ],
          ),
          SizedBox(
            height: 27.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildStockInfoContainer(Theme.of(context).hintColor, Colors.white,
                  Color(0x00000000), 0, "R\$ ${this.stock.price}"),
              buildStockInfoContainer(
                  Color(0x00000000),
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor,
                  2.0,
                  "~ ${this.stock.changePercent}%"),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildStockInfoContainer(Color containerColor, Color textColor,
      Color borderColor, double borderWidth, String text) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(
          color: borderColor, //                   <--- border color
          width: borderWidth,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
