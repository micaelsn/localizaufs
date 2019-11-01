import 'dart:convert';

class Eventos{
  String _titulo;
  String _coordenador;
  String _tipo;
  String _data;
  String _vagasTotal;
  String _vagasRes;

  Eventos(this._titulo,this._coordenador,this._tipo,
  this._data,this._vagasTotal,this._vagasRes);

  String get titulo => _titulo;
  String get coordenador => _coordenador;
  String get tipo => _tipo;
  String get data => _data;
  String get vagasTotal => _vagasTotal;
  String get vagasRes => _vagasRes;

  String toTitulo(){
    if(titulo.length > 40){
      return titulo.substring(1,40) + "...";
    }
    return titulo;
  }

  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["titulo"] = titulo;
    map["coordenador"] = coordenador;
    map["tipo"] = tipo;
    map["data"] = data;
    return map;
  }

  String toString(){
    return titulo+' '+coordenador+' '+tipo+' '+data;
  }
}