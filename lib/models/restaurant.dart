
class Restaurant {
  final String imageUrl;
  final String logoUrl ;
  final String name;
  final String dureeliv;
  final int rating;
  final String cuisine;
  final String horaire;
  final String addr;
  final String service;
  final int idrest;
  int favori;

  Restaurant({
    this.imageUrl,
    this.logoUrl,
    this.name,
    this.cuisine,
    this.dureeliv,
    this.horaire,
    this.addr,
    this.service,
    this.rating,
    this.idrest,
    this.favori,
  });

  factory Restaurant.fromJson(Map<String,dynamic> json){
    return Restaurant(
      imageUrl: json['img'],
      logoUrl : json['logo'],
      name : json['name_rest'],
      dureeliv : json['dureeliv'],
      addr : json['adr_rest'],
      service : json['service'],
      cuisine :json['cuisine'],
      horaire :json['horaire'],
      rating: json['rating'] ,
      idrest :json['id_rest'],
      favori :json['favori'],
    );
  }
}
