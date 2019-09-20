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


InterstitialAd myInterstitial = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/9820408956',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

class Mainytddata2 extends StatefulWidget {
  @override
  _Mainytddata2State createState() => _Mainytddata2State();
}

class _Mainytddata2State extends State<Mainytddata2> {
  final String ytddata2url =
      "https://www.googleapis.com/youtube/v3/search?q=Technews&part=snippet&key=AIzaSyCdWjNF7pABdjDH1YzJI8TZKu8Ui_L3GdU&maxResults=30";
  List ytddata2;
  @override
  void initState() {
    super.initState();
    this.getmainytddata2();
    myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
  }

  Future<String> getmainytddata2() async {
    var res = await http.get(Uri.encodeFull(ytddata2url));
    setState(() {
      var converteddata = json.decode(res.body);
      ytddata2 = converteddata['items'];
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
    return ytddata2 == null
        ? SpinKitPulse(
            color: Colors.black,
          )
        : Container(
            child: Column(
              children: <Widget>[
                Text(
                  "Videos",
                  style: TextStyle(fontSize: 20),
                ),
                GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        margin: EdgeInsets.only(top: 10, bottom: 2),
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                image: NetworkImage(ytddata2[11]['snippet']
                                    ['thumbnails']['high']['url']),
                                fit: BoxFit.cover)),
                        child: Center(
                          child: Icon(
                            Icons.play_arrow,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(ytddata2[11]['snippet']['channelTitle'],
                              style: TextStyle(color: Colors.black))),
                      Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width - 20,
                          child: Text(ytddata2[11]['snippet']['title'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700))),
                    ],
                  ),
                  onTap: () async {
                    //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Ytdplayvideo(ytddata2[11]['id']['videoId'],ytddata2[11]['snippet']['channelTitle'])));
                    String id = ytddata2[11]['id']['videoId'];
                    String url = "https://www.youtube.com/watch?v=$id";
                    if (await canLaunch(url)) {
                      launch(url);
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("can't launch url"),
                      ));
                    }
                  },
                ),
                cards2(
                    context,
                    ytddata2[1]['snippet']['title'],
                    ytddata2[1]['snippet']['thumbnails']['default']['url'],
                    ytddata2[1]['snippet']['channelTitle'],
                    ytddata2[1]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[2]['snippet']['title'],
                    ytddata2[2]['snippet']['thumbnails']['default']['url'],
                    ytddata2[2]['snippet']['channelTitle'],
                    ytddata2[2]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[3]['snippet']['title'],
                    ytddata2[3]['snippet']['thumbnails']['default']['url'],
                    ytddata2[3]['snippet']['channelTitle'],
                    ytddata2[3]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[4]['snippet']['title'],
                    ytddata2[4]['snippet']['thumbnails']['default']['url'],
                    ytddata2[4]['snippet']['channelTitle'],
                    ytddata2[4]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[5]['snippet']['title'],
                    ytddata2[5]['snippet']['thumbnails']['default']['url'],
                    ytddata2[5]['snippet']['channelTitle'],
                    ytddata2[5]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[6]['snippet']['title'],
                    ytddata2[6]['snippet']['thumbnails']['default']['url'],
                    ytddata2[6]['snippet']['channelTitle'],
                    ytddata2[6]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[7]['snippet']['title'],
                    ytddata2[7]['snippet']['thumbnails']['default']['url'],
                    ytddata2[7]['snippet']['channelTitle'],
                    ytddata2[7]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[8]['snippet']['title'],
                    ytddata2[8]['snippet']['thumbnails']['default']['url'],
                    ytddata2[8]['snippet']['channelTitle'],
                    ytddata2[8]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[9]['snippet']['title'],
                    ytddata2[9]['snippet']['thumbnails']['default']['url'],
                    ytddata2[9]['snippet']['channelTitle'],
                    ytddata2[9]['id']['videoId']),
                cards2(
                    context,
                    ytddata2[10]['snippet']['title'],
                    ytddata2[10]['snippet']['thumbnails']['default']['url'],
                    ytddata2[10]['snippet']['channelTitle'],
                    ytddata2[10]['id']['videoId'])
              ],
            ),
          );
  }
}

Widget cards2(BuildContext context, String title, String image, String source,
    String id) {
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
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),

                  Row(
                    children: <Widget>[
                      Text(
                        source,
                        style: TextStyle(color: Colors.grey),
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
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: image == null
                          ? NetworkImage(
                              "https://via.placeholder.com/150x150.png?text=Lessthan")
                          : NetworkImage(image))),
              child: Center(
                child: Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            )),
          ],
        )),
    onTap: () async {
      String url = "https://www.youtube.com/watch?v=$id";
      if (await canLaunch(url)) {
        launch(url);
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("can't launch url"),
        ));
      }
      //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Ytdplayvideo(url, source)));
    },
  );
}
