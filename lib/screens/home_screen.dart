import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
import 'package:tasty/models/cart.dart';
import 'package:tasty/models/restaurant.dart';
import 'package:tasty/screens/page2.dart';
import 'package:tasty/screens/restaurant_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/ratings_stars.dart';

List <dynamic> listsearch =[];
Future <List<Restaurant>> fetchData() async {
  var response = await http.get(Uri.parse("http://192.168.1.103:3000/restos"));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    for (int i =0;i< jsonResponse.length;i++){
      listsearch.add(jsonResponse[i]['name_rest']);
    }
    return jsonResponse.map((restaurant) => new Restaurant.fromJson(restaurant)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }

}

updateFavoris (bool fav,String id) async {
  final response = await http.put(Uri.parse('http://192.168.1.105/tasty/php/updateFa.php'),
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

insertFavoris (String idresto,String phone,String favori) async {
  final response = await http.post(Uri.parse('http://192.168.1.106/tasty/php/favoris.php'),
    body: jsonEncode(<String, dynamic>{
      'idresto' :idresto,
      'phone': phone,
      'favori' :favori,
    }),
  );
  if (response.statusCode == 200) {
    return  null;
  } else {
    throw Exception('Failed to insert favoris');
  }
}
deleteFavoris (String id, String phone) async {
  final response = await http.delete(Uri.parse('http://192.168.1.105/tasty/php/deleteFa.php?id=$id&phone=$phone'));
  if (response.statusCode == 200) {
    print(response.body);
    return  null;
  } else {
    throw Exception('Failed to update favoris');
  }
}
class HomeScreen extends StatefulWidget{
  final String phoned;
  HomeScreen({this.phoned});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
@override
class _HomeScreenState  extends State<HomeScreen> {

 final Restaurant restaurant = Restaurant();

  Future <List<Restaurant>> futureData;

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
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          child:AppBar(
            backgroundColor: Colors.orange[400],
            title: TextField(
              cursorColor: Colors.white,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.black,
                  onPressed: (){
                    showSearch(context: context, delegate: DataSearch(list: listsearch));
                  },
                ),
              ),
              onTap: (){
                showSearch(context: context, delegate: DataSearch(list: listsearch));
              },
            ),
            shape:RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
            ),
          ),
          preferredSize:Size.fromHeight(80),
        ),
        body:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height:20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text('Nearby Restaurants', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600, letterSpacing: 1.2,),),
                ),
                SizedBox(height:10.0),
                Expanded(
                  child:SizedBox(
                    height:400.0,
                    child:FutureBuilder <List<Restaurant>>(
                    future: futureData,
                    builder: (context, snapshot){
                      print(snapshot.hasData);
                      print(snapshot.data);
                      if (snapshot.hasData) {
                        List<Restaurant> restaurants = snapshot.data;
                        return ListView.builder(
                              itemCount: restaurants.length,
                              itemBuilder: (BuildContext context, int index) {
                                 return Consumer<Cart>(builder:(context,cart,child){
                                   return GestureDetector(
                                    onTap: () {
                                      print(widget.phoned);
                                      cart.basketitem.length = 0;
                                      cart.idartdd.clear();
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                                  return RestaurantScreen(
                                                    named: restaurants[index].name,
                                                    dureelivd: restaurants[index].dureeliv,
                                                    ratingd: restaurants[index].rating.toString(),
                                                    cuisined: restaurants[index].cuisine,
                                                    horaired: restaurants[index].horaire,
                                                    addrd: restaurants[index].addr,
                                                    serviced: restaurants[index].service,
                                                    favorid: restaurants[index].favori.toString(),
                                                    idrestd:restaurants[index].idrest.toString(),
                                                    logoUrld:restaurants[index].logoUrl,
                                                  );
                                                }));
                                             },
                                    child: Container(
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
                                                tag: restaurants[index].imageUrl,
                                                child: Image(
                                                  height: 140.0,
                                                  width: 400.0,
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(restaurants[index].imageUrl),
                                                ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                                child: ClipOval(
                                                 child:Hero(
                                                  tag: restaurants[index].logoUrl,
                                                  child: Image(
                                                    image: AssetImage(restaurants[index].logoUrl),
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
                                                Text(restaurants[index].name,
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight
                                                          .bold,),
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                SizedBox(width: 20),

                                                IconButton(
                                                    icon: Icon(
                                                      toBoolean(restaurants[index].favori.toString()) ? Icons.favorite_border : Icons.favorite,
                                                      color: Colors.red,
                                                      size: 30,
                                                    ),
                                                    onPressed: () {
                                                      if(widget.phoned == null)
                                                        Navigator.push(context, MaterialPageRoute(builder: (_) => PageTwo()));
                                                      else
                                                      setState(() {
                                                        if (toBoolean(restaurants[index].favori.toString())) {
                                                          insertFavoris(restaurants[index].idrest.toString(), widget.phoned, 'FALSE');
                                                          updateFavoris(false,restaurants[index].idrest.toString());

                                                        }else{
                                                          updateFavoris(true,restaurants[index].idrest.toString());
                                                          deleteFavoris(restaurants[index].idrest.toString(),widget.phoned);
                                                        }
                                                        bool chat = !(toBoolean(restaurants[index].favori.toString()));
                                                        restaurants[index].favori = chat as int;
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
                                                      Text(restaurants[index]
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
                                                RatingStars(restaurants[index].rating),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                );
                              }
                          );
                      }else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default show a loading spinner.
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














class DataSearch extends SearchDelegate<String> {
  Future <List<Restaurant>> futureData;
  List<dynamic> list;

  DataSearch({this.list});

  Future <List<Restaurant>> getsreachData() async {
    var data ={"search":query};
    var response = await http.post(Uri.parse("http://192.168.1.104/tasty/php/search.php"),body :data);
    if(response.statusCode== 200){
      List jsonResponse = jsonDecode(response.body);
      return
        jsonResponse.map((restaurant) => new Restaurant.fromJson(restaurant)).toList();
    }else{
      throw Exception ('Unexpected error occured !');
    }
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = " ";
      }, icon: Icon(Icons.clear),)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return
      IconButton(onPressed: () {
        close(context, null);
      }, icon: Icon(Icons.arrow_back),);
  }

  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var sreachlist = query.isEmpty ? list :list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemCount:sreachlist.length ,itemBuilder: (context,i){
      return ListTile(leading: Icon(Icons.restaurant_menu,color: Colors.orange,),
        title: Text(sreachlist[i]),
        onTap: (){
          query=sreachlist[i];
          showResults(context);
        },);
    }
    );
  }


  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder (
      future:getsreachData() ,
      builder: (context, snapshot){
        if (snapshot.hasData && snapshot.data.length != 0) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () =>
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) {
                                  return RestaurantScreen(
                                    named: snapshot.data[index].name,
                                    dureelivd: snapshot.data[index].dureeliv,
                                    ratingd: snapshot.data[index].rating,
                                    cuisined: snapshot.data[index].cuisine,
                                    horaired: snapshot.data[index].horaire,
                                    addrd: snapshot.data[index].addr,
                                    serviced: snapshot.data[index].service,
                                    favorid: snapshot.data[index].favori,
                                    idrestd: snapshot.data[index].idrest,);
                                })),

                    child: Container(
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
                                tag: snapshot.data[index].imgUrl,
                                child: Image(
                                  height: 140.0,
                                  width: 400.0,
                                  fit: BoxFit.cover,
                                  image: AssetImage(snapshot.data[index].imgUrl),
                                ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    10, 0, 0, 0),
                                child: ClipOval(
                                  child:Hero(
                                  tag: snapshot.data[index].logoUrl,
                                  child: Image(
                                    image: AssetImage(snapshot.data[index].logoUrl),
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
                                Text(snapshot.data[index].name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight
                                          .bold,),
                                    overflow: TextOverflow
                                        .ellipsis),
                                SizedBox(width: 20),
                                IconButton(
                                    icon: Icon(
                                      toBoolean(snapshot.data[index].favori) ? Icons.favorite_border : Icons.favorite,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onPressed: () {
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
                                      Text(snapshot.data[index]
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
                                RatingStars(int.parse(
                                    snapshot.data[index].rating)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
              });
        }return Center(
          child: Column(
            children: [
              SizedBox(height:200),
              Icon(
                Icons.search,
                color:Colors.orange,
                size:80,
              ),
              SizedBox(height:10),
              Text('NO RESTAURANT FOUND ',style:TextStyle(fontSize: 20.0),textAlign: TextAlign.center,),
            ],
          ),
        );
      },
    );
  }



}
