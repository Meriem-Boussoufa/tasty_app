import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../widgets/ratings_stars.dart';

class MoreDetails extends StatefulWidget {
  final String logoUrld ;
  final String named;
  final String dureelivd;
  final String ratingd;
  final String cuisined;
  final String horaired;
  final String addrd;
  final String serviced;
  final String favorid;
  final String idrestd;

  final Restaurant restaurant;

  MoreDetails({ this.restaurant,this.logoUrld, this.named, this.dureelivd, this.ratingd, this.cuisined, this.horaired, this.addrd, this.serviced, this.favorid, this.idrestd});
  @override
  _MoreDetailsState createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 30.0,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:SingleChildScrollView(
        child:Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image(
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/maps.png'),
                ),
                Container(
                  child:ClipOval(
                    child:Image(
                      image:AssetImage(widget.logoUrld),
                      height:70,
                      width:70,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Container(
                  margin:EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: ClipOval(
                    child:Image(
                      image: AssetImage(widget.logoUrld),
                      height:70,
                      width:70,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:[
                      Text(widget.named,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      SizedBox(height:10),
                      Text(widget.cuisined),
                    ],
                  ),
                ),
              ],
            ),
            Container (
              margin: EdgeInsets.fromLTRB(15,0, 0,0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  SizedBox(height:20),
                  Text('Deguster de délicieuse Sandwich, Burger, Tacos'),
                  SizedBox(height:35),
                  Text('Rating:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  SizedBox(height:10),
                  RatingStars(int.parse(widget.ratingd)),
                  SizedBox(height:35),
                  Text('Services:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  SizedBox(height:10),
                  Text(widget.serviced),
                  SizedBox(height:35),
                  Text('Cuisines:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  SizedBox(height:10),
                  Text(widget.cuisined),
                  SizedBox(height:35),
                  Text('Adresse:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  SizedBox(height:10),
                  Text(widget.addrd),
                  SizedBox(height:35),
                  Text('Horaires:',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  SizedBox(height:10),
                 Text(widget.horaired),
                  SizedBox(height:35),
                ],
              ),
            ),
          ],
        ),

      ),
    ),
    );
  }
}