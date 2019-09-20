import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  adUnitId: 'ca-app-pub-3550458721470380/6151120086',
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
  adUnitId: 'ca-app-pub-3550458721470380/4570461012',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);



class Ytdpage extends StatefulWidget {
  @override
  _YtdpageState createState() => _YtdpageState();
}

class _YtdpageState extends State<Ytdpage> {
  String url =
      "https://www.googleapis.com/youtube/v3/search?q=Technews&part=snippet&key=AIzaSyCmNdM0x0CMKSPZnjF0X-xxKmMHzXntB9w&maxResults=30";
  List data;
  @override
  void initState() {

    super.initState();
    this.getyoutubedata();
    myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
  }

  Future<String> getyoutubedata() async {
    var response = await http.get(
      Uri.encodeFull(url),
    );
    setState(() {
      var covertdata = json.decode(response.body);
      data = covertdata['items'];
    });

    return 'success';
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
                ..load()
                ..show(
                 // anchorType: AnchorType.bottom,
                  //anchorOffset: 0.0,
                );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "videos",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: data == null
          ? Center(
              child: SpinKitPulse(
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemCount: data.length == null
                  ? Center(child: Text("error"))
                  : data.length,
              itemBuilder: (context, int index) {
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
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //Text(data[index]['publishedAt'],style: TextStyle(color: Colors.grey)),
                                Text(
                                  data[index]['snippet']['title'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ),

                                Text(
                                  data[index]['snippet']['channelTitle'],
                                  style: TextStyle(color: Colors.grey),
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
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: data[index]['snippet']['thumbnails']
                                                ['default']['url'] ==
                                            null
                                        ? NetworkImage(
                                            "https://via.placeholder.com/150x150.png?text=Lessthan")
                                        : NetworkImage(data[index]['snippet']
                                            ['thumbnails']['default']['url']))),
                          )),
                        ],
                      )),
                  onTap: () async {
                    String url =
                        "https://www.youtube.com/watch?v=${data[index]['id']['videoId']}";
                    if (await canLaunch(url)) {
                      launch(url);
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("can't launch url"),
                      ));
                    }
                    //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Ytdplayvideo(data[index]['id']['videoId'],data[index]['snippet']['channelTitle'])));
                  },
                );
              },
            ),
    );
  }
}
