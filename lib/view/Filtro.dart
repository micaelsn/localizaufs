import 'package:flutter/material.dart';
import 'package:localizaufs/controler/controller_location.dart';
import 'package:localizaufs/controler/controller_location_ws.dart';
import 'package:localizaufs/model/classes/Location.dart';
import 'package:localizaufs/view/LocItem.dart';
import 'package:localizaufs/view/Map.dart';


class Filtro extends StatefulWidget{
  final List<Location> listLocsMarked;

  Filtro(List<Location> listLocsMarked)
          : listLocsMarked = listLocsMarked,
          super(key: new ObjectKey(listLocsMarked));

  _FiltroSreen createState()=> _FiltroSreen(listLocsMarked);

}

class _FiltroSreen extends State<Filtro> {
  final List<Location> listLocsMarked;

  _FiltroSreen(this.listLocsMarked);

  var controllerLocation = new ControllerLocation();
  var controllerLocationWS = new ControllerLocationWS();

  var data;
  int countBD;
  List<Location> list = new List<Location>();
  TextEditingController controllerTxtField = new TextEditingController();
  bool downloading;
  bool txtFieldOnChanged = false;
  bool resultData;
  @override
  void initState() {
    downloading = true;
    this.getDataBD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Filtro"),
      ),
      body: new Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
            child: TextField(
              controller: controllerTxtField,
              decoration: InputDecoration(
                hintText: "Procurar Localização...",
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: BorderSide(color: Colors.blue[100])
                ),
                suffixIcon: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.search),
                  onPressed: (){
                    onPressed(controllerTxtField.text);
                  },
                ),
              ),
            ),
          ),
          downloading ? circularProgresso() : listViewLocs(),
        ],
      ),       
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.location_on),
          onPressed: (){
            int count = 0;
            for(Location l in list){
              if(l.isCheck){
                l.id = count;
                listLocsMarked.add(l);
                count++;
              }
            }
          },
        ),
      );
  }

  Widget listViewLocs(){
    if(resultData){
    return new Expanded(
            child: new ListView.builder(
            itemCount: list == null ? 0 : list.length,
            itemBuilder: (BuildContext context, int index){
            return new LocItem(list[index]);
            },)
          );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          'Nenhum resultado encontrado :(', 
          textAlign: TextAlign.center,
          ),
      );
    }
  }

  Widget circularProgresso(){
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          ),
        ),
      )
    );
  }

  void getDataBD() async{
    // verifica se há atualização
    bool res = await controllerLocationWS.atualizar();
    if (res) {
      print('downloanding');
      await controllerLocationWS.getDataWS();      
    }
    // captura data do banco de dados
    data = await controllerLocation.selectLocation();

    int lengthData = (data?.length ?? 0);

    if(lengthData > 0)
      resultData = true;
    else
      resultData = false;

    for(int i = 0; i < lengthData; i++){
      this.setState(() {
      list.add(new Location(i, data[i]["lat"], 
      data[i]["long"], data[i]["nome"], data[i]["cor"],'',
      data[i]["numero"],false));
      });
    }
    // mostrar o list view
    this.setState((){
      downloading = false;
    });
  }
  
  void onPressed(text) async{
    if(text.length >= 2){
      setState(() {
        downloading = true;
        list.clear();
      });
      var data = await controllerLocation.searchLocation(text);

      int lengthData = (data?.length ?? 0);

      if(lengthData > 0)
        resultData = true;
      else
        resultData = false;

      for(int i = 0; i < lengthData; i++){
        this.setState(() {
        list.add(new Location(i, data[i]["lat"], 
        data[i]["long"], data[i]["nome"], data[i]["cor"],'',
        data[i]["numero"],false));
        });
      }
      setState(() {
        downloading = false;
      });
    }
  }
}