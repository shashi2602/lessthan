import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lessthan/mobile_details.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Mobileresults extends StatefulWidget {
  final String api;
  final String source;
  Mobileresults(this.api,this.source);
  @override
  _MobileresultsState createState() => _MobileresultsState();
}

class _MobileresultsState extends State<Mobileresults> {
  List mobilesearchfeed;
  @override
  void initState() {
    super.initState();
    this.getmobilesearchdata();
  }
  Future<String>getmobilesearchdata()async{
    var mblres=await http.get(Uri.encodeFull(widget.api));
    setState(() {
     var mblcov=json.decode(mblres.body);
     mobilesearchfeed=mblcov['data']; 
    });
    
    return 'success';
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.source,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon:Icon(MdiIcons.google),
            onPressed: ()async{
              if (await canLaunch("https://www.google.com/search?q=${widget.source}")){
                launch("https://www.google.com/search?q=${widget.source}");
              }
              print(".......");
            },
          )
        ],
      ),
      body: mobilesearchfeed == null
            ? Center(
                child: SpinKitPulse(
                color: Colors.black,
              ))
            : RefreshIndicator(
                onRefresh: getmobilesearchdata,
                child: Column(
                  children: <Widget>[
                    Center(child: Text('Note:viewing of details works only on mobiles'),),
                    Expanded(
                      child: ListView.builder(
                        itemCount: mobilesearchfeed.length,
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
                                            mobilesearchfeed[index]['product_title'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),

                                          Row(
                                            children: <Widget>[
                                              Text(
                                               " Rs.${mobilesearchfeed[index]['product_lowest_price']}",
                                                style: TextStyle(
                                                    color: Colors.grey,fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                mobilesearchfeed[index]['product_category'],
                                                style: TextStyle(
                                                    color: Colors.grey),
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
                                      
                                      decoration: BoxDecoration(
                                       
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              //fit: BoxFit.fill,
                                              image: mobilesearchfeed[index]
                                                          ['product_image'] ==
                                                      null
                                                  ? NetworkImage(
                                                      "https://dummyimage.com/600x400/575657/ffffff.png&text=lessthan")
                                                  : NetworkImage(mobilesearchfeed[index]
                                                      ['product_image']))),
                                    )),
                                  ],
                                )),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) => Mobiledetails("${mobilesearchfeed[index]['product_link']}&api_key=HxAinZKSwSTw4TQfkHzTfaMqFqC3bqWXkOx" ,
                                      mobilesearchfeed[index]['product_title'],mobilesearchfeed[index]['product_id'],mobilesearchfeed[index]
                                                          ['product_image'],mobilesearchfeed[index]['product_lowest_price'].toString())));
                                     
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }
}
