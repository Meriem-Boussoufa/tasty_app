class Order {
  final String idclt;
  final String idcmd;
  final String total;
  final String etatcmd;
  final String namerest;
  final String logoUrl;
  final String date;
  final String STOTAL;
  Order({
    this.idclt,
    this.idcmd,
    this.total,
    this.etatcmd,
    this.namerest,
    this.logoUrl,
    this.date,
    this.STOTAL,
  });

  factory Order.fromJson(Map<String,dynamic> json){
    return Order(
      idclt : json['phone'],
      idcmd: json['id_cmd'],
      total: json['total'],
      etatcmd: json['etat_cmd'],
      namerest: json['name_rest'],
      logoUrl: json['logo'],
      date: json['date'],
      STOTAL: json['STOTAL'],
    );
  }
}