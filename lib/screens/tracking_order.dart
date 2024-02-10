
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasty/screens/page4.dart';
import '../models/order.dart';
import 'ordered_screen.dart';


class Tracking extends StatefulWidget {
  final String stotal;
  final String qte;
  final String art;
  Tracking({this.stotal,this.qte,this.art});

  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> {
  Future <List<Order>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.orange,
         leading: IconButton(
           icon: Icon(Icons.arrow_back),
           color: Colors.white,
           iconSize: 30.0,
           onPressed: () => Navigator.pop(context),
         ),
       ),
      body:Column (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image(
                height: 170.0,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/maps.png'),
              ),
            ],
          ),
          SizedBox(height:20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          SizedBox(width:40 ),
          Icon(
            Icons.circle,
            color:Colors.orange,
            size:20,
          ),
          SizedBox(width:10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text('13:40',style:TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height:10),
              Text('Order confirmed',style:TextStyle(color:Colors.orange,fontSize: 15)),
            ],
          )
        ],
       ),
          SizedBox(height:300),
          Center(
            child:RaisedButton(
              color: Colors.orange[400],
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Text("Check the order", style: TextStyle(color: Colors.white),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PageFour(page:1) ));
              }
          ),
          ),
        ],
      ),
    ),
    );
  }
}
