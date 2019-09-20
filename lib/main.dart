import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lessthan/contactus.dart';
import 'package:lessthan/home2.dart';
import 'package:lessthan/mobile_page.dart';
import 'package:lessthan/newsapi.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lessthan/review_page.dart';
import 'package:lessthan/rssfeeddata.dart';
import 'package:lessthan/techiespage.dart';
import 'package:lessthan/urllaunch.dart';
import 'package:lessthan/youtubepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_admob/firebase_admob.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(iconTheme: IconThemeData(color: Colors.black)),
    title: "Lessthan",
    home: Lessthanhome(),
  ));
}

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

class Lessthanhome extends StatefulWidget {
  @override
  _LessthanhomeState createState() => _LessthanhomeState();
}

class _LessthanhomeState extends State<Lessthanhome> {
  
  List ytddata;
  List feedlist;
  List phonefonapidata;
  List ytddata2;
  List offerdata;
  List mobiledata;
  final String mobiledataurl =
      "https://api.rss2json.com/v1/api.json?rss_url=https://www.phonearena.com/feed/new-phones";
  final String ytddataurl =
      "https://www.googleapis.com/youtube/v3/search?q=Technews&part=snippet&key=AIzaSyCdWjNF7pABdjDH1YzJI8TZKu8Ui_L3GdU&maxResults=30";
  
  final String ytdurl = "https://api.jsonbin.io/b/5ccda33dc07f283511e0482e";
  final String feedurl =
      "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=520ca86ab4884f87a84f36e4292dc61d&pageSize=100";
  final String offerurl =
      "https://price-api.datayuge.com/api/v1/offers/list/deals?api_key=aHYSO95IDJs1SeG0bAtFARqqTBMu9QvQCXE&category_tag=mobile-tablets-accessories";
  
  @override
  void initState() {
    super.initState();
    this.getyoutubechanneldata();
    this.getfeeddata();
    this.getmainytddata();
    this.getofferdata();
    this.getmobiledata();
    
      
  }
  



