import 'package:flutter/material.dart';
import 'article.dart';

class Cart with ChangeNotifier{
  List<Article> _articles =[];
  int count;
  double totalprice =0.0;
  int totalcount;
  double subtotal =0.0;
  int idresto;
  List idartdd = [];
  void add(Article article,int count, int idartd, int idrest,double prix, double prix1,double prix2, double prix3, double prix4){
    _articles.add(article);
    idartdd.add(idartd);
    idresto = idrest;
    totalcount = count;
    subtotal +=(double.parse(article.price))*totalcount;
    totalprice += (double.parse(article.price)+prix+prix1+prix2+prix3+prix4)*count+100+150 ;
    notifyListeners();
  }
  void remove(Article article){
    _articles.remove(article);
    notifyListeners();
  }
  List <Article> get basketitem {
    return _articles;
  }
}