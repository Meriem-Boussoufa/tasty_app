import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';
import '../widgets/ratings_stars.dart';
import '../models/favoris.dart';
import '../models/cart.dart';
import 'package:http/http.dart' as http;
import 'restaurant_screen.dart';

Future <List<Favoris>> fetchData() async {
  final response = await http.get(Uri.parse("http://192.168.1.106/tasty/php/favoriscree.php"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((favoris) => new Favoris.fromJson(favoris)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
updateFavoris (bool fav,String id) async {
  final response = await http.put(Uri.parse('http://192.168.1.106/tasty/php/updateFa.php'),
    body: jsonEncode(<String, dynamic>{
      'favori':fav,
      'id':id,
    }),
  );
  if (response.statusCode == 200) {
    print(response.body);
    return  null;
  } else {
    throw Exception('Failed to update favoris');
  }
}


deleteFavoris (String id, String phone) async {
  final response = await http.delete(Uri.parse('http://192.168.1.106/tasty/php/deleteFa.php?id=$id&phone=$phone'));
  if (response.statusCode == 200) {
    print(response.body);
    return  null;
  } else {
    throw Exception('Failed to update favoris');
  }
}
class FavorisScreen extends StatefulWidget{

  @override
  _FavorisScreenState createState() => _FavorisScreenState();
}

class _FavorisScreenState  extends State<FavorisScreen> {
  Future <List<Favoris>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.grey[300],
      title:Text('Your Favourite',style:TextStyle(color:Colors.black)),
      centerTitle: true,
    ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height:10.0),
            Expanded(
              child:SizedBox(
                height:400.0,
                child:FutureBuilder <List<Favoris>>(
                  future: futureData,
                  builder: (context, snapshot){
                    if (snapshot.hasData && snapshot.data.length != 0) {
                      List<Favoris> favoris = snapshot.data;
                      return ListView.builder(
                          itemCount: favoris.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Consumer<Cart>(builder:(context,cart,child){
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0,),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        15.0),
                                    border: Border.all(
                                      width: 1.0,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        alignment: Alignment.bottomLeft,
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius
                                                .circular(15.0),
                                            child: Hero(
                                              tag: favoris[index].imageUrl,
                                              child: Image(
                                                height: 140.0,
                                                width: 400.0,
                                                fit: BoxFit.cover,
                                                image: AssetImage(favoris[index].imageUrl),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: ClipOval(
                                              child:Hero(
                                                tag: favoris[index].logoUrl,
                                                child: Image(
                                                  image: AssetImage(favoris[index].logoUrl),
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 0, 5, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(favoris[index].name,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight
                                                      .bold,),
                                                overflow: TextOverflow
                                                    .ellipsis),
                                            SizedBox(width: 20),

                                            IconButton(
                                                icon: Icon(
                                                  toBoolean(favoris[index].favori) ? Icons.favorite_border : Icons.favorite,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                                onPressed: () {
                                                    setState(() {
                                                      if (!toBoolean(favoris[index].favori)) {
                                                        print("ID");
                                                        print(favoris[index].idfav);
                                                        deleteFavoris(favoris[index].idrest, favoris[index].idclt);
                                                        updateFavoris(true, favoris[index].idrest); 
                                                      }
                                                      bool chat = !(toBoolean(favoris[index].favori));
                                                      favoris[index].favori = chat.toString();
                                                    });
                                                }
                                            ),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.fromLTRB(
                                            15, 5, 15, 15),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  2, 2, 2, 2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .circular(30.0),
                                                color: Colors.grey[200],
                                                border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.grey[200],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time,
                                                    size: 15,
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(favoris[index]
                                                      .dureeliv,
                                                      style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight: FontWeight
                                                            .normal,),
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            RatingStars(int.parse(favoris[index].rating)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                            }
                            );
                          }
                      );
                    }else {
                      return Column(
                        children: [
                          SizedBox(height:200),
                          Icon(
                            Icons.favorite_outlined,
                            color:Colors.orange,
                            size:70,
                          ),
                          SizedBox(height:10),
                          Center(
                            child: Text('You don\'t have any favourite restaurant ',style:TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
                          )
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),


          ],
        ),
    ),
    );
    }
}