import 'package:flutter/material.dart';
import 'package:localizaufs/model/classes/Location.dart';
 
class LocItem extends StatefulWidget{
 
  final Location loc;
 
  LocItem(Location loc)
      : loc = loc,
        super(key: new ObjectKey(loc));
 
  @override
  LocItemState createState() {
    return new LocItemState(loc);
  }
}
class LocItemState extends State<LocItem> {
 
  final Location loc;
 
  LocItemState(this.loc);
 
 
  @override
  Widget build(BuildContext context) {
    return new ListTile(
        onTap:null,
        leading: new CircleAvatar(
          backgroundColor: Colors.blue,
         // child: new Image(image: new AssetImage(loc.avatarImage)),
         child: Icon(Icons.location_city),
        ),
        title: new Row(
          children: <Widget>[
            new Expanded(child: new Text(loc.nome)),
            new Checkbox(value: loc.isCheck, onChanged: (bool value) {
              loc.isCheck = value;
              setState(() {
                loc.isCheck = value;
              });
            })
          ],
        )
    );
  }
}