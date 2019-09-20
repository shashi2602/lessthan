import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lessthan/mobile_search_page.dart';
import 'package:lessthan/urllaunch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Mobilepage extends StatefulWidget {
  @override
  _MobilepageState createState() => _MobilepageState();
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
  adUnitId: 'ca-app-pub-3550458721470380/9820408956',
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("InterstitialAd event is $event");
  },
);
class _MobilepageState extends State<Mobilepage> {
  String url1 = 'https://api.rss2json.com/v1/api.json?rss_url=https://www.gizbot.com/rss/mobile-fb.xml';
  String url2 = 'https://api.rss2json.com/v1/api.json?rss_url=https://gadgets.ndtv.com/rss/mobiles/feeds';
  String url3 = 'https://api.rss2json.com/v1/api.json?rss_url=https://www.digitaltrends.com/mobile/feed';
  String url4 = 'https://api.rss2json.com/v1/api.json?rss_url=http://phonedb.net/rss';
  
  List mobilefeed1;
  List mobilefeed2;
  List mobilefeed3;
  List mobilefeed4;
 
  String results;
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
    this.getmobiledata1();
    this.getmobiledata2();
    this.getmobiledata3();
    this.getmobiledata4();
   
  }

@override
  void dispose() {
    super.dispose();
  }
  Future<String> getmobiledata1() async {
    var mobile1res = await http.get(Uri.encodeFull(url1));
    setState(() {
      var mobile1cont = json.decode(mobile1res.body);
      mobilefeed1 = mobile1cont['items'];
    });
    
    return 'success';
  }
  

  Future<String> getmobiledata2() async {
    var mobile2res = await http.get(Uri.encodeFull(url2));
    setState(() {
      var mobile2cont = json.decode(mobile2res.body);
      mobilefeed2 = mobile2cont['items'];
    });
    return 'success';
  }

  Future<String> getmobiledata3() async {
    var mobile3res = await http.get(Uri.encodeFull(url3));
    setState(() {
      var mobile3cont = json.decode(mobile3res.body);
      mobilefeed3 = mobile3cont['items'];
    });
    return 'success';
  }

  Future<String> getmobiledata4() async {
    var mobile4res = await http.get(Uri.encodeFull(url4));
    setState(() {
      var mobile4cont = json.decode(mobile4res.body);
      mobilefeed4 = mobile4cont['items'];
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
        // Positions the banner ad 60 pixels from the bottom of the screen
        //anchorOffset: 60.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mobile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: mobilefeed1==null||mobilefeed2==null||mobilefeed3==null||mobilefeed4==null?SpinKitPulse(color: Colors.black,):ListView(
        children: <Widget>[
          Container(
            
            height: 100,
            margin: EdgeInsets.all(5),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                 onSubmitted: (String result){
                   results=result;
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Mobileresults('https://price-api.datayuge.com/api/v1/compare/search?api_key=aHYSO95IDJs1SeG0bAtFARqqTBMu9QvQCXE&product=$result',result)));
               print('https://price-api.datayuge.com/api/v1/compare/search?api_key=aHYSO95IDJs1SeG0bAtFARqqTBMu9QvQCXE&product=$result');
                },
                decoration: InputDecoration(
                  hintText: 'Mobile name',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: Colors.black
                    )
                  ),
                  suffixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.search),
                    onPressed: (){
                 // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Mobileresults('https://price-api.datayuge.com/api/v1/compare/search?api_key=aHYSO95IDJs1SeG0bAtFARqqTBMu9QvQCXE&product=$results',results)));                      
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),

                     borderSide: BorderSide(
                      color: Colors.black
                    )
                  )
                ),
               
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            margin: EdgeInsets.all(10),
            child: Wrap(
              spacing: 10,
              runSpacing: 5,
              children: <Widget>[
                chips('Redmi',context),
                chips('Realme',context),
                chips('Samsung',context),
                chips('Honor',context),
                chips('Oneplus+',context),
                chips('Apple Iphone',context),
                chips('Oppo',context),
                chips('Vivo',context),
                chips('Asus',context),
                chips('ROG',context),
                chips('Pixel',context),
                chips('Black shark',context),
                chips('Nokia',context),
                chips('LG',context),
                chips('Motorola',context),
                chips('lenovo',context)
              ],
            ),
          ),
          bigcard(context, mobilefeed1[0]['thumbnail'], mobilefeed1[0]['link'], mobilefeed1[0]['title'],mobilefeed1[0]['author'],mobilefeed1[0]['enclosure']['link']),
          mobile_1(context, mobilefeed2[0]['thumbnail'], mobilefeed2[0]['link'], mobilefeed2[0]['title'],mobilefeed2[0]['author'],mobilefeed2[0]['enclosure']['link'] ),
          mobile_1(context, mobilefeed3[0]['thumbnail'], mobilefeed3[0]['link'], mobilefeed3[0]['title'],mobilefeed3[0]['author'],mobilefeed3[0]['enclosure']['link'] ),
          mobile_1(context, mobilefeed4[0]['thumbnail'], mobilefeed4[0]['link'], mobilefeed4[0]['title'],mobilefeed4[0]['author'],mobilefeed4[0]['enclosure']['link'] ),
          mobile_1(context, mobilefeed1[1]['thumbnail'], mobilefeed1[1]['link'], mobilefeed1[1]['title'],mobilefeed1[1]['author'],mobilefeed1[1]['enclosure']['link'] ),
          mobile_1(context, mobilefeed2[1]['thumbnail'], mobilefeed2[1]['link'], mobilefeed2[1]['title'],mobilefeed2[1]['author'],mobilefeed2[1]['enclosure']['link'] ),
          mobile_1(context, mobilefeed3[1]['thumbnail'], mobilefeed3[1]['link'], mobilefeed3[1]['title'],mobilefeed3[1]['author'],mobilefeed3[1]['enclosure']['link'] ),
          mobile_1(context, mobilefeed4[1]['thumbnail'], mobilefeed4[1]['link'], mobilefeed4[1]['title'],mobilefeed4[1]['author'],mobilefeed4[1]['enclosure']['link'] ),
          mobile_1(context, mobilefeed1[2]['thumbnail'], mobilefeed1[2]['link'], mobilefeed1[2]['title'],mobilefeed1[2]['author'],mobilefeed1[2]['enclosure']['link'] ),
          mobile_1(context, mobilefeed2[2]['thumbnail'], mobilefeed2[2]['link'], mobilefeed2[2]['title'],mobilefeed2[2]['author'],mobilefeed2[2]['enclosure']['link'] ),
          mobile_1(context, mobilefeed3[2]['thumbnail'], mobilefeed3[2]['link'], mobilefeed3[2]['title'],mobilefeed3[2]['author'],mobilefeed3[2]['enclosure']['link'] ),
          mobile_1(context, mobilefeed4[2]['thumbnail'], mobilefeed4[2]['link'], mobilefeed4[2]['title'],mobilefeed4[2]['author'],mobilefeed4[2]['enclosure']['link'] ),
          mobile_1(context, mobilefeed1[3]['thumbnail'], mobilefeed1[3]['link'], mobilefeed1[3]['title'],mobilefeed1[3]['author'],mobilefeed1[3]['enclosure']['link'] ),
          mobile_1(context, mobilefeed2[3]['thumbnail'], mobilefeed2[3]['link'], mobilefeed2[3]['title'],mobilefeed2[3]['author'],mobilefeed2[3]['enclosure']['link'] ),
          mobile_1(context, mobilefeed3[3]['thumbnail'], mobilefeed3[3]['link'], mobilefeed3[3]['title'],mobilefeed3[3]['author'],mobilefeed3[3]['enclosure']['link'] ),
          mobile_1(context, mobilefeed4[3]['thumbnail'], mobilefeed4[3]['link'], mobilefeed4[3]['title'],mobilefeed4[3]['author'] ,mobilefeed4[3]['enclosure']['link']),
          mobile_1(context, mobilefeed1[4]['thumbnail'], mobilefeed1[4]['link'], mobilefeed1[4]['title'],mobilefeed1[4]['author'],mobilefeed1[4]['enclosure']['link'] ),
          mobile_1(context, mobilefeed2[4]['thumbnail'], mobilefeed2[4]['link'], mobilefeed2[4]['title'],mobilefeed2[4]['author'],mobilefeed2[4]['enclosure']['link'] ),
          mobile_1(context, mobilefeed3[4]['thumbnail'], mobilefeed3[4]['link'], mobilefeed3[4]['title'],mobilefeed3[4]['author'],mobilefeed3[4]['enclosure']['link'] ),
          mobile_1(context, mobilefeed4[4]['thumbnail'], mobilefeed4[4]['link'], mobilefeed4[4]['title'],mobilefeed4[4]['author'],mobilefeed4[4]['enclosure']['link'] ),
          mobile_1(context, mobilefeed1[5]['thumbnail'], mobilefeed1[5]['link'], mobilefeed1[5]['title'],mobilefeed1[5]['author'],mobilefeed1[5]['enclosure']['link'] ),
          mobile_1(context, mobilefeed2[5]['thumbnail'], mobilefeed2[5]['link'], mobilefeed2[5]['title'],mobilefeed2[5]['author'],mobilefeed2[5]['enclosure']['link'] ),
          mobile_1(context, mobilefeed3[5]['thumbnail'], mobilefeed3[5]['link'], mobilefeed3[5]['title'],mobilefeed3[5]['author'],mobilefeed3[5]['enclosure']['link'] ),
          mobile_1(context, mobilefeed4[5]['thumbnail'], mobilefeed4[5]['link'], mobilefeed4[5]['title'],mobilefeed4[5]['author'],mobilefeed4[5]['enclosure']['link'] ),
          mobile_1(context, mobilefeed1[6]['thumbnail'], mobilefeed1[6]['link'], mobilefeed1[6]['title'],mobilefeed1[6]['author'] ,mobilefeed1[6]['enclosure']['link']),
          mobile_1(context, mobilefeed2[6]['thumbnail'], mobilefeed2[6]['link'], mobilefeed2[6]['title'],mobilefeed2[6]['author'],mobilefeed2[6]['enclosure']['link'] ),
          mobile_1(context, mobilefeed3[6]['thumbnail'], mobilefeed3[6]['link'], mobilefeed3[6]['title'],mobilefeed3[6]['author'] ,mobilefeed3[6]['enclosure']['link']),
          mobile_1(context, mobilefeed4[6]['thumbnail'], mobilefeed4[6]['link'], mobilefeed4[6]['title'],mobilefeed4[6]['author'] ,mobilefeed4[6]['enclosure']['link']),
          mobile_1(context, mobilefeed1[7]['thumbnail'], mobilefeed1[7]['link'], mobilefeed1[7]['title'],mobilefeed1[7]['author'] ,mobilefeed1[7]['enclosure']['link']),
          mobile_1(context, mobilefeed2[7]['thumbnail'], mobilefeed2[7]['link'], mobilefeed2[7]['title'],mobilefeed2[7]['author'] ,mobilefeed2[7]['enclosure']['link']),
          mobile_1(context, mobilefeed3[7]['thumbnail'], mobilefeed3[7]['link'], mobilefeed3[7]['title'],mobilefeed3[7]['author'],mobilefeed3[7]['enclosure']['link'] ),
          mobile_1(context, mobilefeed4[7]['thumbnail'], mobilefeed4[7]['link'], mobilefeed4[7]['title'],mobilefeed4[7]['author'] ,mobilefeed4[7]['enclosure']['link']),
          mobile_1(context, mobilefeed1[8]['thumbnail'], mobilefeed1[8]['link'], mobilefeed1[8]['title'],mobilefeed1[8]['author'] ,mobilefeed1[8]['enclosure']['link']),
          mobile_1(context, mobilefeed2[8]['thumbnail'], mobilefeed2[8]['link'], mobilefeed2[8]['title'],mobilefeed2[8]['author'] ,mobilefeed2[8]['enclosure']['link']),
          mobile_1(context, mobilefeed3[8]['thumbnail'], mobilefeed3[8]['link'], mobilefeed3[8]['title'],mobilefeed3[8]['author'] ,mobilefeed3[8]['enclosure']['link']),
          mobile_1(context, mobilefeed4[8]['thumbnail'], mobilefeed4[8]['link'], mobilefeed4[8]['title'],mobilefeed4[8]['author'] ,mobilefeed4[8]['enclosure']['link']),
          mobile_1(context, mobilefeed1[9]['thumbnail'], mobilefeed1[9]['link'], mobilefeed1[9]['title'],mobilefeed1[9]['author'] ,mobilefeed1[9]['enclosure']['link']),
          mobile_1(context, mobilefeed2[9]['thumbnail'], mobilefeed2[9]['link'], mobilefeed2[9]['title'],mobilefeed2[9]['author'] ,mobilefeed2[9]['enclosure']['link']),
          mobile_1(context, mobilefeed3[9]['thumbnail'], mobilefeed3[9]['link'], mobilefeed3[9]['title'],mobilefeed3[9]['author'] ,mobilefeed3[9]['enclosure']['link']),
          mobile_1(context, mobilefeed4[9]['thumbnail'], mobilefeed4[9]['link'], mobilefeed4[9]['title'],mobilefeed4[9]['author'] ,mobilefeed4[9]['enclosure']['link']),
          // mobile_1(context, mobilefeed1[10]['thumbnail'], mobilefeed1[10]['link'], mobilefeed1[10]['title'],mobilefeed1[10]['author'] ,mobilefeed1[10]['enclosure']['link']),
          // mobile_1(context, mobilefeed2[10]['thumbnail'], mobilefeed2[10]['link'], mobilefeed2[10]['title'],mobilefeed2[10]['author'] ,mobilefeed2[10]['enclosure']['link']),
          // mobile_1(context, mobilefeed3[10]['thumbnail'], mobilefeed3[10]['link'], mobilefeed3[10]['title'],mobilefeed3[10]['author'] ,mobilefeed3[10]['enclosure']['link']),
          // mobile_1(context, mobilefeed4[10]['thumbnail'], mobilefeed4[10]['link'], mobilefeed4[10]['title'],mobilefeed4[10]['author'] ,mobilefeed4[10]['enclosure']['link']),

        ],
      ),
    );
  }
}

