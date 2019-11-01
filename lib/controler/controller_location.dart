import 'package:localizaufs/model/classes/Location.dart';
import 'package:localizaufs/model/database/data_base_helper.dart';
import 'package:localizaufs/model/database/script.dart';

class ControllerLocation{
  DatabaseHelper database = new DatabaseHelper();

  Future<List<Map<String,dynamic>>> selectLocation() async {
    var dbLocation = await database.db;
    var res = await dbLocation.query(Script.TABLE_LOCALIZACAO);
    if(res.length > 0){
      return res;
    }
    return null;
  }

  Future<List<Map<String,dynamic>>> searchLocation(String str) async {
    var dbLocation = await database.db;
    var res = await dbLocation.rawQuery("SELECT * FROM tb_localizacao"
            +" WHERE nome LIKE '%$str%'");
    print(res);
    if(res.length > 0){
      print('retorno searchLocation');
      return res;
    }
    return null;
  }

  void deleteTableLoc() async{
    var dbLocation = await database.db;
    await dbLocation.rawDelete("DELETE FROM " + Script.TABLE_LOCALIZACAO, null);
  }

  Future<int> saveLocation(Location loc) async {
    var dbLocation = await database.db;
    var res = await dbLocation.insert(Script.TABLE_LOCALIZACAO, loc.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> allLocations() async {
    var dbLocation = await database.db;
    var res = await dbLocation.rawQuery('SELECT COUNT('+Script.COLUMN_ID_LOC+') AS count FROM '
     + Script.TABLE_LOCALIZACAO);
    return res;
  }
}