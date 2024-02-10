import 'dart:convert';

import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'package:http/http.dart' as http;

updateClient(String name ,String lastname,String email,String adr,String id) async {
  final response = await http.put(Uri.parse('http://192.168.1.106/tasty/php/updateClient.php'),
    body: jsonEncode(<String, dynamic>{
      'name' :name,
      'lastname' : lastname,
      'email' : email,
      'adr' : adr,
      'id' : id,
    }),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return  null;
  } else {
    throw Exception('Failed to update Client');
  }
}
class EditerProfile extends StatefulWidget{
final String passerr;
EditerProfile({this.passerr});

  @override
  _EditerProfileState createState() => _EditerProfileState();
}

class _EditerProfileState  extends State<EditerProfile> {
  var myController1 = TextEditingController();
  var myController2 = TextEditingController();
  var myController3 = TextEditingController();
  var myController4 = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title:Text('My Profil'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            iconSize: 30.0,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body:SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height:20),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child:Text('First Name :',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height:10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child:TextField(
                  keyboardType:TextInputType.text ,
                  controller: myController1,
                  decoration: InputDecoration(
                      hintText: 'Add your first name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),),
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[400]),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      )
                  ),
                ),
              ),
              SizedBox(height:20),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child:Text('Last Name:',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height:10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child:TextField(
                  keyboardType:TextInputType.text,
                  controller: myController2,
                  decoration: InputDecoration(
                      hintText: 'Add your last name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),),
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[400]),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      )
                  ),
                ),
              ),
              SizedBox(height:20),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child:Text('Address :',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height:10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child:TextField(
                  keyboardType:TextInputType.text,
                  controller: myController3,
                  decoration: InputDecoration(
                      hintText: 'Add your address',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),),
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[400]),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      )
                  ),
                ),
              ),
              SizedBox(height:20),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child:Text('Email :',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height:10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child:TextField(
                  keyboardType:TextInputType.emailAddress,
                  controller: myController4,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Add your email',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[400]),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      )
                  ),
                ),
              ),
              SizedBox(height:20),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                child:Text('Phone :',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height:10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child:TextFormField(
                  readOnly: true,
                  initialValue: widget.passerr,
                  keyboardType:TextInputType.phone ,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange[400]),
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      )
                  ),
                ),
              ),
              SizedBox(height:50),
              Center(
              child:Container(
                margin: EdgeInsets.fromLTRB(60, 0, 60, 0),
                child:RaisedButton(
                  color:Colors.orange[400],
                  padding:EdgeInsets.symmetric(vertical :15.0,horizontal:70.0) ,
                  child: Text("Update",style: TextStyle(color:Color(0xffC23616)),),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  onPressed: () {
                    updateClient(myController1.text, myController2.text, myController3.text, myController4.text,widget.passerr);
                    Navigator.push(context,MaterialPageRoute(builder: (_) =>ProfileScreen()) );
                  }
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}