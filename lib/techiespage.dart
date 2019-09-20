import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  adUnitId: 'ca-app-pub-3550458721470380/4635175663',
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/4252032288',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Techies extends StatefulWidget {
  @override
  _TechiesState createState() => _TechiesState();
}

class _TechiesState extends State<Techies> {
  List ytddata;
  final String ytdurl = "https://api.jsonbin.io/b/5ccda33dc07f283511e0482e";

  @override
  void initState() {
    
    super.initState();
    this.getyoutubechanneldata();
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

  Future<String> getyoutubechanneldata() async {
    var response = await http.get(
      Uri.encodeFull(ytdurl),
    );
    setState(() {
      var converteddata = json.decode(response.body);
      ytddata = converteddata;
    });
    
    return "success";
  }
@override
  void dispose() {
    super.dispose();
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
        //anchorOffset: 60.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Techies",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ytddata == null
          ? SpinKitPulse(
              color: Colors.black,
            )
          : ListView.builder(
              itemCount: 18,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            height: 80,
                            width: 140,
                            margin: EdgeInsets.only(right: 10),
                            //padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: ytddata[index]['channelimage'] ==
                                            null
                                        ? NetworkImage(
                                            "https://via.placeholder.com/150x150.png?text=Lessthan")
                                        : NetworkImage(
                                            ytddata[index]['channelimage']))),
                          )),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //Text(data[index]['publishedAt'],style: TextStyle(color: Colors.grey)),
                                Text(
                                  ytddata[index]['channelname'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),

                                OutlineButton(
                                  child: Text("subscribe"),
                                  onPressed: () async {
                                    var url = ytddata[index]['channelurl'];
                                    if (await canLaunch(url)) {
                                      launch(url);
                                    } else {
                                      Scaffold.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text("unable to launch url"),
                                      ));
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      )),
                  onTap: () async {
                    var url = ytddata[index]['channelurl'];
                    if (await canLaunch(url)) {
                      launch(url);
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("unable to launch url"),
                      ));
                    }
                  },
                );
              },
            ),
    );
  }
}
