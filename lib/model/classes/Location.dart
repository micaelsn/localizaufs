import 'dart:convert';

class Location{
  int _id;
  String _lat;
  String _long;
  String _nome;
  String _cor; // Cor do Marker
  String _avatarImage;
  String _numero;
  bool _isCheck;
  int idBd;//para saber se já foi marcado na classe filtro

  /* 
  *  As cores dos markers serão
  *  VERMELHO para posição de chegada
  *  AMARELO para de departamento
  *  AZUL para orgãos
  *  VERDE para praças
  *  ...
   */
  
  Location (this._id, 
            this._lat, 
            this._long, 
            this._nome,
            this._cor,
            this._avatarImage,
            this._numero,
            this._isCheck);

  factory Location.fromMap(Map<String,dynamic> obj) => new Location(
    obj["id"],
    obj["lat"],
    obj["long"],
    obj["nome"],
    obj["cor"],
    '',
    obj["numero"],
    false);
  
/*
  void fromMap2(Map<String,dynamic> obj){
    this._id = obj["id"];
    this._lat = obj["lat"];
    this._long = obj["long"];
    this._nome = obj["nome"];
    this._cor = obj["cor"];
  }*/
  //getters
  int get id => _id;
  String get lat => _lat;
  String get long => _long;
  String get nome => _nome;
  String get cor => _cor;
  String get avatarImage => _avatarImage;
  String get numero => _numero;
  bool get isCheck => _isCheck;  
  //setters
  set isCheck(bool isCheck){this._isCheck = isCheck;}
  set id(int id){this._id = id;}
  
  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["lat"] = lat;
    map["long"] = long;
    map["nome"] = nome;
    map["cor"] = cor;
    map["numero"] = numero;
    return map;
  }
  String toString(){
    return lat +' '+long+' '+nome+' '+cor+' '+numero;
  }
}