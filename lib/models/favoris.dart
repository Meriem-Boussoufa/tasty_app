class Favoris {
  final String idrest;
  final String idclt;
  String favori;
  final  String imageUrl;
  final String logoUrl ;
  final String name;
  final String dureeliv;
  final String rating;
  String favoris2;
  final String idfav;


  Favoris( {
    this.idrest,
    this.idclt,
    this.favori,
    this.imageUrl,
    this.logoUrl,
    this.name,
    this.dureeliv,
    this.rating,
    this.favoris2,
    this.idfav,
  });

  factory Favoris.fromJson(Map<String,dynamic> json){
    return Favoris(
      idrest : json['id_rest'],
      idclt : json['phone'],
      favori: json['favori'],
      imageUrl: json['img'],
      logoUrl : json['logo'],
      name : json['name_rest'],
      dureeliv : json['dureeliv'],
      rating: json['rating'],
      favoris2: json['favori'],
      idfav: json['id_fav'],
    );
  }
}