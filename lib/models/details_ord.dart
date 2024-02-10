class DetailsOrd {
  final String idcmd;
  final String idart;
  final String Stotal;
  final String qte;
  final String date;
  final String nameart;
  final String priceart;

  DetailsOrd({
    this.idcmd,
    this.idart,
    this.Stotal,
    this.qte,
    this.date,
    this.nameart,
    this.priceart
  });

  factory DetailsOrd.fromJson(Map<String,dynamic> json){
    return DetailsOrd(
      idcmd: json['id_cmd'],
      idart: json['id_art'],
      Stotal: json['S_total'],
      qte: json['qte'],
      date:json['date'],
      nameart:json['name_art'],
      priceart: json['prix'],
    );
  }
}