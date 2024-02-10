import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:tasty/screens/page1.dart';
import 'page4.dart';
import '../models/client.dart';
import 'package:http/http.dart' as http;


createVerify(String phone,String code) async {
  final response = await http.post(Uri.parse('http://192.168.1.104/tasty/php/verify.php'),
    body: jsonEncode(<String, dynamic>{
      'phoneclt':phone,
      'code' : code,
    }),
  );
  if (response.statusCode == 200) {
    print(response.body);
      return response.body;
  } else {
    throw Exception('Failed to create Verification.');
  }
}
createSMS(String phone) async {
  final response = await http.post(Uri.parse('http://192.168.1.104/tasty/php/twilio.php'),
    body: jsonEncode(<String, dynamic>{
      'phoneclt':phone,
    }),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return  null;
  } else {
    throw Exception('Failed to create SMS.');
  }
}

class PageThree extends StatefulWidget{
  final TextEditingController passer;
  PageThree({this.passer});


  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState  extends State<PageThree>{
  Future<Client> futureClient;
  var MyController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.grey[300],
        body : Builder(builder:(BuildContext context) {
        return SingleChildScrollView(
          child:Card (
            margin: EdgeInsets.fromLTRB(30,100,30,100),
            child : Form (child : Padding(
              padding: const EdgeInsets.all(16),
              child:SingleChildScrollView (
                  child : Column(
                    children: [
                      SizedBox(height:80 ,),
                      Center (child : Text('Enter the Code to Verify Your Phone',textAlign: TextAlign.center, style: TextStyle(color:Colors.orange[400], fontSize: 20, fontWeight: FontWeight.bold,)),),
                      SizedBox(height:15 ,),
                      Center (child :Text('We have sent you on SMS a code In your number',textAlign: TextAlign.center, style: TextStyle(color :Colors.black, fontSize: 16, fontWeight: FontWeight.normal,)),),
                      SizedBox(height:40 ,),
                      TextFormField(
                        cursorColor: Colors.orange[400],
                        keyboardType:TextInputType.number ,
                        controller: MyController1,
                        decoration: InputDecoration(
                            hintText: 'Code',
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
                      SizedBox(height:40 ,),

                      Container(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                //Navigator.of(context).pop();
                                createSMS(widget.passer.text);
                              },
                              child: Text('Send a new code ', style: TextStyle(color:Colors.orange[400], fontSize: 16,)),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height:40 ,),

                      RaisedButton( color:Colors.orange[400],
                        padding:EdgeInsets.symmetric(vertical :15.0,horizontal:70.0) ,
                        child: Text("Done",style: TextStyle(color:Color(0xffC23616)),),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        onPressed: () {
                           if(MyController1.text.isNotEmpty) {
                             createVerify(widget.passer.text, MyController1.text)
                                 .then((response) async {
                               //print(response);
                               if (response == "verification not done") {
                                 Scaffold.of(context).showSnackBar(
                                     SnackBar(
                                         content: Text('Code Incorrecte')));
                               } else {
                                 SharedPreferences prefs = await SharedPreferences.getInstance();
                                 prefs.setString('connected','yes');
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (_) => PageFour(phone:widget.passer.text)));
                               }
                             }).catchError((e) {});
                           }else{
                             Scaffold.of(context).showSnackBar(
                                 SnackBar(
                                     content: Text('Please Enter your Code ')));
                           }
                          },
                      ),
                      SizedBox(height:30 ),
                      SizedBox(height:50 ,),

                    ],)
              ),
            ),
            ),
          ),
        );
  }
  ),
      ),
    );
  }
}