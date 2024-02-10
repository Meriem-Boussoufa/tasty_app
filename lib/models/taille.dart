class Taille {
  final String id_tai;
  final String name_tai;
  final String price_tai;

  Taille( {
    this.id_tai,
    this.name_tai,
    this.price_tai,
  });

  factory Taille.fromJson(Map<String,dynamic> json){
    return Taille(
      id_tai : json['id_taille'],
      name_tai : json['name_taille'],
      price_tai : json['price_taille'],
    );
  }
}
