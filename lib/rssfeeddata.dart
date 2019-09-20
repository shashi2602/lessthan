import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lessthan/urllaunch.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Rssfeeddata extends StatefulWidget {
  final String api;
  final String source;
  Rssfeeddata(this.api, this.source);
  @override
  _RssfeeddataState createState() => _RssfeeddataState();
}
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
  adUnitId: 'ca-app-pub-3550458721470380/9932578265',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);
class _RssfeeddataState extends State<Rssfeeddata> {
  List mobiledata;
  String sitelink;
  @override
  void initState() {
    super.initState();
    this.getmobiledata();
    myInterstitial
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 60.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

  Future<String> getmobiledata() async {
    var response = await http.get(
      Uri.encodeFull(widget.api),
    );
    setState(() {
      var convertdata = json.decode(response.body);
      mobiledata = convertdata['items'];
      sitelink=convertdata["feed"]['link'];
    });
    return "success";
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3550458721470380~9627330665");
        myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 60.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.open_in_browser),
            onPressed: ()async{
              if(await canLaunch(sitelink)){
                launch(sitelink);
                print(sitelink);
              }
              print("cant");
            },
          )
        ],
        title: Text(
          //sitelink,
          widget.source.toString(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: mobiledata == null
            ? Center(
                child: SpinKitPulse(
                color: Colors.black,
              ))
            : RefreshIndicator(
                onRefresh: getmobiledata,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemCount: mobiledata.length,
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
                                            mobiledata[index]['title'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),

                                          Row(
                                            children: <Widget>[
                                              
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  mobiledata[index]['author']==null?widget.source:mobiledata[index]['author'],
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
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
                                              image: mobiledata[index]['thumbnail']==null||mobiledata[index]['thumbnail']==''
                                                  ? NetworkImage(
                                                      "https://i.ibb.co/pQSwnFH/placeholder.png")
                                                  : NetworkImage(mobiledata[index]['thumbnail']))),
                                    )),
                                  ],
                                )),
                            onTap: () {
                              //String img="https://via.placeholder.com/150x150.png?text=Lessthan";
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Urllaunch(
                                      mobiledata[index]['link'],
                                      mobiledata[index]['title'])));
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),

                //   child: FutureBuilder(
                //   future: getJsondata(),
                //   builder: (context,snapshot){
                //     if (snapshot.hasData) {
                //        return
                //     }
                //   },
                // ),
              )
              );
    
  }
}
