import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasty/screens/page1.dart';
import 'package:tasty/screens/page2.dart';
import 'editer_profile.dart';


class ProfileScreen extends StatefulWidget{
final String phoned;
ProfileScreen({this.phoned});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState  extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        body: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:40),
              Center(
                child:Text('My Account',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),
                Container(
                  margin: EdgeInsets.fromLTRB(15, 25, 0, 25),
                  child: SizedBox(
                    width: 360,
                    height: 30,
                    child: RaisedButton(
                        color: Colors.grey[200],
                        child: Text("Update my profil                                  >>>", textAlign: TextAlign.start, style: TextStyle(color: Colors.black)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        onPressed: () {
                          if(widget.phoned == null) {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                _) => PageTwo()));
                          }else{
                            Navigator.push(context, MaterialPageRoute(builder: (
                                _) => EditerProfile(passerr: widget.phoned)));
                          }
                        }
                    ),
                  ),
                ),
              Container(
                margin:EdgeInsets.fromLTRB(25, 10, 0, 20),
                child:Text('Credit and reward',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(15, 10, 0,10),
                child:Row (
                  children: [
                    Icon(
                      Icons.credit_card,
                      color:Colors.orange,
                      size:30,
                    ),
                    SizedBox(width: 10,),
                    Text('My credit', style:TextStyle(fontSize: 15),),
                    SizedBox(width: 10,),
                    Text('0 DA',style: TextStyle(color: Colors.orange),),
                  ],
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(15, 10, 0,10),
                child:Row (
                  children: [
                    Icon(
                      Icons.card_giftcard,
                      color:Colors.orange,
                      size:30,
                    ),
                    SizedBox(width: 10,),
                    Text('Discounts', style:TextStyle(fontSize: 15),),
                    SizedBox(width: 10,),
                    Text('90 Pts',style: TextStyle(color: Colors.orange),),
                  ],
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(25, 10, 0, 20),
                child:Text('Settings',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(15, 10, 0,10),
                child:Row (
                  children: [
                    Icon(
                      Icons.gps_fixed,
                      color:Colors.orange,
                      size:30,
                    ),
                    SizedBox(width: 10,),
                    Text('My adresses', style:TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(15, 10, 0,10),
                child:Row (
                  children: [
                    Icon(
                      Icons.format_paint_outlined,
                      color:Colors.orange,
                      size:30,
                    ),
                    SizedBox(width: 10,),
                    Text('Other settings', style:TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(25, 20, 0, 20),
                child:Text('More informations',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25)),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(15, 10, 0,10),
                child:Row (
                  children: [
                    Icon(
                      Icons.face_retouching_natural,
                      color:Colors.orange,
                      size:30,
                    ),
                    SizedBox(width: 10,),
                    Text('Customer service', style:TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(15, 10, 0,10),
                child:Row (
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      color:Colors.orange,
                      size:30,
                    ),
                    SizedBox(width: 10,),
                    Text('About', style:TextStyle(fontSize: 15),),
                  ],
                ),
              ),
              Container(
                margin:EdgeInsets.fromLTRB(15, 10, 0,10),
                child:Row (
                  children: [
                    Icon(
                      Icons.share,
                      color:Colors.orange,
                      size:30,
                    ),
                    SizedBox(width: 10,),
                    Text('Share the app'),
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (_) => PageOne()));
                },
              child:Container(
                margin:EdgeInsets.fromLTRB(15, 10, 0,10),
                child:Row (
                  children: [
                    Icon(
                      Icons.logout,
                      color:Colors.orange,
                      size:30,
                    ),
                    SizedBox(width: 10,),
                    Text('Log Out',style:TextStyle(color:Colors.orange,fontSize:20,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              ),
              SizedBox(height:20),
            ],
          ),
        ),
      ),
    );
  }
}