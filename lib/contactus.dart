import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Contactuspage extends StatefulWidget {
  @override
  _ContactuspageState createState() => _ContactuspageState();
}

class _ContactuspageState extends State<Contactuspage> {
  String frommail;
  String body;
  String msg;
  @override
  void initState() {
    super.initState();
    
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
      )..dispose();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Contact us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
              launch('mailto:lessthanco@gmail.com?subject=$msg&body=$body');
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            
            TextField(
              decoration: InputDecoration(
                  labelText: 'To:lessthanco@gmail.com',
                  border: OutlineInputBorder()),
              onChanged: (value) {
                frommail = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'subject:', border: OutlineInputBorder()),
              onChanged: (value) {
                msg = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 20,
              maxLength: 1000,
              decoration: InputDecoration(
                  hintText: 'body:', border: OutlineInputBorder()),
              onChanged: (value) {
                body = value;
              },
            ),
          ],
        ),
      ),
    );
  }
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
