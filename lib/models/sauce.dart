class Sauce {
   String id_sau;
  final String name_sau;
  final String price_sau;

  Sauce( {
    this.id_sau,
    this.name_sau,
    this.price_sau,
  });

  factory Sauce.fromJson(Map<String,dynamic> json){
    return Sauce(
      id_sau : json['id_sauce'],
      name_sau : json['name_sauce'],
      price_sau : json['price_sauce'],
    );
  }
}