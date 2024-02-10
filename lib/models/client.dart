class Client {
  final String idclt;
  final String nameclt;
  final String prenomclt;
  final String adrclt;
  final String emailclt;
  final String phoneclt;

  Client({
  this.idclt,
  this.nameclt,
  this.prenomclt,
  this.adrclt,
  this.emailclt,
  this.phoneclt,
  });

  factory Client.fromJson(Map<String,dynamic> json){
    return Client(
      idclt : json['id_clt'],
      nameclt: json['name_clt'],
      prenomclt: json['prenom_clt'],
      adrclt: json['adr_clt'],
      emailclt: json['email'],
      phoneclt: json['phone'],
    );
  }
}