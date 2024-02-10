import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tasty/screens/page4.dart';
import 'page3.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:http/http.dart' as http;

createSMS(String phone) async {
  final response = await http.post(Uri.parse('http://192.168.1.103:3000/twilio'),
    body: jsonEncode(<String, dynamic>{
      'phoneclt':phone,
    }),
  );
  if (response.statusCode == 200) {
    return  null;
  } else {
    throw Exception('Failed to create SMS.');
  }
}

class PageTwo extends StatefulWidget{


  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState  extends State<PageTwo>{

  var myController = TextEditingController();
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.grey[300],
        body : Builder(builder:(BuildContext context) {
         return SingleChildScrollView(
          child:Card (
            margin: EdgeInsets.fromLTRB(30,120,30,120),
            child : Form (
                child : Padding(
                  padding: const EdgeInsets.all(16),
                  child : Column(
                    children: [
                      SizedBox(height:40 ),
                      Image.asset ('assets/images/logopage1.png', width : 200, height :150,),
                      SizedBox(height: 20 ),
                      Text('Please Enter Your Phone Number', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height:10 ),
                      Text('We will Send You a Code', style: TextStyle(color :Colors.orange, fontSize: 16,)),
                      SizedBox(height:40 ),
                      TextField(
                        keyboardType:TextInputType.number ,
                        controller:  myController,
                        decoration: InputDecoration(
                            prefixIcon: CountryCodePicker(
                                padding: EdgeInsets.all(10),
                                initialSelection: '+213',
                                favorite: ['+213', 'DZ'],
                                textStyle: TextStyle(color: Colors.black),
                                showFlag: true),
                            hintText: 'Phone number',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),),
                            contentPadding: EdgeInsets.all(16),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange[400]),
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            )
                        ),
                      ),
                      SizedBox(height:50),
                      Row(
                        children:[
                          SizedBox(width:15),
                        RaisedButton(
                          color:Colors.orange[400],
                          padding:EdgeInsets.symmetric(vertical :15.0,horizontal:50.0) ,
                          child: Text("Done",style: TextStyle(color:Color(0xffC23616)),),
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          ),
                          onPressed: (){
                            if(myController.text.isNotEmpty) {
                              createSMS(myController.text);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => PageThree(passer: myController)));
                            }else {
                             Scaffold.of(context).showSnackBar(SnackBar(content: Text('Please Enter Your phone')));
                            }
                          }
                        ),
                          SizedBox(width:15),
                          RaisedButton(
                            color:Colors.orange[400],
                            padding:EdgeInsets.symmetric(vertical :15.0,horizontal:50.0) ,
                            child: Text("Skip",style: TextStyle(color:Color(0xffC23616)),),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30.0)),
                            ),
                            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (_) =>PageFour()) ),
                          ),
                     ],
                      ),
                      SizedBox(height:70 ,),
                    ],
                  ),

                )
            ),
          ),
        );
    }
        ),
      ),
    );
  }
}

