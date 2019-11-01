import 'package:localizaufs/controler/controller_location.dart';
import 'package:localizaufs/model/classes/Location.dart';
import 'package:localizaufs/model/classes/Eventos.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ControllerLocationWS {
  var controllerLocation = new ControllerLocation();
  var dataWS;
  //ControllerLocationWS();

  void getDataWS() async{
    var count = await controllerLocation.allLocations();
    int countBD = count[0]["count"];
    if(countBD > 0)
      controllerLocation.deleteTableLoc();
    //get data
    var response = await http.get(
      Uri.encodeFull("http://concitec2.com/flutter/getWS.php?func=2"),
      headers: {
        "Accept": "application/json"
      }
    );
    dataWS = json.decode(response.body);
    for(int i=0; i< dataWS.length; i++){
      Location l = new Location(null, dataWS[i]["lat"], 
      dataWS[i]["long"], dataWS[i]["nome"], dataWS[i]["cor"],'',dataWS[i]["numero"],false);
      var res = await controllerLocation.saveLocation(l);
      print(res);
    }
  }

  Future<bool> atualizar() async{
    var response = await http.get(
      Uri.encodeFull("http://concitec2.com/flutter/getWS.php?func=1"),
      headers: {
        "Accept": "application/json"
      }
    );
    var valorAtl = json.decode(response.body);
    //Se a qnt de locs no banco for diferente do ws, getDataWs
    int countWS = valorAtl["qnt_loc_webserver"];
    var count = await controllerLocation.allLocations();
    int countBD = count[0]["count"];
    print('TARATARA '+countWS.toString()+ ' ' +count.toString());
    return countWS > countBD;
  }
}