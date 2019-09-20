import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lessthan/home2.dart';

import 'package:lessthan/urllaunch.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var grd = LinearGradient(colors: [Color(0xFFFF5423), Color(0xFFFFF8634)]);
  final String url =
      "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=b040afa63a4349578e7fec800bcea57b&pageSize=100";
  List data;

  @override
  initState() {
    super.initState();
    this.getJsondata();
  }

  Future<String> getJsondata() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );
    setState(() {
      var convertdata = json.decode(response.body);
      data = convertdata['articles'];
    });
    return "success";
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Homepage2(
                        'https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=1e66bb7481eb48bcb11ba69653b31746&q=latest&pageSize=100','Articals')));
              },
            )
          ],
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text("Articles",
              style: TextStyle(color: Colors.white, fontSize: 25)),
        ),
        body: data == null
            ? Center(
                child: SpinKitPulse(
                color: Colors.black,
              ))
            : RefreshIndicator(
                onRefresh: getJsondata,
                child: Column(
                  
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, int index) {
                          return GestureDetector(
                            child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          //Text(data[index]['publishedAt'],style: TextStyle(color: Colors.grey)),
                                          Text(
                                            data[index]['title'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),

                                          Row(
                                            children: <Widget>[
                                              Image.network(
                                                'https://www.google.com/s2/favicons?domain=${data[index]['source']['name']}',
                                                scale: 1.5,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                data[index]['source']['name'],
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Container(
                                      height: 80,
                                      width: 140,
                                      margin: EdgeInsets.only(right: 10),
                                      //padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: data[index]
                                                          ['urlToImage'] ==
                                                      null
                                                  ? NetworkImage(
                                                      "https://dummyimage.com/600x400/575657/ffffff.png&text=lessthan")
                                                  : NetworkImage(data[index]
                                                      ['urlToImage']))),
                                    )),
                                  ],
                                )),
                            onTap: () {
                              //String img="https://via.placeholder.com/150x150.png?text=Lessthan";
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Urllaunch(
                                      data[index]['url'],
                                      data[index]['source']['name'])));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }
}
