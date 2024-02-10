import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import '../models/details_ord.dart';
import 'package:http/http.dart' as http;


Future <List<DetailsOrd>> fetchData(String idcmd) async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/detailsorder.php?id_cmd="+idcmd));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((details) => new DetailsOrd.fromJson(details)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
class DetailsOrderScreen extends StatefulWidget {
  final String totaldd;
  final String idddcmd;
  final String namerestdd;
  final String dated;
  final String STOTALD;

  DetailsOrderScreen({this.totaldd,this.idddcmd, this.namerestdd, this.dated,this.STOTALD});


  @override
  _DetailsOrderScreenState createState() => _DetailsOrderScreenState();
}

class _DetailsOrderScreenState extends State<DetailsOrderScreen> {
  Future <List<DetailsOrd>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(widget.idddcmd);
    print(widget.idddcmd);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.grey[300],
              title:Text(widget.namerestdd,style:TextStyle(color:Colors.black)),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 30.0,
                onPressed: () => Navigator.pop(context),
              ),
            ),

            body : Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey[200],),
              ),
              child:SingleChildScrollView(

               child :Column (children:[
                 Container(
                   margin: EdgeInsets.fromLTRB(10, 15,15,0),
                   child: Text('Order details', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,)),
                 ),
                  SizedBox(height:5),
                  Text(widget.dated,style:TextStyle(color:Colors.grey[400])),
                   SizedBox(height:5),
                  FutureBuilder <List<DetailsOrd>>(
                   future: futureData,
                    builder: (context, snapshot){
                   if (snapshot.hasData) {
                   List<DetailsOrd> details = snapshot.data;
                   print(details.length);
                  return SizedBox(
                  height:min(75+20*double.parse(details.length.toString()),400),
                    child:ListView.builder(
                     itemCount: details.length ,
                     itemBuilder: (context,i){
                     return Container (
                     child :Column (children: [
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15,),
                        Row(children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0,0,15),
                            child: Text(details[i].qte,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color:Colors.orange)),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(30, 0,0,15),
                            child: Text(details[i].nameart, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(60, 0,0,15),
                            child: Text(details[i].priceart, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color:Colors.orange)),
                          ),
                        ],),
                      ],),
                  ],)
                     );
                      }
                      ),

                  );

                  }else if (snapshot.hasError) {
                     return Text("${snapshot.error}");
                          }// By default show a loading spinner.
                      return CircularProgressIndicator();
                   }
                  ),
                 SizedBox(height:10),
                 Container(
                   margin: EdgeInsets.fromLTRB(10, 0,0,15),
                   child: Text('Payment', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,)),
                 ),
                 Row(children: [
                   Container(
                     margin: EdgeInsets.fromLTRB(10, 0,0,15),
                     child: Text('Your order', style: TextStyle(fontSize: 20.0)),
                   ),
                   SizedBox( width: 80),
                   Container(
                     margin: EdgeInsets.fromLTRB(60, 0,0,15),
                     child: Text(widget.STOTALD, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                   ),
                 ],),
                 Row(children: [
                   Container(
                     margin: EdgeInsets.fromLTRB(10, 0,0,15),
                     child: Text('Delivery fee', style: TextStyle(fontSize: 20.0)),
                   ),
                   SizedBox( width: 65),
                   Container(
                     margin: EdgeInsets.fromLTRB(60, 0,0,15),
                     child: Text('150 DA', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                   ),
                 ],),
                 Row(children: [
                   Container(
                     margin: EdgeInsets.fromLTRB(10, 0,0,15),
                     child: Text('Service Charge', style: TextStyle(fontSize: 20.0)),
                   ),
                   SizedBox( width: 65),
                   Container(
                     margin: EdgeInsets.fromLTRB(20, 0,0,15),
                     child: Text('100 DA', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,)),
                   ),
                 ],),
                 Row(children: [
                   Container(
                     margin: EdgeInsets.fromLTRB(10, 0,0,15),
                     child: Text('Total', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color:Colors.orange)),
                   ),
                   SizedBox( width: 80),
                   Container(
                     margin: EdgeInsets.fromLTRB(125, 0,0,15),
                     child: Text(widget.totaldd, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color:Colors.orange)),
                   ),
                 ],)



            ]),
              ),
    ))
    );
  }
}
