class Frite {
  final String id_fri;
  final String name_fri;
  final String price_fri;

  Frite( {
    this.id_fri,
    this.name_fri,
    this.price_fri,
  });

  factory Frite.fromJson(Map<String,dynamic> json){
    return Frite(
      id_fri : json['id_frite'],
      name_fri : json['name_frite'],
      price_fri : json['price_frite'],
    );
  }
}