
class Categorie {
  final String idcat;
  final String name;

  Categorie({
    this.idcat,
    this.name,
  });

  factory Categorie.fromJson(Map<String,dynamic> json){
    return Categorie(
      name : json['name_cat'],
      idcat:  json['id_cat'],
    );
  }
}