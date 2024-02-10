
class Article {
  final String imageUrl;
  final String name;
  final String descri;
  final String price;
  final String idart;

  Article( {
    this.imageUrl,
    this.name,
    this.descri,
    this.price,
    this.idart
  });

  factory Article.fromJson(Map<String,dynamic> json){
    return Article(
      imageUrl : json['img'],
      name : json['name_art'],
      descri : json['descri'],
      price : json['prix'],
      idart: json['id_art'],
    );
  }
}
