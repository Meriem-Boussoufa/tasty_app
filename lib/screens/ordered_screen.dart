import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasty/models/cart.dart';
import 'package:tasty/models/details_ord.dart';
import 'details_order_screen.dart';
import '../models/order.dart';
import 'package:http/http.dart' as http;


Future <List<Order>> fetchData() async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/orderjoin.php"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((order) => new Order.fromJson(order)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class OrderedScreen extends StatefulWidget{
  final String phoned ;
  OrderedScreen({this.phoned});
  @override
  _OrderedScreenState createState() => _OrderedScreenState();
}

class _OrderedScreenState  extends State<OrderedScreen> {
  Future <List<Order>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title:Text('Your Orders',style:TextStyle(color:Colors.black)),
          centerTitle: true,
        ),
        body:  SizedBox(
        child:FutureBuilder <List<Order>>(
            future: futureData,
            builder: (context, snapshot){
            if (snapshot.hasData  && snapshot.data.length != 0) {
               List<Order> order = snapshot.data;
                 return  ListView.builder(
                   itemCount:order.length,
                   itemBuilder: (BuildContext context, int index){
                       return GestureDetector(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(
                             builder: (_) =>
                                 DetailsOrderScreen(
                                     namerestdd: order[index].namerest,
                                     totaldd: order[index].total,
                                     idddcmd: order[index].idcmd,
                                     dated: order[index].date,
                                   STOTALD:order[index].STOTAL,
                                 ),
                           ),
                           );
                         },
                         child: Container(
                           margin: EdgeInsets.symmetric(
                             horizontal: 10.0, vertical: 10.0,),
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(15.0),
                             border: Border.all(
                               width: 1.0,
                               color: Colors.grey[200],),
                           ),
                           child: Row(
                             children: [
                               Stack(
                                 alignment: Alignment.bottomLeft,
                                 children: <Widget>[
                                   Container(
                                     margin: EdgeInsets.fromLTRB(5, 15, 15, 15),
                                     child: ClipOval(
                                       //child:Hero(
                                       //tag: ,
                                       child: Image(
                                         image: AssetImage(order[index].logoUrl),
                                         height: 50,
                                         width: 50,
                                         fit: BoxFit.cover,
                                       ),
                                       //),
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(width: 10,),
                               Row(
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment
                                           .start,
                                       children: [
                                         Container(
                                           child: Text(order[index].namerest,
                                               style: TextStyle(
                                                 fontSize: 17.0,
                                                 fontWeight: FontWeight.bold,)),
                                         ),
                                         SizedBox(height: 5),
                                         Container(
                                           child: Text(
                                             'Delivery', style: TextStyle(
                                               fontSize: 17.0,
                                               fontWeight: FontWeight.bold,
                                               color: Colors.orange),),
                                         ),
                                       ],),
                                     SizedBox(width: 100),
                                     Column(
                                       crossAxisAlignment: CrossAxisAlignment
                                           .start,
                                       children: [
                                         Container(

                                           child: Text(order[index].etatcmd,
                                               style: TextStyle(
                                                   fontSize: 17.0)),
                                         ),
                                         SizedBox(height: 5),
                                         Container(

                                           child: Text(order[index].total,
                                             style: TextStyle(fontSize: 17.0,
                                                 fontWeight: FontWeight.bold,
                                                 color: Colors.orange),),
                                         ),
                                         Visibility(
                                           visible: !isvisible,
                                           child: Column(
                                             children: [
                                               Text(order[index].date),
                                               Text(order[index].STOTAL),
                                             ],
                                           ),
                                         ),
                                       ],),
                                   ]
                               )
                             ],
                           ),
                         ),
                       );
                     });
               }else{
              return Column(
                children: [
                  SizedBox(height:200),
                  Icon(
                    Icons.article,
                    color:Colors.orange,
                    size:70,
                  ),
                  SizedBox(height:10),
                  Center(
                    child:Text('Vous n\avez aucune commande',style:TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
                  ),
                ],
              );// By default show a loading spinner.
              return CircularProgressIndicator();
            }
            },
    ),
      ),
      ),
    );
  }
}