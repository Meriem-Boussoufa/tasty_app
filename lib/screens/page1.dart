import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasty/screens/page4.dart';
import 'page2.dart';

class PageOne extends StatefulWidget {

  @override
  _PageOneState createState() => _PageOneState();
}


class _PageOneState extends State<PageOne> {

  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        resizeToAvoidBottomInset: false,
        body:Container(
          alignment: Alignment.center,
          child:Stack(
            alignment: Alignment.center,
            children:<Widget>[
              Container(
                decoration:BoxDecoration(
                  image:DecorationImage(
                    image:AssetImage('assets/images/tastypage1.png'),
                    fit:BoxFit.cover,
                  ),
                ),
                width:500,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:<Widget>[
                    Expanded (
                      child :Container(
                        child: Image.asset ('assets/images/logopage1.png'),
                        width : 500, height :500,
                      ),
                    ),
                    Container(
                      margin:EdgeInsets.fromLTRB(0,0,0,450),
                      child:Text('Get all your favorite food in 1 minute', style:TextStyle(color:Colors.white)),
                    ),
                    Container(
                      margin:EdgeInsets.fromLTRB(0,0,0,70),
                      child:SizedBox(
                        width:300,
                        height:40,
                        child:RaisedButton(
                          color:Colors.white70,
                          child: Text("Get Started",style: TextStyle(color:Color(0xffC23616)),),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (_) =>PageTwo()) );
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}