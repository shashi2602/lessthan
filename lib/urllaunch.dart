import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';
import 'package:firebase_admob/firebase_admob.dart';
MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['Technews', 'mobiles', 'reviews', 'shopping'],

  childDirected: false,// or MobileAdGender.female, MobileAdGender.unknown
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/6311219418',
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
  adUnitId: 'ca-app-pub-3550458721470380/7158818105',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Urllaunch extends StatefulWidget {
  final String url;
  final String source;
  Urllaunch(this.url, this.source);
  @override
  _UrllaunchState createState() => _UrllaunchState();
}

class _UrllaunchState extends State<Urllaunch> {
  // InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
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
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.source,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(widget.url);
              },
            ),
            IconButton(
              icon: Icon(Icons.open_in_browser),
              onPressed: ()async{
                if(await canLaunch(widget.url)){
                  launch(widget.url);
                }
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Cant open url",style: TextStyle(color: Colors.white),),
                    backgroundColor: Colors.black,
                  )
                );
              },
            )
          ],
        ),
        body: WebView(
          initialUrl: widget.url,
        ));
  }
}
