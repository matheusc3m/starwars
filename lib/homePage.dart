import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:starwars/detailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;
  Future<Map> _getStar() async {
    http.Response response;

    response =
        await http.get("https://swapi.dev/api/people/?page=${page.toString()}");

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Star Wars"),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
              future: _getStar(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                        strokeWidth: 5.0,
                      ),
                    );
                  default:
                    if (snapshot.hasError)
                      return Container();
                    else
                      return _createStar(context, snapshot);
                }
              }),
        ),
      ),
    );
  }

  Widget _createStar(BuildContext context, AsyncSnapshot snapshot) {
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: snapshot.data["results"].length + 1,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: <Widget>[
                if (index < 10)
                  Card(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data["results"][index])));
                    },
                    child: ListTile(
                      leading: Icon(Icons.supervised_user_circle),
                      title: Text(snapshot.data["results"][index]["name"]),
                    ),
                  )),
                if (index == snapshot.data["results"].length)
                  Center(
                    child: MaterialButton(
                        textColor: Colors.white,
                        color: Colors.deepPurple,
                        onPressed: () {
                          setState(() {
                            page += 1;
                          });
                        },
                        child: Text("Carregar Mais")),
                  ),
                if (index == snapshot.data["results"].length && page > 1)
                  Center(
                    child: MaterialButton(
                        textColor: Colors.white,
                        color: Colors.deepPurple,
                        onPressed: () {
                          setState(() {
                            page -= 1;
                          });
                        },
                        child: Text("Voltar")),
                  ),
              ],
            ),
          );
        });
  }
}
