import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasty/models/article.dart';
import 'package:tasty/screens/article_screen.dart';
import 'package:tasty/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:tasty/screens/ordered_screen.dart';
import 'package:tasty/screens/page2.dart';
import 'package:tasty/screens/page4.dart';
import 'package:tasty/screens/restaurant_screen.dart';
import 'package:tasty/screens/tracking_order.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;
import '../models/order.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

import 'favoris_screen.dart';

createCommande(String total,String STOTAL,String etat,String idclient,String local,String date,List idart,int idrest,String stotal,String qte) async {
  final response = await http.post(Uri.parse('http://192.168.1.104/tasty/php/createOrd.php'),
    body: jsonEncode(<String, dynamic>{
      'total':total,
      'etat':etat,
      'id' :idclient,
      'idart': idart,
      'stotal' :stotal,
      'qte': qte,
      'idrest':idrest,
      'local' :local,
      'date': date,
      'STOTAL' :STOTAL,
    }),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return  null;
  } else {
    throw Exception('Failed to create commande.');
  }
}

Future <List<Order>> fetchData() async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/order.php"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((order) => new Order.fromJson(order)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class CartScreen extends StatefulWidget{


  final List<Article> cart;
  final String phoned;
  CartScreen( {this.cart,this.phoned});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState  extends State<CartScreen> {
  Position _currentPosition;
  String _currentAddress;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    futureData = fetchData();
  }

  _getCurrentLocation() {
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
  Future <List<Order>> futureData;

  bool isvisible = true;
String valueChoose;
  List listItem =['CASH', 'DAHABIYA', 'BARIDI MOBE',];
  int count =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.grey[300],
          title:Text('Your Cart',style:TextStyle(color:Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child:Consumer<Cart>(builder:(context,cart,child){
            if(cart.basketitem.length>0)
            return Column(
              children:[
               SizedBox(
                height : min(100+50*double.parse(cart.basketitem.length.toString()),400),
                child:ListView.builder(
                  itemCount: cart.basketitem.length,
                  itemBuilder: (context,i){
                 return Container (
                   child:Row(
                  children:[
                    Container (
                      margin: EdgeInsets.fromLTRB(15, 10, 0, 10),
                      child:ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset (cart.basketitem[i].imageUrl,
                          height : 70,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width:20.0),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cart.basketitem[i].name,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            Text(cart.basketitem[i].price.toString(),
                              style :TextStyle( color: Colors.orange[400], fontSize: 15, fontWeight: FontWeight.bold), ),
                            SizedBox(width:3),
                            Text('DA',style :TextStyle( color: Colors.orange[400], fontSize: 15, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width:50.0),
                    Text('× '+cart.totalcount.toString(),style:TextStyle(fontSize: 20,color: Colors.orange)),
                    SizedBox(width:30.0),
                    IconButton(
                        icon: Icon(
                          Icons.restore_from_trash_rounded,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            cart.remove(cart.basketitem[i]);
                          });
                        }
                    ),
                  ],
                ),
                    );
            }
            ),
              ),

            SizedBox(height:20),
            RaisedButton(
              color:Colors.orange[400],
              padding:EdgeInsets.symmetric(vertical :10.0,horizontal:50.0) ,
              child: Text("Add other product",style: TextStyle(color:Colors.white),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RestaurantScreen()));
              }
            ),
            SizedBox(height:20),
            Consumer<Cart>(builder:(context,cart,child) {
              //String prix = cart.totalprice.toString();
              return Card(
                  child: Column(
                      children: [
                      SizedBox(height:10),
                  Text('PURCHASE RECEIPT',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Divider(height: 20.0,),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 15.0),
                      Text('Subtotal'),
                      SizedBox(width: 172.0),
                      Text(cart.subtotal.toString()),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Divider(height: 10.0,),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 15.0),
                      Text('Delivery charges'),
                      SizedBox(width: 120.0),
                      Text('150.00'),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 15.0),
                      Text('Service charge'),
                      SizedBox(width: 120.0),
                      Text('100.00'),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Divider(height: 10.0,),
                  SizedBox(height: 15.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                      SizedBox(width:15.0),
                  Text('Total to pay', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                      fontSize: 20.0)),
                  SizedBox(width: 100.0),
                  Text(cart.totalprice.toString(),style:TextStyle(color:Colors.orange,fontWeight: FontWeight.bold, fontSize: 20.0)),
                    ],
                    ),
                  SizedBox(height:15.0),
              ],
              ),
              );
            }
            ),
            SizedBox(height:10.0),

            Card(
              child:Column(
                children:[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child:Container (
                      padding: EdgeInsets.only(left:16,right:16),
                    decoration: BoxDecoration(
                      border:Border.all(color:Colors.orange,width:1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child:DropdownButton(
                      hint:Text('Payment method'),
                      value: valueChoose,
                      onChanged: (newValue) {
                        setState(() {
                          valueChoose = newValue;
                        });
                      },
                      isExpanded: true,
                      underline: SizedBox(),
                      items: listItem.map((valueItem) {
                        return  DropdownMenuItem(
                          value: valueItem,
                          child: Row(
                            children: <Widget>[
                              //user.icon,
                              SizedBox(width: 10,),
                              Text(valueItem, style:  TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    ),
                  ),
                ],
              ),
            ),
              SizedBox(height:20.0),
               RaisedButton(
                    color: Colors.orange[400],
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                    child: Text("Confirm and Pay", style: TextStyle(color: Colors.white),),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    onPressed: () {
                      if(widget.phoned == null){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (_) => PageTwo()));
                      }else{
                        print(_currentAddress);
                        print(cart.idartdd);
                        DateTime now = new DateTime.now();
                        DateTime date = new DateTime (now.year,now.month,now.day,now.hour,now.minute,now.second,now.millisecond);
                        createCommande(cart.totalprice.toString(),cart.subtotal.toString(),'Prepared',widget.phoned,_currentAddress,date.toString(),
                            cart.idartdd,cart.idresto.toInt(),cart.subtotal.toString(),cart.totalcount.toString()).then((response){
                            Text('Commande mrigla');
                          });
                        cart.basketitem.length = 0;
                        Navigator.push(context, MaterialPageRoute(builder: (_) => Tracking()));
                      };
                      },
                ),
                SizedBox(height:20.0),
            ],
            );
            else
              return Column(
                children: [
                  SizedBox(height:200),
                  Icon(
                    Icons.shopping_cart_outlined,
                    color:Colors.orange,
                    size:70,
                  ),
                  SizedBox(height:10),
                  Center(
                    child:Text('You don\'t have any products in your cart ',style:TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
                  )
                ],
              );
    }
    ),
      ),
      );
  }
}