  Future<String> getfeeddata() async {
    var respones = await http
        .get(Uri.encodeFull(feedurl), headers: {"Accept": "application/json"});
    print(respones.body);
    setState(() {
      var convertededdata = json.decode(respones.body);
      feedlist = convertededdata["articles"];
    });
 
    return "success";
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

  Future<String> getmainytddata() async {
    var res = await http.get(Uri.encodeFull(ytddataurl));
    setState(() {
      var converteddata = json.decode(res.body);
      ytddata2 = converteddata['items'];
    });
    return "success";
  }

  Future<String> getofferdata() async {
    var offerres = await http.get(Uri.encodeFull(offerurl));
    setState(() {
      var offerconver = json.decode(offerres.body);
      offerdata = offerconver['data']['data'];
    });
  
    return 'success';
  }

  Future<String> getmobiledata() async {
    var mobileres = await http.get(Uri.encodeFull(mobiledataurl));
    setState(() {
      var mobileconvertion = json.decode(mobileres.body);
      mobiledata = mobileconvertion['items'];
    });
   
    return 'success';
  }

  void showsearch(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Search"),
            content: Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {},
                          color: Colors.black),
                      hintText: 'search',
                      // hintStyle: TextStyle(color: Colors.black),
                      hoverColor: Colors.black,
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                  onSubmitted: (String result) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Homepage2(
                            "https://newsapi.org/v2/everything?q=$result&apiKey=520ca86ab4884f87a84f36e4292dc61d&pagesize=100&language=en",
                            '$result')));
                  },
                ),
              ),
            ),
          );
        });
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
        //backgroundColor: Colors.black,
        resizeToAvoidBottomPadding: false,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Container(
                color: Colors.black,
                height: 200,
                child: Center(
                  child: Text(
                    'Lessthan',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
              ListTile(
                title: Text('Tech News', style: TextStyle(fontSize: 15)),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: (){
                   myInterstitial1
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Homepage()));
                },
              ),
              ListTile(
                title: Text('Mobile', style: TextStyle(fontSize: 15)),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: (){
                   myInterstitial1
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Mobilepage()));
                },
              ),
              ListTile(
                title: Text('Reviews', style: TextStyle(fontSize: 15)),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                onTap: (){
                   myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Reviewpage()));
                },
              ),
             
              ListTile(
                title: Text('Contact us', style: TextStyle(fontSize: 15)),
                onTap: (){
                   myInterstitial2
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Contactuspage()));
                },
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          //leading: Image.asset("images/logo.png"),
          backgroundColor: Colors.black,
          centerTitle: true,
          elevation: 2,

          title: Text("Lessthan",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () {
                showsearch(context);
              },
            ),
            // IconButton(
            //   icon: Icon(MdiIcons.cellphoneAndroid),
            //   onPressed: (){
            //       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Deviceinfopage()));
            //   },
            // )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: getfeeddata,
          child: ListView(

            children: <Widget>[
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text("Techie",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: GestureDetector(
                        child: Text("More",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.normal)),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext contex) => Techies()));
                        },
                      )),
                    ),
                  )
                ],
              ),
              ytddata == null
                  ? SpinKitPulse(
                      color: Colors.black,
                    )
                  : Container(
                      height: 100,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          ytdchip(
                              ytddata[0]['channelname'],
                              ytddata[0]['channelimage'],
                              ytddata[0]['channelurl'],
                              context),
                          ytdchip(
                              ytddata[1]['channelname'],
                              ytddata[1]['channelimage'],
                              ytddata[1]['channelurl'],
                              context),
                          ytdchip(
                              ytddata[2]['channelname'],
                              ytddata[2]['channelimage'],
                              ytddata[2]['channelurl'],
                              context),
                          ytdchip(
                              ytddata[3]['channelname'],
                              ytddata[3]['channelimage'],
                              ytddata[3]['channelurl'],
                              context),
                          ytdchip(
                              ytddata[4]['channelname'],
                              ytddata[4]['channelimage'],
                              ytddata[4]['channelurl'],
                              context),
                          ytdchip(
                              ytddata[5]['channelname'],
                              ytddata[5]['channelimage'],
                              ytddata[5]['channelurl'],
                              context),
                        ],
                      ),
                    ),

              //////////////////////////////////////latestarticals////////////////////////////////////////////////////////
              ///////////////////////////////////////////////////////////////////////////////////////////////////////////
              ////////////////////////////////////////////////////////////////////////////
              
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[300]),
                  color: Colors.grey[200],
                ),
              ),
              ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              ////////////////////////////////////////////////////////////////////////////////////////////////////////////
              //////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                height: 210,
                width: MediaQuery.of(context).size.width - 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                         myInterstitial
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Homepage()));
                      },
                      child: Container(
                        height: 200,
                        child: Center(
                            child: Text("Technews",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25))),
                        width: (MediaQuery.of(context).size.width - 30) / 2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://i.ibb.co/Dtr0JGJ/tech.png"),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15))),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                             myInterstitial2
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Mobilepage()));
                          },
                          child: Container(
                            height: 95,
                            child: Center(
                                child: Text("mobiles",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25))),
                            margin: EdgeInsets.only(top: 5),
                            width: (MediaQuery.of(context).size.width - 80) / 2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://i.ibb.co/XzTQG85/mobile.png"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                             myInterstitial1
                ..load()
                ..show(
                  anchorType: AnchorType.bottom,
                  anchorOffset: 0.0,
                );
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Reviewpage()));
                          },
                          child: Container(
                            height: 95,
                            child: Center(
                                child: Text("Reviews",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25))),
                            margin: EdgeInsets.only(bottom: 5),
                            width: (MediaQuery.of(context).size.width - 80) / 2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://i.ibb.co/D5Vbx6w/reviw.png"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15))),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),

              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[300]),
                  color: Colors.grey[200],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
                child: Container(
                  child: Text(
                    "Just landed",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              Container(
                height: 100,
                child: mobiledata == null
                    ? SpinKitPulse(color: Colors.black)
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          mobiles(context, mobiledata[0]['thumbnail'],
                              mobiledata[0]['title'], mobiledata[0]['link']),
                          mobiles(context, mobiledata[1]['thumbnail'],
                              mobiledata[1]['title'], mobiledata[1]['link']),
                          mobiles(context, mobiledata[2]['thumbnail'],
                              mobiledata[2]['title'], mobiledata[2]['link']),
                          mobiles(context, mobiledata[3]['thumbnail'],
                              mobiledata[3]['title'], mobiledata[3]['link']),
                          mobiles(context, mobiledata[4]['thumbnail'],
                              mobiledata[4]['title'], mobiledata[4]['link']),
                          mobiles(context, mobiledata[5]['thumbnail'],
                              mobiledata[5]['title'], mobiledata[5]['link']),
                          mobiles(context, mobiledata[6]['thumbnail'],
                              mobiledata[6]['title'], mobiledata[6]['link']),
                          mobiles(context, mobiledata[7]['thumbnail'],
                              mobiledata[7]['title'], mobiledata[7]['link']),
                          mobiles(context, mobiledata[8]['thumbnail'],
                              mobiledata[8]['title'], mobiledata[8]['link']),
                          mobiles(context, mobiledata[9]['thumbnail'],
                              mobiledata[9]['title'], mobiledata[9]['link']),
                        ],
                      ),
              ),
              Center(
                child: Text(
                  'By phonearena.com',
                  style: TextStyle(fontSize: 8),
                ),
              ),
              ////////////////////////////////////////////////////////////////////////////////////////////////////////////
              ///////////////////////////////////////////////////////////////////////////////////////////////////////////
              ///
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[300]),
                  color: Colors.grey[200],
                ),
              ),
              //////////////////////////////////////////////////////////////////////////////////////////////////////////////
              /////////////////////////////
              ///
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
                child: Container(
                  child: Text(
                    "Now in news",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              feedlist == null
                  ? SpinKitPulse(
                      color: Colors.black,
                    )
                  : Container(
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          bigcard(
                              context,
                              feedlist[0]["urlToImage"],
                              feedlist[0]['title'],
                              feedlist[0]['source']['name'],
                              feedlist[0]["url"]),
                          cards(
                              context,
                              feedlist[1]['title'],
                              feedlist[1]["urlToImage"],
                              feedlist[1]['source']['name'],
                              feedlist[1]["url"]),
                          cards(
                              context,
                              feedlist[2]['title'],
                              feedlist[2]["urlToImage"],
                              feedlist[2]['source']['name'],
                              feedlist[2]["url"]),
                          cards(
                              context,
                              feedlist[3]['title'],
                              feedlist[3]["urlToImage"],
                              feedlist[3]['source']['name'],
                              feedlist[3]["url"]),
                          cards(
                              context,
                              feedlist[4]['title'],
                              feedlist[4]["urlToImage"],
                              feedlist[4]['source']['name'],
                              feedlist[4]["url"]),
                          cards(
                              context,
                              feedlist[5]['title'],
                              feedlist[5]["urlToImage"],
                              feedlist[5]['source']['name'],
                              feedlist[5]["url"]),
                          cards(
                              context,
                              feedlist[6]['title'],
                              feedlist[6]["urlToImage"],
                              feedlist[6]['source']['name'],
                              feedlist[6]["url"]),
                          cards(
                              context,
                              feedlist[7]['title'],
                              feedlist[7]["urlToImage"],
                              feedlist[7]['source']['name'],
                              feedlist[7]["url"]),
                          cards(
                              context,
                              feedlist[8]['title'],
                              feedlist[8]["urlToImage"],
                              feedlist[8]['source']['name'],
                              feedlist[8]["url"]),
                          cards(
                              context,
                              feedlist[9]['title'],
                              feedlist[9]["urlToImage"],
                              feedlist[9]['source']['name'],
                              feedlist[9]["url"]),
                          cards(
                              context,
                              feedlist[10]['title'],
                              feedlist[10]["urlToImage"],
                              feedlist[10]['source']['name'],
                              feedlist[10]["url"]),
                          FlatButton(
                            child: Text(
                              "View More Tech",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Homepage()));
                            },
                          )
                        ],
                      ),
                    ),
              ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              ///////////////////////////////////////////////////youtube videos/////////////////////////////////////////////////////////
              /////////////////////////////////////////////////////////////////////////////////////////////////////////

              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[300]),
                  color: Colors.grey[200],
                ),
              ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  // height: 100,
                  margin: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Wrap(
                    spacing: 5,
                    //scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      newssites(
                          context,
                          "https://botw-pd.s3.amazonaws.com/styles/logo-thumbnail/s3/062018/untitled-4_8.png?yGQZBZh9YARO4DXjtqIhId7vRVwgmF6_&itok=paUnJdFc",
                          "Gizmodo",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://gizmodo.com/rss&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://www.robolink.com/wp-content/uploads/2016/08/cnet.png",
                          "Cnet",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.cnet.com/rss/all/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://assets.ifttt.com/images/channels/576658109/icons/large.png",
                          "Slashdot",
                          "https://api.rss2json.com/v1/api.json?rss_url=http://rss.slashdot.org/Slashdot/slashdotMain&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://www.nowsecure.com/wp-content/uploads/2017/02/wired-uk-logo.png",
                          "Wired",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.wired.com/rss/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://automatedinsights.com/wp-content/uploads/2018/05/engadget-logo.png",
                          "Engadget",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.engadget.com/rss.xml&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://i0.wp.com/www.universitybeyond.com/wp-content/uploads/2016/06/Techcrunch-logo.png?fit=360%2C220&ssl=1",
                          "Techcrunch",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://techcrunch.com/feed/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://eig.org/wp-content/uploads/2017/08/Mashable-Logo.png",
                          "Mashable",
                          "https://api.rss2json.com/v1/api.json?rss_url=http://feeds.mashable.com/Mashable&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://www.atomicreach.com/hubfs/Atomic_Reach_May2018/images/tnw-thenextweb-logo.png",
                          "Thenextweb",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://thenextweb.com/feed/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://yolofamilytravel.com/wp-content/uploads/2018/05/verge-logo.png",
                          "Verge",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.theverge.com/rss/index.xml&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Lifehacker.svg/1280px-Lifehacker.svg.png",
                          "Lifehacker",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://lifehacker.com/rss&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/XDADevelopers.svg/1280px-XDADevelopers.svg.png",
                          "xda",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.xda-developers.com/feed/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://cdn-images-1.medium.com/max/1600/1*CVOGx9ckrpWyTvtQgauYpw.jpeg",
                          "hackernews",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://news.ycombinator.com/rss&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://prnews.io/content/platform/25202/logo.jpeg?1544774994",
                          "Beebom",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://beebom.com/feed/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbj0a9gJmhfp5SweY61Hbv1-rgnn_DjI00eKCzGah5GJCzyiLr",
                          "Techviral",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://techviral.net/feed/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/TechRadar_logo.svg/1280px-TechRadar_logo.svg.png",
                          "Techradar",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.techradar.com/rss&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxZzuNQ0i69R1jmCqtXJvYAAVFsIwqxgXWpf_rnbpdmelSRYCS",
                          "Technewsworld",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.technewsworld.com/perl/syndication/rssfull.pl?__hstc=67659214.7b0be48a49b4418d52070f8ca836d1f0.1560079589389.1560079589389.1560079589389.1&__hssc=67659214.3.1560079589390&__hsfp=3478579211"),
                      newssites(
                          context,
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJRjrtN5hot1hXBhiiXT9v81vc-Ev6GU3aXcBOL--RlVZ3imeZ",
                          "digit",
                          "https://api.rss2json.com/v1/api.json?rss_url=http://feeds.feedburner.com/digit/latest-from-digit&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://www.checkmarx.com/wp-content/uploads/2018/12/DZLogo345x195.png",
                          "Dzone",
                          "https://api.rss2json.com/v1/api.json?rss_url=http://feeds.dzone.com/home&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://lh3.googleusercontent.com/J6_coFbogxhRI9iM864NL_liGXvsQp2AupsKei7z0cNNfDvGUmWUy20nuUhkREQyrpY4bEeIBuc=w300",
                          "Googlenews",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://news.google.com/rss?hl=en-IN&gl=IN&ceid=IN:en"),
                      newssites(
                          context,
                          "https://upload.wikimedia.org/wikipedia/commons/a/ad/Gadgets_Now_logo.jpg",
                          "Gadgetsnow",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.gadgetsnow.com/rssfeeds/2147478039.cms&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://s2.wp.com/wp-content/themes/vip/bgr/images/sprite_2x/logo-header-black.png",
                          "Bgr",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.bgr.in/feed/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "http://www.9folders.com/wp-content/uploads/2016/08/Android-Police-logo.png",
                          "Androidpolice",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.androidpolice.com/feed/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                      newssites(
                          context,
                          "https://yt3.ggpht.com/a/AGF-l7-7gvUx-cONHOKIRYoy_G3sQdm_t3YSuQ-qvw=s900-mo-c-c0xffffffff-rj-k-no",
                          "Pcmag",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.pcmag.com/Rss.aspx/SectionArticles?FsectionId=1713&api_key=ah09tj2gpc9wggj7joh9aq8komm3tb19ehhsis2j"),
                      newssites(
                          context,
                          "https://www.technologyreview.com/_/img/stacked-logo-v2--125x62.png",
                          'MIT tech',
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.technologyreview.com/c/mobile/rss/&api_key=ah09tj2gpc9wggj7joh9aq8komm3tb19ehhsis2j"),
                      newssites(
                          context,
                          "https://images.indianexpress.com/2018/10/fav-icon.png?w=32",
                          "Indianexpress",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://indianexpress.com/section/technology/feed/&api_key=ah09tj2gpc9wggj7joh9aq8komm3tb19ehhsis2j"),
                      newssites(
                        context,
                        "https://www.hindustantimes.com/res/img/app-images/HomePageV1/HT-Logo.gif",
                        "hindustantimes",
                        "https://api.rss2json.com/v1/api.json?rss_url=https://www.hindustantimes.com/rss/tech-gadgets/rssfeed.xml&api_key=ah09tj2gpc9wggj7joh9aq8komm3tb19ehhsis2j",
                      ),
                      newssites(
                          context,
                          "https://cscottbrown.net/wp-content/uploads/2017/12/photo.jpg",
                          "Android authority",
                          "https://api.rss2json.com/v1/api.json?rss_url=https://www.androidauthority.com/feed/&api_key=deii8elyho882qqcwdpmhxlrnvzdnmbxsffvm7uf"),
                    ],
                  ),
                ),
              ),

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey[300]),
                  color: Colors.grey[200],
                ),
              ),
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              ///

              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, top: 20),
                child: Container(
                    child: Text(
                  "Youtube",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
              ),

              ytddata2 == null
                  ? SpinKitPulse(
                      color: Colors.black,
                    )
                  : Container(
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 200,
                                  margin: EdgeInsets.only(top: 10, bottom: 2),
                                  width: MediaQuery.of(context).size.width - 20,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      image: DecorationImage(
                                          image: NetworkImage(ytddata2[2]
                                                  ['snippet']['thumbnails']
                                              ['high']['url']),
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
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: Text(
                                        ytddata2[2]['snippet']['channelTitle'],
                                        style: TextStyle(color: Colors.black))),
                                Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: Text(ytddata2[2]['snippet']['title'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700))),
                              ],
                            ),
                            onTap: () async {
                              String url =
                                  "https://www.youtube.com/watch?v=${ytddata2[2]['id']['videoId']}";
                              if (await canLaunch(url)) {
                                launch(url);
                              } else {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("can't launch url"),
                                ));
                              }
                              //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Ytdplayvideo(ytddata2[2]['id']['videoId'],ytddata2[2]['snippet']['channelTitle'])));
                            },
                          ),
                          cards2(
                              context,
                              ytddata2[1]['snippet']['title'],
                              ytddata2[1]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[1]['snippet']['channelTitle'],
                              ytddata2[1]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[11]['snippet']['title'],
                              ytddata2[11]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[11]['snippet']['channelTitle'],
                              ytddata2[11]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[3]['snippet']['title'],
                              ytddata2[3]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[3]['snippet']['channelTitle'],
                              ytddata2[3]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[4]['snippet']['title'],
                              ytddata2[4]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[4]['snippet']['channelTitle'],
                              ytddata2[4]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[5]['snippet']['title'],
                              ytddata2[5]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[5]['snippet']['channelTitle'],
                              ytddata2[5]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[6]['snippet']['title'],
                              ytddata2[6]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[6]['snippet']['channelTitle'],
                              ytddata2[6]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[7]['snippet']['title'],
                              ytddata2[7]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[7]['snippet']['channelTitle'],
                              ytddata2[7]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[8]['snippet']['title'],
                              ytddata2[8]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[8]['snippet']['channelTitle'],
                              ytddata2[8]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[9]['snippet']['title'],
                              ytddata2[9]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[9]['snippet']['channelTitle'],
                              ytddata2[9]['id']['videoId']),
                          cards2(
                              context,
                              ytddata2[10]['snippet']['title'],
                              ytddata2[10]['snippet']['thumbnails']['default']
                                  ['url'],
                              ytddata2[10]['snippet']['channelTitle'],
                              ytddata2[10]['id']['videoId']),
                          FlatButton(
                            child: Text(
                              "View More Tech",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Ytdpage()));
                            },
                          )
                        ],
                      ),
                    ),

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////offers data/////////////////////////////////////////////////////////////////////////

