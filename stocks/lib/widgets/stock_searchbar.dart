import 'package:flutter/material.dart';
import 'package:stocks/models/stock_model.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

typedef void StringCallback(String val);

class StockSearchBar extends StatelessWidget {
  final StringCallback handleSearch;
  final TextEditingController symbolController;

  // Autocomplete sugestions key
  GlobalKey<AutoCompleteTextFieldState<StockTitle>> key = new GlobalKey();

  StockSearchBar({this.handleSearch, this.symbolController});

  void handleSubmit() {
    handleSearch(symbolController.text);
    print(symbolController.text);
  }

  //handleSearch(value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: kElevationToShadow[6],
        ),
        padding: EdgeInsets.fromLTRB(26.09, 7, 9.33, 7),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16.0),
                child:
                    /* TextField(
                  controller: symbolController,
                  decoration: InputDecoration(
                    hintText: 'Busque por um símbolo',
                    hintStyle: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 18.0),
                    border: InputBorder.none,
                  ), */
                    AutoCompleteTextField<StockTitle>(
                  key: key,
                  suggestions: allStockTitles,
                  controller: symbolController,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18.0),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Busque por um símbolo',
                      hintStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0)),
                  itemBuilder: (context, item) {
                    return Container(
                      width: 200,
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              item.companyName,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                          ),
                          Text(
                            item.symbol,
                          )
                        ],
                      ),
                    );
                  },
                  itemFilter: (item, query) {
                    return item.companyName
                        .toLowerCase()
                        .startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.companyName.compareTo(b.companyName);
                  },
                  itemSubmitted: (item) {
                    symbolController.text = item.symbol;
                    handleSearch(item.symbol);
                  },
                ),
              ),
            ),
            ButtonTheme(
                height: 45.0,
                minWidth: 56.0,
                child: RaisedButton(
                  onPressed: () {
                    handleSubmit();
                  },
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  color: Theme.of(context).hintColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                )),
          ],
        ),
      ),
    );
  }
}
