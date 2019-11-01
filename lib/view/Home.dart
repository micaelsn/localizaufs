import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:localizaufs/model/classes/Location.dart';
import 'Feed.dart';
import 'Map.dart';
import 'AppBarAnimator.dart';
//import 'PerfilUsuario.dart';

class Home extends StatefulWidget {
  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  static List<Location> listLocsMarked = new List<Location>();
  TextEditingController controllerTxtField = new TextEditingController();
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<Widget> _children = [
    Feed(),
    Mapa(_scaffoldKey, listLocsMarked)
  ];

  /* METODO BUILDER
    Apresenta:
    AppBar, Drawer, Body -> <widget>[]
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawer(),
      backgroundColor: Colors.grey[200],
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
          Container(
            color: Colors.grey[200],
            child: AppBarAnimator(_scaffoldKey),
          ),
          Container(
            color: Colors.grey[200],
            child: _children[_currentIndex],
          ),
          ],
        ),
      ),
      bottomNavigationBar: navigationBar(),
    );
  }

  Widget navigationBar(){ //Bottom Navigation Bar
    return BottomNavigationBar(
        onTap: onTabTapped, //trocar a container atual
        currentIndex: _currentIndex, //atual container
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Início'),
            ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.map),
            title: new Text('Mapa'),
            
          ),
          /*BottomNavigationBarItem(
            icon: new Icon(Icons.add_location),
            title: new Text('Adcionar')
          )*/
        ],
      );
  }

  Widget drawer(){// Sliding side menu
    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            /*currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaQPs6Rb3O9qfJOtAn9M9kxmOXNDcowlP8ARgPNTUy2VajlPpXZA"),
              ),
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => PerfilUsuario()
                  ));
              },
            ),*/
            accountName: Text(
              "SEJA BEM VINDO,", 
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            accountEmail: Text(
              "Caro usuário",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://noticiasconcursos.com.br/wp-content/uploads/2018/04/ufs-se.jpg"),
              )
            ),
          ),
          ListTile(
            title: Text("Compartilhar"),
            trailing: Icon(Icons.share),
            onTap: (){
              Share.share('Baixe já o aplicativo localizaUFS para checar eventos e localização! :)');
            },
          ),
          /*ListTile(
            title: Text("Discuções De Pesquisa"),
            trailing: Icon(Icons.local_library),
          ),
          ListTile(
            title: Text("Avaliação de Professores"),
            trailing: Icon(Icons.local_library),
          ),
          ListTile(
            title: Text("Mensagens"),
            trailing: Icon(Icons.message),
          ),
          ListTile(
            title: Text("Cine UFS"),
            trailing: Icon(Icons.movie_creation),
          ),
          ListTile(
            title: Text("Bichos do Campus"),
            trailing: Icon(Icons.pets),
          ),*/
        ],
      ),
    );
  }
  
  Widget optionsOnpressed(){
    return PopupMenuButton(
      key: _scaffoldKey,
      
    );
  }

  Widget textField(){//ainda não colocado
    return Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 10.0),
            child: TextField(
              controller: controllerTxtField,
              decoration: InputDecoration(
                hintText: "Não sei ainda..",
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: BorderSide(color: Colors.blue[100])
                ),
                suffixIcon: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.search),
                  onPressed: (){
                   //TODO
                  },
                ),
              ),
            ),
          );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}