// Container(
//             height:10,
//             width: double.infinity,

//             decoration: BoxDecoration(
//               border: Border.all(width: 0.5,color: Colors.grey[300]),
//               color: Colors.grey[200],
//             ),
//           ),
//            Padding(
//             padding: const EdgeInsets.only(left:20,bottom:10,top: 20),
//             child: Container(child: Text("Offers",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
//           ),
//          offerdata==null?
//          SpinKitPulse(color: Colors.black,)
//          : Container(
//             child: Column(
//               children: <Widget>[
//                 Offercards(context, offerdata[0]['title'], offerdata[0]['deals_store']['store_image'], offerdata[0]['store_name'], offerdata[0]['store_url'], offerdata[0]['description'], offerdata[0]['category_name'],offerdata[0]['expires_at']),
//                 Offercards(context, offerdata[1]['title'], offerdata[1]['deals_store']['store_image'], offerdata[1]['store_name'], offerdata[1]['store_url'], offerdata[1]['description'], offerdata[1]['category_name'],offerdata[1]['expires_at']),
//                 Offercards(context, offerdata[2]['title'], offerdata[2]['deals_store']['store_image'], offerdata[2]['store_name'], offerdata[2]['store_url'], offerdata[2]['description'], offerdata[2]['category_name'],offerdata[2]['expires_at']),
//                 Offercards(context, offerdata[3]['title'], offerdata[3]['deals_store']['store_image'], offerdata[3]['store_name'], offerdata[3]['store_url'], offerdata[3]['description'], offerdata[3]['category_name'],offerdata[3]['expires_at']),
//                 Offercards(context, offerdata[4]['title'], offerdata[4]['deals_store']['store_image'], offerdata[4]['store_name'], offerdata[4]['store_url'], offerdata[4]['description'], offerdata[4]['category_name'],offerdata[4]['expires_at']),
//                 Offercards(context, offerdata[5]['title'], offerdata[5]['deals_store']['store_image'], offerdata[5]['store_name'], offerdata[5]['store_url'], offerdata[5]['description'], offerdata[5]['category_name'],offerdata[5]['expires_at']),
//                 Offercards(context, offerdata[6]['title'], offerdata[6]['deals_store']['store_image'], offerdata[6]['store_name'], offerdata[6]['store_url'], offerdata[6]['description'], offerdata[6]['category_name'],offerdata[6]['expires_at']),
//                 Offercards(context, offerdata[7]['title'], offerdata[7]['deals_store']['store_image'], offerdata[7]['store_name'], offerdata[7]['store_url'], offerdata[7]['description'], offerdata[7]['category_name'],offerdata[7]['expires_at']),
//                 Offercards(context, offerdata[8]['title'], offerdata[8]['deals_store']['store_image'], offerdata[8]['store_name'], offerdata[8]['store_url'], offerdata[8]['description'], offerdata[8]['category_name'],offerdata[8]['expires_at']),
//                 Offercards(context, offerdata[9]['title'], offerdata[9]['deals_store']['store_image'], offerdata[9]['store_name'], offerdata[9]['store_url'], offerdata[9]['description'], offerdata[9]['category_name'],offerdata[9]['expires_at']),
//                 Offercards(context, offerdata[10]['title'], offerdata[10]['deals_store']['store_image'], offerdata[10]['store_name'], offerdata[10]['store_url'], offerdata[10]['description'], offerdata[10]['category_name'],offerdata[10]['expires_at']),
//                 //Offercards(context, offerdata[0]['title'], offerdata[0]['deals_store']['store_image'], offerdata[0]['store_name'], offerdata[0]['store_url'], offerdata[0]['description'], offerdata[0]['category_name'],offerdata[0]['expires_at']),
//                 FlatButton(
//                   child: Text('More Offers',style: TextStyle(color: Colors.blue),),
//                   onPressed: (){
//                   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Offerpage()));

