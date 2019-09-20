import 'package:flutter/material.dart';
import 'package:lessthan/home2.dart';
import 'package:lessthan/urllaunch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Reviewpage extends StatefulWidget {
  @override
  _ReviewpageState createState() => _ReviewpageState();
}

class _ReviewpageState extends State<Reviewpage> {
  String url1 = 'https://api.rss2json.com/v1/api.json?rss_url=https://www.trustedreviews.com/reviews/mobile-phones/feed&api_key=ah09tj2gpc9wggj7joh9aq8komm3tb19ehhsis2j';
  String url2 = 'https://api.rss2json.com/v1/api.json?rss_url=https://www.phonearena.com/feed/reviews&api_key=ah09tj2gpc9wggj7joh9aq8komm3tb19ehhsis2j';
  String url3 = 'https://api.rss2json.com/v1/api.json?rss_url=https://www.trustedreviews.com/reviews/feed&api_key=ah09tj2gpc9wggj7joh9aq8komm3tb19ehhsis2j';
  String url4 = 'https://api.rss2json.com/v1/api.json?rss_url=https://gadgets.ndtv.com/rss/reviews&api_key=ah09tj2gpc9wggj7joh9aq8komm3tb19ehhsis2j';
  
  List mobilefeed1;
  List mobilefeed2;
  List mobilefeed3;
  List mobilefeed4;
  List mobilefeed5;
  String text;
  @override
  void initState() {
    super.initState();
    this.getmobiledata1();
    this.getmobiledata2();
    this.getmobiledata3();
    this.getmobiledata4();
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
  
  void showsearch(context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Search"),
          content: Container(
          height: 100,
         
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: IconButton(icon: Icon(Icons.search),onPressed: (){},color: Colors.black),
                  hintText: 'search',
                 // hintStyle: TextStyle(color: Colors.black),
                  hoverColor: Colors.black,
                  focusColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  ),
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  )
                  ),
                  onSubmitted: (String result){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Homepage2("https://newsapi.org/v2/everything?q=$result&apiKey=26249acef1be492fbe86a5ddde05448d&pagesize=100&language=en",'$result')));

                  },
              ),
            ),
          ),
        );
      }
    );
  
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: Text(
          'Review',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search,color: Colors.white,),
        backgroundColor: Colors.black,
        onPressed: (){
          showsearch(context);
        },
      ),
      body: mobilefeed1==null||mobilefeed2==null||mobilefeed3==null||mobilefeed4==null?SpinKitPulse(color: Colors.black,):ListView(
        children: <Widget>[
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
          //mobile_1(context, mobilefeed4[10]['thumbnail'], mobilefeed4[10]['link'], mobilefeed4[10]['title'],mobilefeed4[10]['author'] ,mobilefeed4[10]['enclosure']['link']),

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
                      image: image == null
                          ?NetworkImage("https://i.ibb.co/pQSwnFH/placeholder.png")
                          :NetworkImage(image))),
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