Widget mobile_1(BuildContext context, String image, String url, String title,
    String source,String image2) {
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
                      
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        source==null?'Mobile':source,
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
                      image: image2==null
                          ?NetworkImage("https://i.ibb.co/pQSwnFH/placeholder.png")
                          :NetworkImage(image2))),
            )),
          ],
        )),
    onTap: () {
      //String img="https://via.placeholder.com/150x150.png?text=Lessthan";
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => Urllaunch(url, source)));
    },
  );
}

Widget bigcard(BuildContext context,String image, String url, String text, String source,
    String image2) {
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
                      : NetworkImage(image2),
                  fit: BoxFit.cover)),
        ),
        Container(
            width: MediaQuery.of(context).size.width - 20,
            child: Text(source==null?'Mobile':source, style: TextStyle(color: Colors.black))),
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

Widget chips(String text,BuildContext context){
  return GestureDetector(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Mobileresults('https://price-api.datayuge.com/api/v1/compare/search?api_key=ut02leqpKDimaDRvRqpLcRocRcQ6UnWQ2Vi&product=$text',text)));
    },
    child: Container(
    
    decoration: BoxDecoration(
      color: Colors.grey[300],
      borderRadius:BorderRadius.all(Radius.circular(25))
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,style: TextStyle(fontWeight: FontWeight.w400),),
    ),
  ),
  );
}
