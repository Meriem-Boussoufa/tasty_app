class Viande{
  final String id_via;
  final String name_via;
  final String price_via;

  Viande( {
    this.id_via,
    this.name_via,
    this.price_via,
  });

  factory Viande.fromJson(Map<String,dynamic> json){
    return Viande(
      id_via : json['id_viande'],
      name_via : json['name_viande'],
      price_via : json['price_viande'],
    );
  }
}