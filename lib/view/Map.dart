import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizaufs/controler/permissions.dart';
import 'package:localizaufs/controler/controller_location_ws.dart';
import 'package:localizaufs/model/classes/Location.dart';
import 'package:localizaufs/view/FiltroLocs.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget{
  final GlobalKey<ScaffoldState> _scaffoldKey;
  final List<Location> listLocsMarked;
  Mapa(GlobalKey<ScaffoldState> _scaffoldKey, List<Location> listLocsMarked)
          : _scaffoldKey = _scaffoldKey, listLocsMarked = listLocsMarked,
           super(key: new ObjectKey(_scaffoldKey));

  _Mappage createState()=> _Mappage(_scaffoldKey, listLocsMarked);

}

class _Mappage extends State<Mapa> {
  GlobalKey<ScaffoldState> _scaffoldKey;
  Completer<GoogleMapController> _controller = Completer();
  final List<Location> listLocsMarked;
  var controllerLocationWS = new ControllerLocationWS();
  Set<Marker> markers = new Set();
  CheckPermissionsApp permissionsApp = new CheckPermissionsApp();
  VoidCallback _showPerBottomSheetCallBack; //Bottom Sheet
/* METODOS
  build: retorna um SingleChildScrollView que possui
    _googleMap: retorna o container do mapa
    _floatingButton: positoned floating button que aciona um dialog alert
*/
  _Mappage(this._scaffoldKey, this.listLocsMarked);

  @override
  void initState() {
    permissionsApp.requestPermission();
    _showPerBottomSheetCallBack = _showBottomSheet;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    return  SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          _googleMap(context),
         _floatingButton(context),
         // _buildContainer(),
        ],
      ),
    );
 }
  //Retorna container do mapa
  Container _googleMap(BuildContext context){
    //Inicializar os marcadores das entradas
    if(listLocsMarked.length > 0)
      _addMarkers(context);
    else{
      listLocsMarked.add(Location(0, "-10.921904","-37.099875","Entrada Principal",'','','0',false));
      listLocsMarked.add(Location(1, "-10.925308", "-37.104908","Entrada Secundária",'','','0',false));
      _addMarkers(context);
    }
    return Container(
      height: MediaQuery.of(context).size.height - 180,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(-10.925562, -37.102147), 
          zoom: 17.666
          ),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        markers: markers,
      ),
    );
  }

  Positioned _floatingButton(BuildContext context){
    return  Positioned(
        bottom: 10,
        right: 10,
        child: FloatingActionButton(
          child: Icon(Icons.search),
          onPressed: _showPerBottomSheetCallBack,/*(){
            markers.clear();
            listLocsMarked.clear();
            //mostrarDialog(context);
          },*/ 
        ),
      );
  }

  void _showBottomSheet(){
    setState(() {
      _showPerBottomSheetCallBack = null;
    });
    _scaffoldKey.currentState.showBottomSheet((context){
      markers.clear();
      return Container(
        alignment: Alignment.topCenter,
        height: 320,
        child: Filtro(listLocsMarked),
      );
    }).
    closed.
      whenComplete((){
        if(mounted){
          setState(() {
            _showPerBottomSheetCallBack = _showBottomSheet;
          });
          
        }
      }
    );
  }

  void _addMarkers(BuildContext context){
    _goToTheLake();
    for (var l in listLocsMarked) {
      _add(l, context);
    }
  }
  // new camera position
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
      bearing: 270.0,
      target: LatLng(-10.925689, -37.102738),      
      tilt: 30.0,
      zoom: 15.5,)));
  }
  //Add Marker
  void _add(Location l, BuildContext context) { 
    var markerIdVal = l.id.toString();
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        double.parse(l.lat),
        double.parse(l.long),
      ),
      infoWindow: InfoWindow(title: l.nome),
      onTap: () {
        _onMarkerTapped(markerId, context);
      },
    );

    setState(() {
      // adding a new marker to map
      markers.add(marker);
    });
  }

  void  _onMarkerTapped(MarkerId markerId, context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        Location l = listLocsMarked[int.parse(markerId.value.toString())];
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.lightBlue[50],
                ),
                child: Text(
                  l.nome,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                  ),
              ),
              ListTile(
                leading: Text(
                  "Telefone:"+l.numero,
                  style: TextStyle(
                    fontSize: 23.0,
                  ),
                  ),
                subtitle: IconButton(
                  iconSize: 23.0,
                  icon: new Icon(
                    Icons.content_copy,
                    ),
                  onPressed: (){
                    print("pressed");
                    Clipboard.setData(new ClipboardData(text: l.numero));
                  },
                ),
              ),              
            ],
          ),
        );
      }
    );
  }
}
