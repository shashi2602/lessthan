import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lessthan/mobiledetdartcode.dart';
import 'package:url_launcher/url_launcher.dart';
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

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/5889968468',
  size: AdSize.banner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/3314764251',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);


class Mobiledetails extends StatefulWidget {
  final String api;
  final String mobilename;
  final String id;
  final String image;
  final String mrp;
  Mobiledetails(this.api, this.mobilename, this.id, this.image,this.mrp);
  @override
  _MobiledetailsState createState() => _MobiledetailsState();
}

class _MobiledetailsState extends State<Mobiledetails> {
  String pname;
  String pmodel;
  String pbrand;
  String pid;
  String pmrp;
  String pcat;
  String prating;
  String pcolors;
  List pimages;
  List pstores;
  List pamazon;
  List pflipkart;
  // List users;
  String mainspecs;
  String mainspecs_1;
  String mainspecs_2;
  String mainspecs_3;
  @override
  void initState() {
    super.initState();
    this.getmobiledetails();
    this.getmobilespecs();
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

  Future<Jason> getmobilespecs() async {
    var mobiledet = await http.get(
        "https://price-api.datayuge.com/api/v1/compare/specs?id=${widget.id}&api_key=HxAinZKSwSTw4TQfkHzTfaMqFqC3bqWXkOx");
    print(mobiledet);
    if (mobiledet.statusCode == 200) {
      return jasonFromJson(mobiledet.body);
    } else {
      Exception('error');
    }
    return getmobilespecs();
  }
@override
  void dispose() {
    super.dispose();
  }
  Future<String> getmobiledetails() async {
    var mobileconv = await http.get(Uri.encodeFull(widget.api));
    setState(() {
      var mobileres = json.decode(mobileconv.body);
      pname = mobileres['data']['product_name'];
      pbrand = mobileres['data']['product_brand'];
      pmodel = mobileres['data']['product_model'];
      pid = mobileres['data']['product_id'];
      pmrp = mobileres['data']['product_mrp'];
      prating = mobileres['data']['product_ratings'];
      pimages = mobileres['data']['product_images'];
      pstores = mobileres['data']['stores'];
      //pamazon=mobileres['data']['stores'][0]['amazon'];
    });
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3550458721470380~9627330665");
        myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        
        anchorType: AnchorType.bottom,
      );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.mobilename,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: pimages == null
          ? SpinKitPulse(
              color: Colors.black,
            )
          : ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(pimages[0]) == null
                              ? NetworkImage(
                                  "https://i.ibb.co/0KQhZPW/mobile.png")
                              : NetworkImage(pimages[0]))),
                ),
                Card(
                  color: Colors.black,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    "$pname($pbrand)",
                                    style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w500, fontSize: 15),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "$prating",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                  

                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 10),
                    child: Text("₹${widget.mrp}",
                        style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        )),
                  ),
                  // Container(
                  //   height: 10,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(width: 0.5, color: Colors.grey[300]),
                  //     color: Colors.grey[200],
                  //   ),
                  // ),
                    ],
                  ),
                ),
                FutureBuilder<Jason>(
                  future: getmobilespecs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Wrap(
                              children: <Widget>[
                                Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot.data.data.mainSpecs[0],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,color: Colors.white)),
                                  ),
                                ),
                                Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data.data.mainSpecs[1],
                                      style: TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Colors.black,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot.data.data.mainSpecs[2],
                                        style: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //            Padding(
                          //   padding: const EdgeInsets.only(top: 20, left: 10, bottom: 20),
                          //   child: Container(
                          //     child: Text(
                          //       "stores",
                          //       style:
                          //           TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          //     ),
                          //   ),
                          // ),

                         
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "General",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          if (snapshot.data.data.subSpecs.general.length == 3||snapshot.data.data.subSpecs.general.length == 4||snapshot.data.data.subSpecs.general.length == 6||snapshot.data.data.subSpecs.general.length == 7) Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.general[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.general[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[1]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.general[2]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[2]
                                            .specValue),
                                    // details(
                                    //     snapshot.data.data.subSpecs.general[3]
                                    //         .specKey,
                                    //     snapshot.data.data.subSpecs.general[3]
                                    //         .specValue),
                                  ],
                                ) else if(snapshot.data.data.subSpecs.general.length==2)Column(
                                  children: <Widget>[
                                     details(
                                        snapshot.data.data.subSpecs.general[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.general[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[1]
                                            .specValue),
                                  ],
                                )

                                else Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.general[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.general[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[1]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.general[2]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[2]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.general[3]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[3]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.general[4]
                                            .specKey,
                                        snapshot.data.data.subSpecs.general[4]
                                            .specValue),
                                  ],
                                ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Display",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          snapshot.data.data.subSpecs.display.length==7||snapshot.data.data.subSpecs.display.length==8?
                           Column(
                            children: <Widget>[
details(
                              snapshot.data.data.subSpecs.display[0].specKey,
                              snapshot.data.data.subSpecs.display[0].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[1].specKey,
                              snapshot.data.data.subSpecs.display[1].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[2].specKey,
                              snapshot.data.data.subSpecs.display[2].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[3].specKey,
                              snapshot.data.data.subSpecs.display[3].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[4].specKey,
                              snapshot.data.data.subSpecs.display[4].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[5].specKey,
                              snapshot.data.data.subSpecs.display[5].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[6].specKey,
                              snapshot.data.data.subSpecs.display[6].specValue),
                        
                          
                            ],
                          )
                          
                          :
                          Column(
                            children: <Widget>[
details(
                              snapshot.data.data.subSpecs.display[0].specKey,
                              snapshot.data.data.subSpecs.display[0].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[1].specKey,
                              snapshot.data.data.subSpecs.display[1].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[2].specKey,
                              snapshot.data.data.subSpecs.display[2].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[3].specKey,
                              snapshot.data.data.subSpecs.display[3].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[4].specKey,
                              snapshot.data.data.subSpecs.display[4].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[5].specKey,
                              snapshot.data.data.subSpecs.display[5].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[6].specKey,
                              snapshot.data.data.subSpecs.display[6].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[7].specKey,
                              snapshot.data.data.subSpecs.display[7].specValue),
                          details(
                              snapshot.data.data.subSpecs.display[8].specKey,
                              snapshot.data.data.subSpecs.display[8].specValue),
                            ],
                          ),
                          
                          spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Storage",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          snapshot.data.data.subSpecs.storage.length == 3||snapshot.data.data.subSpecs.storage.length == 2||snapshot.data.data.subSpecs.storage.length == 4||snapshot.data.data.subSpecs.storage.length == 6
                              ? Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.storage[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.storage[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.storage[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.storage[1]
                                            .specValue),
                                    // details(
                                    //     snapshot.data.data.subSpecs.storage[2]
                                    //         .specKey,
                                    //     snapshot.data.data.subSpecs.storage[2]
                                    //         .specValue),
                                  ],
                                )
                              : Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.storage[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.storage[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.storage[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.storage[1]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.storage[2]
                                            .specKey,
                                        snapshot.data.data.subSpecs.storage[2]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.storage[3]
                                            .specKey,
                                        snapshot.data.data.subSpecs.storage[3]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.storage[4]
                                            .specKey,
                                        snapshot.data.data.subSpecs.storage[4]
                                            .specValue),
                                  ],
                                ),

                          
                          spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Software",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          details(
                              snapshot.data.data.subSpecs.software[0].specKey,
                              snapshot
                                  .data.data.subSpecs.software[0].specValue),
                          spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Camera",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          if (snapshot.data.data.subSpecs.camera.length == 7) Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.camera[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[1]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[2]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[2]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[3]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[3]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[4]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[4]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[5]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[5]
                                            .specValue),
                                    // details(
                                    //     snapshot.data.data.subSpecs.camera[6]
                                    //         .specKey,
                                    //     snapshot.data.data.subSpecs.camera[6]
                                    //         .specValue),
                                  ],
                                ) else if(snapshot.data.data.subSpecs.camera.length==4)
                                Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.camera[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[1]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[2]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[2]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[3]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[3]
                                            .specValue),
                                    
                                  ],
                                )
                                
                                else Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.camera[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[1]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[2]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[2]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[3]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[3]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[4]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[4]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[5]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[5]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[6]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[6]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.camera[7]
                                            .specKey,
                                        snapshot.data.data.subSpecs.camera[7]
                                            .specValue),
                                  ],
                                ),
                          spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Battery",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          snapshot.data.data.subSpecs.battery.length == 5||snapshot.data.data.subSpecs.battery.length == 4||snapshot.data.data.subSpecs.battery.length == 6||snapshot.data.data.subSpecs.battery.length == 3
                              ? Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.battery[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[1]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[2]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[2]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[3]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[3]
                                            .specValue),
                                    // details(
                                    //     snapshot.data.data.subSpecs.battery[4]
                                    //         .specKey,
                                    //     snapshot.data.data.subSpecs.battery[4]
                                    //         .specValue),
                                  ],
                                )
                              : Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs.battery[0]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[0]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[1]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[1]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[2]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[2]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[3]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[3]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[4]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[4]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[5]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[5]
                                            .specValue),
                                    details(
                                        snapshot.data.data.subSpecs.battery[6]
                                            .specKey,
                                        snapshot.data.data.subSpecs.battery[6]
                                            .specValue),
                                  ],
                                ),
                          spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Connectivity",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          snapshot.data.data.subSpecs.connectivity.length == 8||snapshot.data.data.subSpecs.connectivity.length == 7||snapshot.data.data.subSpecs.connectivity.length == 6
                              ? Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[0].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[0].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[1].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[1].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[2].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[2].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[3].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[3].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[4].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[4].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[5].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[5].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[6].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[6].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[7].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[7].specValue),
                                  ],
                                )
                              : Column(
                                  children: <Widget>[
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[0].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[0].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[1].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[1].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[2].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[2].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[3].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[3].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[4].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[4].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[5].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[5].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[6].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[6].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[7].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[7].specValue),
                                    details(
                                        snapshot.data.data.subSpecs
                                            .connectivity[8].specKey,
                                        snapshot.data.data.subSpecs
                                            .connectivity[8].specValue),
                                  ],
                                ),

                          Container(
                            height: 1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Colors.grey[300]),
                              color: Colors.grey[200],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Processor",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          snapshot.data.data.subSpecs.processor.length==4||snapshot.data.data.subSpecs.processor.length==6||snapshot.data.data.subSpecs.processor.length==7?
                           Column(children: <Widget>[
                             details(
                              snapshot.data.data.subSpecs.processor[0].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[0].specValue),
                          details(
                              snapshot.data.data.subSpecs.processor[1].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[1].specValue),
                          details(
                              snapshot.data.data.subSpecs.processor[2].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[2].specValue),
                          details(
                              snapshot.data.data.subSpecs.processor[3].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[3].specValue),])
                                  :
                          Column(children: <Widget>[
                             details(
                              snapshot.data.data.subSpecs.processor[0].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[0].specValue),
                          details(
                              snapshot.data.data.subSpecs.processor[1].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[1].specValue),
                          details(
                              snapshot.data.data.subSpecs.processor[2].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[2].specValue),
                          details(
                              snapshot.data.data.subSpecs.processor[3].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[3].specValue),
                          details(
                              snapshot.data.data.subSpecs.processor[4].specKey,
                              snapshot
                                  .data.data.subSpecs.processor[4].specValue),
                          ],),
                         
                          spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Sensors",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                           snapshot.data.data.subSpecs.sensors.length==4||snapshot.data.data.subSpecs.sensors.length==5?
                          Column(children: <Widget>[
                            details(
                              snapshot.data.data.subSpecs.sensors[0].specKey,
                              snapshot.data.data.subSpecs.sensors[0].specValue),
                          details(
                              snapshot.data.data.subSpecs.sensors[1].specKey,
                              snapshot.data.data.subSpecs.sensors[1].specValue),
                          details(
                              snapshot.data.data.subSpecs.sensors[2].specKey,
                              snapshot.data.data.subSpecs.sensors[2].specValue),
                          details(
                              snapshot.data.data.subSpecs.sensors[3].specKey,
                              snapshot.data.data.subSpecs.sensors[3].specValue),
                          ],)
                          : Column(children: <Widget>[
                            details(
                              snapshot.data.data.subSpecs.sensors[0].specKey,
                              snapshot.data.data.subSpecs.sensors[0].specValue),
                          details(
                              snapshot.data.data.subSpecs.sensors[1].specKey,
                              snapshot.data.data.subSpecs.sensors[1].specValue),
                          
                          ],),
                          
                          spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Sound",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          
                          Column(
                            children: <Widget>[
                              details(snapshot.data.data.subSpecs.sound[0].specKey,
                              snapshot.data.data.subSpecs.sound[0].specValue),
                          details(snapshot.data.data.subSpecs.sound[1].specKey,
                              snapshot.data.data.subSpecs.sound[1].specValue),
                              // details(snapshot.data.data.subSpecs.sound[2].specKey,
                              // snapshot.data.data.subSpecs.sound[2].specValue),
                            ],
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("No data found. sorry for that",style: TextStyle(fontWeight: FontWeight.bold),));
                    }
                    return SpinKitPulse(
                      color: Colors.black,
                    );
                  },
                ),
                spacer(),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Stores",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                pstores[0]['amazon'].toString() == "[]"
                    ? Text('')
                  
                    : stores(
                        context,
                        'amazon',
                        //pstores[0]['amazon']["product_store"],
                        pstores[0]['amazon']["product_price"],
                        pstores[0]['amazon']["product_offer"],
                        pstores[0]['amazon']["product_mrp"],
                        pstores[0]['amazon']["product_color"],
                        pstores[0]['amazon']["product_delivery"],
                        pstores[0]['amazon']["is_emi"],
                        pstores[0]['amazon']["is_cod"],
                        pstores[0]['amazon']["return_time"],
                        pstores[0]['amazon']["product_store_url"],
                        pstores[0]['amazon']["product_store_logo"]),
                pstores[1]['flipkart'].toString() == '[]'
                    ? 
                    Text('')
                    : stores(
                        context,
                        pstores[1]['flipkart']["product_store"],
                        pstores[1]['flipkart']["product_price"],
                        pstores[1]['flipkart']["product_offer"],
                        pstores[1]['flipkart']["product_mrp"],
                        pstores[1]['flipkart']["product_color"],
                        pstores[1]['flipkart']["product_delivery"],
                        pstores[1]['flipkart']["is_emi"],
                        pstores[1]['flipkart']["is_cod"],
                        pstores[1]['flipkart']["return_time"],
                        pstores[1]['flipkart']["product_store_url"],
                        pstores[1]['flipkart']["product_store_logo"]),
                pstores[11]['tatacliq'].toString() == '[]'
                    ? 
                    Text('')
                    : stores(
                        context,
                        pstores[11]['tatacliq']["product_store"],
                        pstores[11]['tatacliq']["product_price"],
                        pstores[11]['tatacliq']["product_offer"],
                        pstores[11]['tatacliq']["product_mrp"],
                        pstores[11]['tatacliq']["product_color"],
                        pstores[11]['tatacliq']["product_delivery"],
                        pstores[11]['tatacliq']["is_emi"],
                        pstores[11]['tatacliq']["is_cod"],
                        pstores[11]['tatacliq']["return_time"],
                        pstores[11]['tatacliq']["product_store_url"],
                        pstores[11]['tatacliq']["product_store_logo"]),
                pstores[12]['shopclues'].toString() == '[]'
                    ? 
                    Text('')
                    : stores(
                        context,
                        pstores[12]['shopclues']["product_store"],
                        pstores[12]['shopclues']["product_price"],
                        pstores[12]['shopclues']["product_offer"],
                       pstores[12]['shopclues']["product_mrp"],
                        pstores[12]['shopclues']["product_color"],
                        pstores[12]['shopclues']["product_delivery"],
                       pstores[12]['shopclues']["is_emi"],
                        pstores[12]['shopclues']["is_cod"],
                        pstores[12]['shopclues']["return_time"],
                        pstores[12]['shopclues']["product_store_url"],
                        pstores[12]['shopclues']["product_store_logo"]),
                pstores[13]['paytmmall'].toString() == '[]'
                    ? 
                    Text('')
                    : stores(
                        context,
                         pstores[13]['paytmmall']["product_store"],
                         pstores[13]['paytmmall']["product_price"],
                        pstores[13]['paytmmall']["product_offer"],
                         pstores[13]['paytmmall']["product_mrp"],
                         pstores[13]['paytmmall']["product_color"],
                         pstores[13]['paytmmall']["product_delivery"],
                         pstores[13]['paytmmall']["is_emi"],
                         pstores[13]['paytmmall']["is_cod"],
                         pstores[13]['paytmmall']["return_time"],
                         pstores[13]['paytmmall']["product_store_url"],
                         pstores[13]['paytmmall']["product_store_logo"]),
                pstores[15]['mi'].toString() == '[]'
                    ? 
                    Text('')
                    : stores(
                        context,
                        pstores[15]['mi']["product_store"],
                       pstores[15]['mi']["product_price"],
                        pstores[15]['mi']["product_offer"],
                        pstores[15]['mi']["product_mrp"],
                       pstores[15]['mi']["product_color"],
                        pstores[15]['mi']["product_delivery"],
                        pstores[15]['mi']["is_emi"],
                        pstores[15]['mi']["is_cod"],
                        pstores[15]['mi']["return_time"],
                        pstores[15]['mi']["product_store_url"],
                        pstores[15]['mi']["product_store_logo"]),
                
                Container(
                  height: 150,
                  width: 100,
                )
              ],
            ),
    );
  }

  Widget stores(
      BuildContext context,
      String sname,
      String sprice,
      String soffer,
      String smrp,
      String mcolor,
      String sdelivery,
      String emi,
      String cod,
      String replacement,
      String surl,
      String slogo) {
    return Card(
      child: Container(
        // height: 100,
        width: double.infinity,
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Text(sname,style: TextStyle(fontWeight: FontWeight.bold),),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(slogo))),
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "₹$sprice  ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      smrp == null ? "₹0" : "₹$smrp",
                      style: TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text(
                    "Go to store",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.orangeAccent,
                  onPressed: () async {
                    if (await canLaunch(surl)) {
                      launch(surl);
                    }
                    print("no");
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  mcolor == null ? 'Not avilable' : "$mcolor",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                Text(
                    sdelivery == null
                        ? 'Not avilable'
                        : "$sdelivery working days",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
                Text(replacement == null ? 'Not avilable' : "$replacement",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
              ],
            ),
            soffer == ''
                ? Text("")
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      soffer == '' ? '' : "Offer:$soffer",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget details(speckey, specvalue) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              "$speckey : ",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              specvalue == '' ? 'Not available' : " $specvalue",
              style: TextStyle(fontWeight: FontWeight.w500),
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }
// //width: 300,

  Widget spacer() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 1,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey[300]),
        color: Colors.grey[200],
      ),
    );
  }
}
