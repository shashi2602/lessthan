import 'package:flutter/material.dart';

import 'package:lessthan/urllaunch.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_admob/firebase_admob.dart';

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['Technews', 'mobiles', 'reviews', 'shopping'],

  birthday: DateTime.now(),
  childDirected: false,
  designedForFamilies: false,
  gender:
      MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);



InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/1230460736',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Homepage2 extends StatefulWidget {
  final String link;
  final String searchitem;
  Homepage2(this.link, this.searchitem);
  @override
  _Homepage2State createState() => _Homepage2State();
}

class _Homepage2State extends State<Homepage2> {
  var grd = LinearGradient(colors: [Color(0xFFFF5423), Color(0xFFFFF8634)]);
  // final String url =
  //     "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=520ca86ab4884f87a84f36e4292dc61d&pageSize=100";
  List data;

  @override
  initState() {
    super.initState();
    this.getJsondata();
    myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
  }

  Future<String> getJsondata() async {
    var response = await http.get(
      Uri.encodeFull(widget.link),
    );
    setState(() {
      var convertdata = json.decode(response.body);
      data = convertdata['articles'];
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3550458721470380~9627330665");
    return Scaffold(
        //backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(widget.searchitem,
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
