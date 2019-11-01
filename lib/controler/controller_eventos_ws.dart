import 'package:localizaufs/model/classes/Eventos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ControllerEventosWS {
  List<Eventos> eventos = List<Eventos>();

  //retorna lista true se conseguiu pegar lista de eventos
  Future<bool> getCrawlerEventos() async{
    var response = await http.get(
      Uri.encodeFull("https://socialufs.herokuapp.com/getEventos"),
      headers: {
        "Accept": "application/json"
      }
    );
    var dataWS = json.decode(response.body);
    print(dataWS[0]["titulo"]);
    for(int i=0; i < dataWS.length; i++){
       Eventos e = new Eventos(dataWS[i]["titulo"],dataWS[i]["coordenador"],
       dataWS[i]["tipo"],dataWS[i]["dataInscricao"],dataWS[i]["vagasTotal"],dataWS[i]["vagasRes"]);
       eventos.add(e);
    }
    return true; 
  }
}