//                   },
//                 )
//               ],

//             ),
//           ),
              ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              /////////////////////////////////////////////////////////////////////////////////////////////////////////////
              /////////////////////////////////////////////////////////////////////////////////////////////////////////
            ],
          ),
        ));
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////widgets/////////////////////////////////////////////////
Widget ytdchip(
    String text, String imgurl, String ytdurl, BuildContext context) {
  return GestureDetector(
    onTap: () async {
      var urls = ytdurl;
      if (await canLaunch(urls)) {
        launch(urls);
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("unable to reach it please try after sometime"),
        ));
      }
    },
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: NetworkImage(imgurl))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            text,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        )
      ],
    ),
  );
}

Widget cards(BuildContext context, String title, String image, String source,
    String url) {
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
                      Image.network(
                        'https://www.google.com/s2/favicons?domain=$source',
                        scale: 1.5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
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
                              "https://dummyimage.com/600x400/575657/ffffff.png&text=lessthan")
                          : NetworkImage(image))),
            )),
          ],
        )),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Urllaunch(url, source)));
    },
  );
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
                              "https://dummyimage.com/600x400/575657/ffffff.png&text=lessthan")
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
      // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Ytdplayvideo(url, source)));
    },
  );
}

Widget offercards(BuildContext context, String title, String image,
    String source, String url, String des, String cat, String exp) {
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
                  des == null
                      ? Text("no info")
                      : Text(
                          des,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                  Text(cat,
                      style: TextStyle(color: Colors.grey),
                      overflow: TextOverflow.fade),
                  Text(
                    source,
                    style: TextStyle(color: Colors.grey),
                  ),

                  Text(exp)
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
                              "https://dummyimage.com/600x400/575657/ffffff.png&text=lessthan")
                          : NetworkImage(image))),
            )),
          ],
        )),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Urllaunch(url, source)));
    },
  );
}

