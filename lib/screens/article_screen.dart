import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/article.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/taille.dart';
import '../models/sauce.dart';
import '../models/viande.dart';
import '../models/frite.dart';
import '../models/gratine.dart';


Future <List<Taille>> fetchData(String page4) async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/taille.php?idcatddd="+page4));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((taille) => new Taille.fromJson(taille)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future <List<Sauce>> fetchDataS(String pageS) async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/sauce.php?idcatddd="+pageS));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((sauce) => new Sauce.fromJson(sauce)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future <List<Viande>> fetchDataV(String pageV) async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/viande.php?idcatddd="+pageV));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((viande) => new Viande.fromJson(viande)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future <List<Frite>> fetchDataF(String pageF) async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/frite.php?idcatddd="+pageF));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((frite) => new Frite.fromJson(frite)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
Future <List<Gratine>> fetchDataG(String pageG) async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/gratine.php?idcatddd="+pageG));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((gratine) => new Gratine.fromJson(gratine)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class ArticleScreen extends StatefulWidget {

  final String imgUrldd;
  final String namedd;
  final String pricedd;
  final String descridd;
  final String idartd;
  //final String idddrest;
  final Article articled;
  final String idcatddd;
  String idrestddd;
  final Article article;
  ArticleScreen( {this.article,this.pricedd,this.descridd, this.imgUrldd,this.namedd,this.articled,this.idartd,this.idcatddd,this.idrestddd});

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {

  Future <List<Taille>> futureData;
  Future <List<Sauce>> futureDataS;
  Future <List<Viande>> futureDataV;
  Future <List<Frite>> futureDataF;
  Future <List<Gratine>> futureDataG;

  @override
  void initState() {
    super.initState();
    futureData = fetchData(widget.idcatddd);
    futureDataS= fetchDataS(widget.idcatddd);
    futureDataV= fetchDataV(widget.idcatddd);
    futureDataF =fetchDataF(widget.idcatddd);
    futureDataG= fetchDataG(widget.idcatddd);
  }

  int selectedRadio=0;
  setSlectedRadio (val){
    setState(() {
      selectedRadio=val;
    });
  }

  int selectedRadioo=0;
  setSlectedRadioo (val1){
    setState(() {
      selectedRadioo=val1;
    });
  }
  int count =1;
  bool _isvisible = true;

  List<bool> itemCheckedState = [];
  double prix = 0.0;
  double _precSlectedViande = 0.0;
  double _precSlectedTaille = 0.0;
  bool _isViandedSlected = false;
  bool _isTailleSlected = false;

  List<bool> itemCheckedState1 = [];
  double prix1 = 0.0;

  List<bool> itemCheckedState2 = [];
  double prix2 = 0.0;

  double prix3 = 0.0;
  double prix4 = 0.0;

  @override
  Widget build(BuildContext context) {
    double finalprice = double.parse(widget.pricedd.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[400],
      ),
      body:SingleChildScrollView (
        child:Column(
            children: <Widget>[
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset (widget.imgUrldd,
                  height : 200,
                  width: 380,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10,),
              Row(
                  children: <Widget>[
                    SizedBox(width: 25,),
                    Text(widget.namedd, style :TextStyle( color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold), ),
                    SizedBox(width: 25,),
                    Row(
                      children:[
                        Text(((finalprice+prix+prix1+prix2+prix3+prix4)*count).toString(), style :TextStyle( color: Colors.orange[400], fontSize: 25, fontWeight: FontWeight.bold), ),
                        SizedBox(width:7),
                        Text('DA',style :TextStyle( color: Colors.orange[400], fontSize: 25, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ]),
              SizedBox(height: 5,),
              Row(children: <Widget>[
                SizedBox(width: 25,),
                SizedBox(
                  width: 200,
                 child:Text(widget.descridd, style :TextStyle( color: Colors.black54, fontSize: 15), ),),
              ]),
              SizedBox(height: 10,),
              Row(children: [
                SizedBox( width: 25,),
                Text('Qte :' ,style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox( width: 10,),
                Container(
                  decoration: BoxDecoration(

                    color: Colors.grey[300],
                  ),
                  child:ElegantNumberButton(initialValue: count,buttonSizeWidth: 50,buttonSizeHeight:15 , color :Colors.white10 ,minValue: 0, maxValue: 10, decimalPlaces: 0,step: 1,
                      onChanged: (value) {
                        setState(() {
                          count=value;
                        });}),
                ),
                SizedBox( width: 40,),
              ],
              ),
              SizedBox(height:15),
              Container(
                padding: EdgeInsets.all(7),
                color:Colors.grey[200],
              child:Row(
                children:[
                  SizedBox(width:10),
                  Text('Sizes to Choose ', style :TextStyle( color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold), ),
                  SizedBox(width: 90,),
                  Container( padding: EdgeInsets.all(4),
                      color:Colors.red, child:Text('Obligation 1', style :TextStyle( color: Colors.white))),
                ],
              ),
              ),
              SizedBox(height: 10,),
              FutureBuilder <List<Taille>>(
                  future: futureData,
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      List<Taille> taille = snapshot.data;
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: taille.length,
                            itemBuilder: (BuildContext context, int index) {
                              return StatefulBuilder( builder :(BuildContext context, StateSetter setState) {
                                return Container (
                                  child: RadioListTile(
                                    value: int.parse(taille[index].id_tai),
                                    groupValue: selectedRadioo, activeColor: Colors.orange[400],
                                    title: Text(taille[index].name_tai, style: TextStyle(fontSize: 15),),
                                    subtitle: Text('+ '+taille[index].price_tai+' DA', style: TextStyle(fontSize: 13)),
                                    onChanged: (val1) {
                                      setState(() {
                                        setSlectedRadioo(val1);
                                        selectedRadioo = val1;
                                        _isTailleSlected = true;
                                        prix4 = prix4 + double.parse(taille[index].price_tai) - _precSlectedTaille ;
                                        _precSlectedTaille = double.parse(taille[index].price_tai);
                                    });
                                    },
                                    selected: selectedRadioo == int.parse(taille[index].id_tai,),
                                  ),
                                );
                              }
                              );
                            }
                        ),
                      );
                    }else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(7),
                color:Colors.grey[200],
                child: Row(children: <Widget>[
                  SizedBox(width: 10,),
                  Text('Meet to Choose ', style :TextStyle( color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold), ),
                  SizedBox(width: 100,),
                  Container( padding: EdgeInsets.all(4),
                      color:Colors.red, child:Text('Obligation 1', style :TextStyle( color: Colors.white))),
                ]),
              ),
              SizedBox(height: 10,),

              FutureBuilder <List<Viande>>(
                  future: futureDataV,
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      List<Viande> viande = snapshot.data;
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: viande.length,
                            itemBuilder: (BuildContext context, int index) {
                              return RadioListTile(
                                value:  int.parse(viande[index].id_via)+1,
                                groupValue: selectedRadio, activeColor: Colors.orange[400],
                                title: Text(viande[index].name_via, style: TextStyle(fontSize: 15),),
                                subtitle: Text('+ '+viande[index].price_via+' DA', style: TextStyle(fontSize: 13)),
                                onChanged: (val) {
                                  setState(() {
                                    setSlectedRadio(val);
                                    selectedRadio = val;
                                    _isViandedSlected = true;
                                    prix3 = prix3 + double.parse(viande[index].price_via) - _precSlectedViande ;
                                    _precSlectedViande = double.parse(viande[index].price_via);

                                  });},
                                selected: selectedRadio == int.parse(viande[index].id_via)+1,
                              );
                            }
                        ),
                      );
                    }else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(7),
                color: Colors.grey[200],
                child: Row(children: <Widget>[
                  SizedBox(width: 10,),
                  Text('Extra Sauce  ', style :TextStyle( color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600), ),
                ]),
              ),
              SizedBox(height: 10,),
              FutureBuilder <List<Sauce>>(
                  future: futureDataS,
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      List<Sauce> sauce = snapshot.data;
                      for(int i = 0; i < sauce.length; i++){
                        itemCheckedState.add(false);
                      }
                      return SizedBox(
                        height: 350,
                        child: ListView.builder(
                            itemCount: sauce.length,
                            itemBuilder: (context, index){
                              return CheckboxListTile(
                                title: Text(sauce[index].name_sau, style:TextStyle(fontSize: 15)),
                                subtitle: Text ('+ '+sauce[index].price_sau +' DA',style: TextStyle(fontSize: 13)), activeColor: Colors.orange[400],checkColor: Colors.white,
                                controlAffinity: ListTileControlAffinity.leading,
                                value: itemCheckedState[index],
                                onChanged: (newValue){
                                  setState((){
                                    itemCheckedState[index] = newValue;
                                    if (newValue){
                                      prix = prix + double.parse(sauce[index].price_sau) ;
                                    }else{
                                      prix = prix - double.parse(sauce[index].price_sau);
                                    }
                                  });
                                },selected:itemCheckedState[index],
                              );
                            }
                        ),
                      );
                    }else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(7),
                color: Colors.grey[200],
                child: Row(children: <Widget>[
                  SizedBox(width: 10,),
                  Text(' Extra Fries ', style :TextStyle( color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600), ),
                ]),
              ),
              SizedBox(height: 10,),
              FutureBuilder <List<Frite>>(
                  future: futureDataF,
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      List<Frite> frite = snapshot.data;
                      for(int i = 0; i < frite.length; i++){
                        itemCheckedState1.add(false);
                      }
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: frite.length,
                            itemBuilder: (context, index){
                              return CheckboxListTile(
                                title: Text(frite[index].name_fri, style:TextStyle(fontSize: 15)),
                                subtitle: Text ('+ '+frite[index].price_fri +' DA',style: TextStyle(fontSize: 13)),
                                controlAffinity: ListTileControlAffinity.leading,
                                activeColor: Colors.orange[400],checkColor: Colors.white,
                                value: itemCheckedState1[index],
                                onChanged: (newValue){
                                  setState((){
                                    itemCheckedState1[index] = newValue;
                                    if (newValue){
                                      prix1 = prix1 + double.parse(frite[index].price_fri) ;
                                    }else{
                                      prix1 = prix1 - double.parse(frite[index].price_fri);
                                    }
                                  }
                                  );
                                },selected:itemCheckedState[index],
                              );
                            }
                        ),
                      );
                    }else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.all(7),
                color: Colors.grey[200],
                child: Row(children: <Widget>[
                  SizedBox(width: 10,),
                  Text('Gratine to Choose ', style :TextStyle( color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600), ),
                ]),
              ),

              SizedBox(height: 10,),
              FutureBuilder <List<Gratine>>(
                  future: futureDataG,
                  builder: (context, snapshot){
                    if (snapshot.hasData) {
                      List<Gratine> gratine = snapshot.data;
                      for(int i = 0; i < gratine.length; i++){
                        itemCheckedState2.add(false);
                      }
                      return SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: gratine.length,
                            itemBuilder: (context, index){
                              return CheckboxListTile(
                                title: Text(gratine[index].name_gra, style:TextStyle(fontSize: 15)),
                                subtitle: Text ('+ '+gratine[index].price_gra +' DA',style: TextStyle(fontSize: 13)),
                                controlAffinity: ListTileControlAffinity.leading,
                                activeColor: Colors.orange[400],checkColor: Colors.white,
                                value: itemCheckedState2[index],
                                onChanged: (newValue){
                                  setState((){
                                    itemCheckedState2[index] = newValue;
                                    if (newValue){
                                      prix2 = prix2 + double.parse(gratine[index].price_gra) ;
                                    }else{
                                      prix2 = prix2 - double.parse(gratine[index].price_gra);
                                    }
                                  });
                                },selected:itemCheckedState[index]
                              );
                            }
                        ),
                      );
                    }else if (snapshot.hasError){
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  }
              ),
              SizedBox( height: 20,),



              SizedBox( height: 30,),
              Visibility(
                visible: !_isvisible,
                child: Column(
                  children: [
                    Text(widget.idrestddd)
                  ],
                ),
              ),
          Consumer<Cart>(builder:(context,cart,child) {
            return Builder(builder:(BuildContext context) {
              return MaterialButton(
              onPressed: () {
                if(_isTailleSlected){
                if (_isViandedSlected){
                  print(widget.idrestddd);
                  cart.add(widget.articled,count,int.parse(widget.idartd),int.parse(widget.idrestddd),prix,prix1,prix2,prix3,prix4);
                  Navigator.of(context).pop();
                }else {
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Please Enter le type de la viande')));
                }
                }else{
                  Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Please Enter la taille')));
               }
              },
              color: Colors.orange[400],
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
               child: Text('Add to cart', style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
            );

            }
          );
          }
          ),
              SizedBox( height: 30,),

            ]

        ),
      ),
    );
  }
}

