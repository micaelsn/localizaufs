import 'package:flutter/material.dart';

class CircularProgresso{

  static Widget circularProgresso(BuildContext context, Color clrBkg,){
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        //height: MediaQuery.of(context).size.height - 220,
        //color: clrBkg,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor:  Colors.grey[200],
              ),
            ],
          ),
        ),
      )
    );
  }

  static Widget serverIndisponivel(){
    return Center(
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          "Server indisponível :("
        )
      )
    );
  }
}