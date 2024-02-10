import 'dart:convert';
import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'moredetails_screen.dart';
import 'package:http/http.dart' as http;
import 'article_screen.dart';
import '../models/article.dart';
import '../models/restaurant.dart';
import '../models/categorie.dart';
import '../models/cart.dart';
import 'package:provider/provider.dart';

Future <List<Categorie>> fetchData(String salah) async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/page2.php?id_rest="+salah));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((categorie) => new Categorie.fromJson(categorie)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

Future <List<Article>> fetchDataArt(String meriem) async {
  final response = await http.get(Uri.parse("http://192.168.1.104/tasty/php/page3.php?id_cat="+meriem));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((article) => new Article.fromJson(article)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class CategorieView extends StatefulWidget{
  final String named;
  final String id_cat;
  final String id_rest;
  final String iddrest;
  String idrestdd;
  final CategorieView categorie;
  CategorieView({this.categorie, this.named, this.id_cat, this.id_rest,this.iddrest,this.idrestdd});
  @override
  _CategorieState createState() => _CategorieState();
}
class _CategorieState extends State<CategorieView> {
  final CategorieView categorie = CategorieView() ;
  Future <List<Article>> futureDataArt;
  @override
  void initState() {
    super.initState();
    futureDataArt = fetchDataArt(widget.id_cat);
  }
  @override
  Widget build (BuildContext context) {
    return SingleChildScrollView(
      child:Container(
      padding: EdgeInsets.all(10.0),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(widget.named, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis),
           SizedBox(height:15),
              FutureBuilder <List<Article>>(
              future: futureDataArt,
              builder: (context, snapshot){
                if (snapshot.hasData) {
                  List<Article> article = snapshot.data;
                    return SizedBox(
                     height:min(100+50*double.parse(article.length.toString()),400),
                     child: ListView.builder(
                        itemCount: article.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Consumer <Cart>(builder:(context,cart,child)
                          {
                            return GestureDetector(
                              onTap: () {
                                print(widget.idrestdd);
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) {
                                    return ArticleScreen(
                                      articled: article[index],
                                      idartd: article[index].idart,
                                      namedd: article[index].name,
                                      imgUrldd: article[index].imageUrl,
                                      descridd: article[index].descri,
                                      pricedd: article[index].price,
                                      idcatddd: widget.id_cat,
                                      idrestddd: widget.idrestdd,
                                    );
                                  }),);
                              },
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey[200],
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10.0),
                                            child: Image(
                                              height: 70.0,
                                              width: 70,
                                              fit: BoxFit.cover,
                                              image: AssetImage(article[index].imageUrl),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 25),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(article[index].name,
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0)),
                                              SizedBox(height: 5),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(article[index].price.toString(), style: TextStyle(color: Colors.orange)),
                                                    SizedBox(width: 5),
                                                    Text('DA', style: TextStyle(color: Colors.orange)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          );
                        }
                  ),
                );
                }else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }// By default show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
        ],
      ),
    ),
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class RestaurantScreen extends StatefulWidget {

  final String logoUrld;
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
  RestaurantScreen( {this.restaurant,this.logoUrld, this.named, this.dureelivd, this.ratingd, this.cuisined, this.horaired, this.addrd, this.serviced, this.idrestd, this.favorid});
  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> with TickerProviderStateMixin{
  bool _isvisible = true;
  final HumbKey = new GlobalKey();
  final SanKey = new GlobalKey();
  final PizKey = new GlobalKey();
  final TacKey = new GlobalKey();
  final PlaKey = new GlobalKey();
  final DriKey = new GlobalKey();
  final sliverListtKey = new GlobalKey();
  RenderBox overRender;
  RenderBox revRender;
  RenderBox menuRender;
  RenderBox contactRender;
  RenderBox sliverRender;
  ScrollController scrollController;
  TabController _tabController;
  TabController _topTabController;
  double HumbHeight;
  double SanHeight;
  double PizHeight;
  double TacHeight;
  double PlaHeight;
  double DriHeight;

  @override
  void initState() {
    super.initState();
    super.initState();
    futureData = fetchData(widget.idrestd);
    scrollController = ScrollController();
    _tabController = new TabController(length: 6, vsync: this);
    _topTabController =
    new TabController(length: 6, vsync: this);
    addScrollControllerListener();
  }

  void addScrollControllerListener(){
    scrollController.addListener(() {
      if (HumbKey.currentContext != null) {
        HumbHeight = HumbKey.currentContext.size.height;
      }
      if (SanKey.currentContext != null) {
        SanHeight = SanKey.currentContext.size.height;
      }
      if (PizKey.currentContext != null) {
        PizHeight = PizKey.currentContext.size.height;
      }
      if (TacKey.currentContext != null) {
        TacHeight = TacKey.currentContext.size.height;
      }
      if (PlaKey.currentContext != null) {
        PlaHeight = PlaKey.currentContext.size.height;
      }
      if (DriKey.currentContext != null) {
        DriHeight = DriKey.currentContext.size.height;
      }
      if (scrollController.offset > HumbHeight + 200 &&
          scrollController.offset < SanHeight + HumbHeight + 200) {
      } else {
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (scrollController.offset > 0 &&
            scrollController.offset < HumbHeight + 200) {
          _tabController.animateTo(0);
        } else if (scrollController.offset > HumbHeight + 200 &&
            scrollController.offset < SanHeight + HumbHeight + 200) {
          _tabController.animateTo(1);
        } else if (scrollController.offset > SanHeight + HumbHeight + 200 &&
            scrollController.offset <
                SanHeight + HumbHeight + TacHeight + 200) {
          _tabController.animateTo(2);
        } else if (scrollController.offset >
            SanHeight + HumbHeight + TacHeight + 200 &&
            scrollController.offset <=
                SanHeight + HumbHeight + TacHeight + PizHeight + 200) {
          _tabController.animateTo(3);
        } else {}
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (scrollController.offset < HumbHeight) {
          _tabController.animateTo(0);
        } else if (scrollController.offset > HumbHeight &&
            scrollController.offset < SanHeight + HumbHeight) {
          _tabController.animateTo(1);
        } else if (scrollController.offset > SanHeight + HumbHeight &&
            scrollController.offset < SanHeight + HumbHeight + TacHeight) {
          _tabController.animateTo(2);
        } else if (scrollController.offset >
            SanHeight + HumbHeight + TacHeight &&
            scrollController.offset <
                SanHeight + HumbHeight + TacHeight + PizHeight) {
          _tabController.animateTo(3);
        } else {}
      }
    });
  }

  void tabBarOnTap(val) {
    switch (val) {
      case 0:
        {
          if (HumbKey.currentContext == null) {
            scrollController.position
                .ensureVisible(
              TacKey.currentContext.findRenderObject(),
              alignment:
              0.0, // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 200),
            )
                .then((value) {
              scrollController.position
                  .ensureVisible(
                TacKey.currentContext.findRenderObject(),
                alignment:
                0.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  SanKey.currentContext.findRenderObject(),
                  alignment:
                  0.0, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    HumbKey.currentContext.findRenderObject(),
                    alignment:
                    0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            });
          } else {
            scrollController.position.ensureVisible(
              HumbKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 800),
            );
          }
        }
        break;
      case 1:
        {
          if (SanKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                HumbKey.currentContext.findRenderObject(),
                alignment: 0.0,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  HumbKey.currentContext.findRenderObject(),
                  alignment: 0.5,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    SanKey.currentContext.findRenderObject(),
                    alignment: 0.0,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            } else {
              scrollController.position
                  .ensureVisible(
                TacKey.currentContext.findRenderObject(),
                alignment: 0.5,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  TacKey.currentContext.findRenderObject(),
                  alignment: 0.0,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    SanKey.currentContext.findRenderObject(),
                    alignment: 0.5,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position.ensureVisible(
                      SanKey.currentContext.findRenderObject(),
                      alignment: 0.0,
                      // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    );
                  });
                });
              });
            }
          } else {
            scrollController.position.ensureVisible(
              SanKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 400),
            );
          }
        }
        break;
      case 2:
        {
          if (TacKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                HumbKey.currentContext.findRenderObject(),
                alignment: 0.0,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  HumbKey.currentContext.findRenderObject(),
                  alignment: 0.5,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    SanKey.currentContext.findRenderObject(),
                    alignment: 0.0,
                    // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position
                        .ensureVisible(
                      SanKey.currentContext.findRenderObject(),
                      alignment: 0.5,
                      // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    )
                        .then((value) {
                      scrollController.position.ensureVisible(
                        TacKey.currentContext.findRenderObject(),
                        alignment: 0.2,
                        // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 200),
                      );
                    });
                  });
                });
              });
            } else if (_tabController.previousIndex == 1) {
              scrollController.position
                  .ensureVisible(
                SanKey.currentContext.findRenderObject(),
                alignment: 0.5,
                // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position.ensureVisible(
                  TacKey.currentContext.findRenderObject(),
                  alignment: 0.2,
                  // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                );
              });
            }
          } else {
            scrollController.position.ensureVisible(
              TacKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 600),
            );
          }
        }
        break;
      case 3:
        {
          if (PizKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                HumbKey.currentContext.findRenderObject(),
                alignment:
                0.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  HumbKey.currentContext.findRenderObject(),
                  alignment:
                  0.5, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    SanKey.currentContext.findRenderObject(),
                    alignment:
                    0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position
                        .ensureVisible(
                      SanKey.currentContext.findRenderObject(),
                      alignment:
                      0.5, // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    )
                        .then((value) {
                      scrollController.position
                          .ensureVisible(
                        TacKey.currentContext.findRenderObject(),
                        alignment:
                        0.0, // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 200),
                      )
                          .then((value) {
                        scrollController.position
                            .ensureVisible(
                          TacKey.currentContext
                              .findRenderObject(),
                          alignment:
                          0.5, // How far into view the item should be scrolled (between 0 and 1).
                          duration: const Duration(milliseconds: 200),
                        )
                            .then((value) {
                          scrollController.position.ensureVisible(
                            PizKey.currentContext
                                .findRenderObject(),
                            alignment:
                            0.0, // How far into view the item should be scrolled (between 0 and 1).
                            duration:
                            const Duration(milliseconds: 200),
                          );
                        });
                      });
                    });
                  });
                });
              });
            } else {
              scrollController.position
                  .ensureVisible(
                SanKey.currentContext.findRenderObject(),
                alignment:
                1.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  TacKey.currentContext.findRenderObject(),
                  alignment:
                  0.0, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position.ensureVisible(
                    PizKey.currentContext.findRenderObject(),
                    alignment:
                    0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  );
                });
              });
            }
          } else {
            scrollController.position.ensureVisible(
              PizKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 800),
            );
          }
        }
        break;
      case 4:
        {
          if (PlaKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                HumbKey.currentContext.findRenderObject(),
                alignment:
                0.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  HumbKey.currentContext.findRenderObject(),
                  alignment:
                  0.5, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    SanKey.currentContext.findRenderObject(),
                    alignment:
                    0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position
                        .ensureVisible(
                      SanKey.currentContext.findRenderObject(),
                      alignment:
                      0.5, // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    )
                        .then((value) {
                      scrollController.position
                          .ensureVisible(
                        TacKey.currentContext.findRenderObject(),
                        alignment:
                        0.0, // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 200),
                      )
                          .then((value) {
                        scrollController.position
                            .ensureVisible(
                          TacKey.currentContext
                              .findRenderObject(),
                          alignment:
                          0.5, // How far into view the item should be scrolled (between 0 and 1).
                          duration: const Duration(milliseconds: 200),
                        )
                            .then((value) {
                          scrollController.position.ensureVisible(
                            PizKey.currentContext
                                .findRenderObject(),
                            alignment:
                            0.0, // How far into view the item should be scrolled (between 0 and 1).
                            duration:
                            const Duration(milliseconds: 200),
                          );
                          scrollController.position.ensureVisible(
                            PlaKey.currentContext
                                .findRenderObject(),
                            alignment:
                            0.0, // How far into view the item should be scrolled (between 0 and 1).
                            duration:
                            const Duration(milliseconds: 200),
                          );
                        });
                      });
                    });
                  });
                });
              });
            } else {
              scrollController.position.ensureVisible(
                SanKey.currentContext.findRenderObject(),
                alignment: 1.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              ).then((value) {
                scrollController.position.ensureVisible(
                  TacKey.currentContext.findRenderObject(),
                  alignment: 0.0, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                ).then((value) {
                  scrollController.position.ensureVisible(
                    PizKey.currentContext.findRenderObject(),
                    alignment: 0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  ).then((value){
                    scrollController.position.ensureVisible(
                        PlaKey.currentContext.findRenderObject(),
                        alignment: 0.0, // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 200),
                    );});
                });
              });
            }
          } else {
            scrollController.position.ensureVisible(
              PlaKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 800),
            );
          }
        }
        break;
      case 5:
        {
          if (PlaKey.currentContext == null) {
            if (_tabController.previousIndex == 0) {
              scrollController.position
                  .ensureVisible(
                HumbKey.currentContext.findRenderObject(),
                alignment:
                0.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              )
                  .then((value) {
                scrollController.position
                    .ensureVisible(
                  HumbKey.currentContext.findRenderObject(),
                  alignment:
                  0.5, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                )
                    .then((value) {
                  scrollController.position
                      .ensureVisible(
                    SanKey.currentContext.findRenderObject(),
                    alignment:
                    0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  )
                      .then((value) {
                    scrollController.position
                        .ensureVisible(
                      SanKey.currentContext.findRenderObject(),
                      alignment:
                      0.5, // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    )
                        .then((value) {
                      scrollController.position
                          .ensureVisible(
                        TacKey.currentContext.findRenderObject(),
                        alignment:
                        0.0, // How far into view the item should be scrolled (between 0 and 1).
                        duration: const Duration(milliseconds: 200),
                      )
                          .then((value) {
                        scrollController.position
                            .ensureVisible(
                          TacKey.currentContext
                              .findRenderObject(),
                          alignment:
                          0.5, // How far into view the item should be scrolled (between 0 and 1).
                          duration: const Duration(milliseconds: 200),
                        )
                            .then((value) {
                          scrollController.position.ensureVisible(
                            PizKey.currentContext
                                .findRenderObject(),
                            alignment:
                            0.0, // How far into view the item should be scrolled (between 0 and 1).
                            duration:
                            const Duration(milliseconds: 200),
                          );
                          scrollController.position.ensureVisible(
                            PlaKey.currentContext
                                .findRenderObject(),
                            alignment:
                            0.0, // How far into view the item should be scrolled (between 0 and 1).
                            duration:
                            const Duration(milliseconds: 200),
                          );
                          scrollController.position.ensureVisible(
                            DriKey.currentContext
                                .findRenderObject(),
                            alignment:
                            0.0, // How far into view the item should be scrolled (between 0 and 1).
                            duration:
                            const Duration(milliseconds: 200),
                          );
                        });
                      });
                    });
                  });
                });
              });
            } else {
              scrollController.position.ensureVisible(
                SanKey.currentContext.findRenderObject(),
                alignment: 1.0, // How far into view the item should be scrolled (between 0 and 1).
                duration: const Duration(milliseconds: 200),
              ).then((value) {
                scrollController.position.ensureVisible(
                  TacKey.currentContext.findRenderObject(),
                  alignment: 0.0, // How far into view the item should be scrolled (between 0 and 1).
                  duration: const Duration(milliseconds: 200),
                ).then((value) {
                  scrollController.position.ensureVisible(
                    PizKey.currentContext.findRenderObject(),
                    alignment: 0.0, // How far into view the item should be scrolled (between 0 and 1).
                    duration: const Duration(milliseconds: 200),
                  ).then((value){
                    scrollController.position.ensureVisible(
                      PlaKey.currentContext.findRenderObject(),
                      alignment: 0.0, // How far into view the item should be scrolled (between 0 and 1).
                      duration: const Duration(milliseconds: 200),
                    ).then((value){
                      scrollController.position.ensureVisible(
                          DriKey.currentContext.findRenderObject(),
                          alignment: 0.0, // How far into view the item should be scrolled (between 0 and 1).
                          duration: const Duration(milliseconds: 200),
                      );});});
                });
              });
            }
          } else {
            scrollController.position.ensureVisible(
              DriKey.currentContext.findRenderObject(),
              alignment: 0.0,
              // How far into view the item should be scrolled (between 0 and 1).
              duration: const Duration(milliseconds: 800),
            );
          }
        }
        break;
    }
  }

  SliverPersistentHeader makeTabBarHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
        child: Container(
          color: Colors.white,
          child: TabBar(
            onTap: (val) {
              tabBarOnTap(val);
            },
            isScrollable: true,
            indicatorColor: Color(0xffE74C3C),
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            labelPadding: EdgeInsets.fromLTRB(15,0,0,0),
            controller: _tabController,
            tabs: <Widget>[
              new Tab(
                child: Text(
                  "Humbergers",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              new Tab(
                child: Text(
                  "Sandwichs",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              new Tab(
                child: Text(
                  "Pizza",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              new Tab(
                child: Text(
                  "Tacos",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              new Tab(
                child: Text(
                  "Plats",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
              new Tab(
                child: Text(
                  "Drinks",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ],
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _topTabController.dispose();
    scrollController.dispose();
  }


  final Restaurant restaurant = Restaurant();
  Future <List<Categorie>> futureData;
  Future <List<Article>> futureDataArt;
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          iconSize: 30.0,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children :[
          Row(
            children: <Widget>[
              Container (
                margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
                child:ClipOval(
                  child:Hero(
                    tag: widget.logoUrld,
                    child: Image(
                      height: 100.0,
                      width:100,
                      fit: BoxFit.cover,
                      image: AssetImage(widget.logoUrld),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.named, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,),),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color:Colors.grey[200],
                        border: Border.all(
                          width: 1.0,
                          color: Colors.grey[200],
                        ),
                      ),
                      child:Row(
                        children:[
                          Icon(
                            Icons.access_time ,
                            size:15,
                          ),
                          SizedBox(width:2),
                          Text(widget.dureelivd,style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal,),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Visibility(
            visible: !_isvisible,
              child: Column(
                children: [
                  Text(widget.addrd),
                  Text(widget.favorid),
                  Text(widget.ratingd),
                  Text(widget.horaired),
                  Text(widget.serviced),
                  Text(widget.cuisined),
                ],
              ),
          ),
          Container(
            margin:EdgeInsets.fromLTRB(10, 10, 0, 10),
            child:SizedBox(
              width:360,
              height:30,
              child:RaisedButton(
                color:Colors.grey[200],
                child: Text("View Full Details                                  >>>",textAlign: TextAlign.start,style:TextStyle(color:Colors.black)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (_) =>MoreDetails(named: widget.named,dureelivd: widget.dureelivd,ratingd: widget.ratingd,cuisined: widget.cuisined,horaired: widget.horaired,addrd: widget.addrd,serviced: widget.serviced,favorid: widget.favorid,idrestd: widget.idrestd,logoUrld:widget.logoUrld)) ),
              ),
            ),
          ),
          SizedBox(height:10),
          SizedBox(
          height:450,
          child:FutureBuilder <List<Categorie>>(
           future: futureData,
           builder: (context, snapshot){
           if (snapshot.hasData) {
          List<Categorie> categorie = snapshot.data;
           return CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              makeTabBarHeader(),
              SliverList(
                key: sliverListtKey,
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      key: HumbKey,
                      child:CategorieView(id_cat:categorie[0].idcat,named:categorie[0].name,idrestdd: widget.idrestd),
                    ),
                    Container(
                      key: SanKey,
                      child: CategorieView(id_cat:categorie[1].idcat,named:categorie[1].name,idrestdd: widget.idrestd),
                    ),
                    Container(
                      key: TacKey,
                      child:CategorieView(id_cat:categorie[2].idcat,named:categorie[2].name,idrestdd: widget.idrestd),
                    ),
                    Container(
                      key: PizKey,
                      child:CategorieView(id_cat:categorie[3].idcat,named:categorie[3].name,idrestdd: widget.idrestd),
                    ),
                    Container(
                      key: PlaKey,
                      child:CategorieView(id_cat:categorie[4].idcat,named:categorie[4].name,idrestdd: widget.idrestd),
                    ),
                    Container(
                      key: DriKey,
                      child:CategorieView(id_cat:categorie[5].idcat,named:categorie[5].name,idrestdd: widget.idrestd),
                    ),
                  ],
                ),
              ),
            ],
          );
           }else if (snapshot.hasError) {
             return Text("${snapshot.error}");
           }// By default show a loading spinner.
           return CircularProgressIndicator();
           },),
          ),
        ],
      ),

          ),
    );
  }
}