Widget newssites(BuildContext context, String image, String text, String api) {
  return Card(
    child: Container(
      height: 100,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => Rssfeeddata(api, text)));
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
              Padding(
                  padding: EdgeInsets.all(0),
                  child: Text(
                    text,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}

Widget mobiles(BuildContext context, String image, String text, String url) {
  return Container(
    height: 100,
    width: 100,
    child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => Urllaunch(url, text)));
      },
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(image)),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
              )),
        ],
      ),
    ),
  );
}

Widget phonecard() {
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
                    'Mobile name',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Wrap(
                    runSpacing: 5,
                    spacing: 5,
                    children: <Widget>[
                      Text("chipset"),
                      Text("os"),
                      Text("carmeras"),
                      Text("colors"),
                      Text("gpu"),
                      Text("price")
                    ],
                  )
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
                      image: NetworkImage(
                          "https://dummyimage.com/600x400/575657/ffffff.png&text=lessthan"))),
            )),
          ],
        )),
    onTap: () async {
      // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Urllaunch(url, source)));
    },
  );
}

Widget bigcard(BuildContext context, String image, String text, String source,
    String url) {
  return GestureDetector(
    child: Column(
      children: <Widget>[
        Container(
          height: 200,
          margin: EdgeInsets.only(top: 10, bottom: 2),
          width: MediaQuery.of(context).size.width - 20,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              image: DecorationImage(
                  image: image == null
                      ? NetworkImage(
                          "https://dummyimage.com/600x400/575657/ffffff.png&text=lessthan")
                      : NetworkImage(image),
                  fit: BoxFit.cover)),
        ),
        Container(
            width: MediaQuery.of(context).size.width - 20,
            child: Text(source, style: TextStyle(color: Colors.black))),
        Container(
            margin: EdgeInsets.only(bottom: 20),
            width: MediaQuery.of(context).size.width - 20,
            child: Text(text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
      ],
    ),
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Urllaunch(url, source)));
    },
  );
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['Technews', 'mobiles', 'reviews', 'shopping','amazon','technology'],

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
  adUnitId: 'ca-app-pub-3550458721470380/4570461012',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);

InterstitialAd myInterstitial1 = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/9505779845',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);InterstitialAd myInterstitial2 = InterstitialAd(
  // Replace the testAdUnitId with an ad unit id from the AdMob dash.
  // https://developers.google.com/admob/android/test-ads
  // https://developers.google.com/admob/ios/test-ads
  adUnitId: 'ca-app-pub-3550458721470380/6392531346',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);
