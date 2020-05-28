import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map _detail;
  DetailPage(this._detail);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(_detail["name"]),
      ),
      body: ListView(
        children: <Widget>[
          _createCart("Altura", "height"),
          _createCart("Peso", "mass"),
          _createCart("Cor do cabelo", "hair_color")
        ],
      ),
    );
  }

  Widget _createCart(String text, String text2) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.only(right: 100, left: 10),
        title: Text(
          text + ":",
          style: TextStyle(
              fontSize: 22, color: Colors.grey, fontWeight: FontWeight.w800),
        ),
        trailing: Text(
          _detail[text2],
          textAlign: TextAlign.right,
          style: TextStyle(
              fontSize: 20,
              color: Colors.deepPurple,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
