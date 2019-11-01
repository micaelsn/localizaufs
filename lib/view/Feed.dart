import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:localizaufs/controler/controller_eventos_ws.dart';
import 'package:localizaufs/view/componentes/CircularProgresso.dart';
import 'dart:math';

class Feed extends StatefulWidget{
  @override
  _FeedPage createState() => new _FeedPage();
}
var eventosWS = ControllerEventosWS();
var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _FeedPage extends State<Feed> {
  var currentPage = eventosWS.eventos.length - 1.0;
  bool downloading = false;
  
  /* METODO BUILDER
    Apresenta:
    Eventos, Feed do usuário, ...
  */
  @override
  void initState() {
    getDataEventos();
    super.initState();
  }

  void getDataEventos() async{
    var res = await eventosWS.getCrawlerEventos();
    if(res){
      setState(() {
        downloading = res;
        currentPage = eventosWS.eventos.length - 1.0;
        //print(downloading);
        //print(currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: eventosWS.eventos.length - 1);
    controller.addListener((){
    setState((){
      currentPage = controller.page;
      });
    });
    
    return SingleChildScrollView(
     child: Column(
       children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[
              Text(
                "   Destaques",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 25.0,
                    fontFamily: "TitWebBold",
                    //letterSpacing: 1.0,
                  ),
                ),
                GestureDetector(
                  onTap: () async{
                    const url = 'https://www.sigaa.ufs.br/sigaa/public/extensao/paginaListaPeriodosInscricoesAtividadesPublico.jsf?aba=p-extensao';
                    if (await canLaunch(url)) {
                        await launch(url);
                    }
                  },
                  child: Text(
                    "Ver todos ",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 13.0,
                        fontFamily: "KanitBold",
                        //letterSpacing: 1.0,
                      ),
                    ),
                )
           ],
         ),
         downloading ? listaEventos(controller): CircularProgresso.circularProgresso(context, Colors.grey[200])     
       ],
     )
    );
  }
  
  Stack listaEventos([PageController controller]){
    //Apresenta a lista de eventos
    return Stack(
          children: <Widget>[
            CardScrollWidget(currentPage),
            Positioned.fill(
              child: PageView.builder(
                itemCount: eventosWS.eventos.length,
                controller: controller,
                reverse: true,
                itemBuilder: (context, index){
                  return Container();
                },
              ),
            )
          ],
        );
  }
}

class CardScrollWidget extends StatelessWidget{
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  CardScrollWidget(this.currentPage);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(
        builder: (context, constraints){
          var width = constraints.maxWidth;
          var height = constraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();
          //print("for "+currentPage);
          for(var i = 0; i < eventosWS.eventos.length; i++){
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding + 
                max(
                    primaryCardLeft - 
                      horizontalInset * 
                      -delta * (isOnRight ? 15 : 1), 0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset + max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white12,
                        offset: Offset(3.0, 6.0),
                        blurRadius: 10.0
                      )
                    ]
                  ),
                  child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child:  Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        // Setting the image
                        Image.asset(
                          "assets/images/temp/image4.jpg", 
                          fit: BoxFit.cover,
                          ),
                          Align(
                            // Setting description text
                            alignment: Alignment.bottomLeft,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                  Expanded( flex: 6, child:
                                  SizedBox(
                                    height: 10.0,
                                  )),
                                  Expanded( flex: 4, child:
                                  Text(
                                    eventosWS.eventos[i].data,
                                    style: TextStyle(
                                      fontFamily: "KanitBold",
                                      fontSize: 20.0,
                                    ),
                                  )
                                  )
                                  ],
                                ),
                                Expanded( flex: 5, child:
                                SizedBox(
                                  height: 10.0,
                                )),
                                Expanded( flex: 3, child:
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 8.0,
                                    ),
                                    child: Text(
                                      eventosWS.eventos[i].toTitulo(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 23.0,
                                        fontFamily: "KanitBold"
                                      ),
                                    ),
                                  )
                                ),
                                // botton "ler mais"
                                Expanded( flex: 2, child:
                                Row(
                                  children: <Widget>[
                                    Expanded( flex: 4,
                                      child: containerNumero('Total: '+eventosWS.eventos[i].vagasTotal, Colors.greenAccent)
                                    ),
                                    Expanded(  flex: 4,
                                    child: containerNumero('Abertas: '+eventosWS.eventos[i].vagasRes, Colors.redAccent)
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    )         
                                    ],
                                )
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ) 
            );
            // adding cardItem to the widget list 
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        }
      ),
    );
  }
  Container containerNumero(String numero, Color cor){
    return Container(
          padding: const EdgeInsets.only(
            left: 12.0,
            bottom: 12.0,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 22.0,
              vertical: 6.0
            ),
            decoration: BoxDecoration(
              color: cor,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: Text(numero,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "KanitBold",
                    fontSize: 15
                  ),
              ),
            ),
          );
  }
}