import 'package:flutter/material.dart';


class PerfilUsuario extends StatefulWidget {
  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  
  var colors = [Color(0xFF7fdefc), Color(0xFF00b5f8), Color(0xFF00c2fa), 
  Color(0xFF00d7fd), Color(0xFF00dbfc), Color(0xFF00ddfd)];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
          children: <Widget>[
            ClipPath(
              child: Container(
                //color: Colors.black.withOpacity(0.8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: colors,
                  ),
                ),
              ),
              clipper: BackgroundClipper(),
            ),
            boxData(size.width),
            avatar(size),
          ],
        ),
    );
  }
    Positioned boxData(double width){
    return Positioned(
      top: 180.0,
      left: 50,
      right: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 200,
          width: width - 100,
          
          child: Column(
            children: <Widget>[
              
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: Colors.grey[300],
            
          ),
        ),
      ) 
    );
  }

    Positioned avatar(Size size){
    return Positioned(
      top: 80.0,
      left: size.width / 2 - 75,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaQPs6Rb3O9qfJOtAn9M9kxmOXNDcowlP8ARgPNTUy2VajlPpXZA"),
                fit: BoxFit.cover,
                ),
              borderRadius: BorderRadius.all(Radius.circular(75.0)),
              boxShadow: [BoxShadow(blurRadius: 5.0, color: Colors.grey[700])],
            ),
          ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height * 0.3);

    var firstControlPoint = Offset(size.width *0.25, size.height* 0.5);
    var firstEndPoint = Offset(size.width *0.5, size.height * 0.5);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width * 0.75, size.height * 0.5);
    var secondEndPoint = Offset(size.width, size.height * 0.3);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
} 

