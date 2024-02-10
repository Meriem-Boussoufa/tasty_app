class Gratine {
  final String id_gra;
  final String name_gra;
  final String price_gra;

  Gratine( {
    this.id_gra,
    this.name_gra,
    this.price_gra,
  });

  factory Gratine.fromJson(Map<String,dynamic> json){
    return Gratine(
      id_gra : json['id_gratine'],
      name_gra : json['name_gratine'],
      price_gra : json['price_gratine'],
    );
  }
}