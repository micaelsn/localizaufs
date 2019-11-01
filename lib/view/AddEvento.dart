import 'package:flutter/material.dart';
import 'package:localizaufs/controler/controller_location.dart';
import 'package:localizaufs/model/classes/Location.dart';

class Add extends StatefulWidget{
  _AddPage createState()=> _AddPage();
}

class _AddPage extends State<Add> {
 var location = new ControllerLocation();
 final myController1 = TextEditingController();
 final myController2 = TextEditingController();
 final myController3 = TextEditingController();
 final myController4 = TextEditingController();

 @override
 Widget build(BuildContext context) {
   return SingleChildScrollView(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           TextField(
             controller: myController1,
             decoration: InputDecoration(
               hintText: 'lat',
             ),
           ),
           TextField(
             controller: myController2,
             decoration: InputDecoration(
               hintText: 'long',
             ),
            ),
            TextField(
             controller: myController3,
             decoration: InputDecoration(
               hintText: 'nome',
             )
            ),
            TextField(
             controller: myController4,
             decoration: InputDecoration(
               hintText: 'cor',
             )
            ),
            RaisedButton(
            ),
         ],
       ),
     );
 }
/*
 void onPressed(){
  Location loc = new Location(null,myController1.text,myController2.text, myController3.text, myController4.text,'',false);
  try {
    location.saveLocation(loc);
    print('Inserido com sucesso!');
  } catch (e) {
    print(e);
  }
 }*/
}