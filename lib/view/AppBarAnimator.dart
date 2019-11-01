import 'package:flutter/material.dart';
import 'CustomIcons.dart';

/* EXISTEM 3 CLASSE 
AppBarAnimator: invocado para iniciar a animação
AppBar: onde estão os componentes do appbar
AppBarEnterAnimation: controle das animações (duração, sequencia)
obs: colocar em três classe diferentes
*/

class AppBarAnimator extends StatefulWidget {
 final GlobalKey<ScaffoldState> _scaffoldKey;
  AppBarAnimator(GlobalKey<ScaffoldState> _scaffoldKey)
          : _scaffoldKey = _scaffoldKey,
          super(key: new ObjectKey(_scaffoldKey));

  @override
  _AppBarAnimatorState createState() => _AppBarAnimatorState(_scaffoldKey);
}

class _AppBarAnimatorState extends State<AppBarAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  GlobalKey<ScaffoldState> _scaffoldKey;
  _AppBarAnimatorState(this._scaffoldKey);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this, 
      duration: Duration(seconds: 3)
      );
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      controller: _controller, scaffoldKey: _scaffoldKey,
    );
  }
}

class AppBar extends StatelessWidget{
  GlobalKey<ScaffoldState> _scaffoldKey;
  
  AppBar({
    Key key,
    @required AnimationController controller,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  }) :  animation = AppBarEnterAnimation(controller),
        _scaffoldKey = scaffoldKey,
        super(key: key);

  final AppBarEnterAnimation animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation.controller,
      builder: (context, child) => _builderAnimation(context, child),
    );
  }

  Widget _builderAnimation(BuildContext context, Widget child){
    final size = MediaQuery.of(context).size;
    var colors = [Color(0xFF7fdefc), Color(0xFF00b5f8), Color(0xFF00c2fa), 
    Color(0xFF00d7fd), Color(0xFF00dbfc), Color(0xFF00ddfd)];
    return SizedBox(
      height: 120,
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          backGround(animation.barHeight.value, context, colors),
          menu(),
          logo(size),
          options(size)
        ],
      ),
    );
  }
  Container backGround(double height, BuildContext context, List<Color> colors){
    return Container(
            // alignment: Alignment.center,
            height: height,
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: colors,
            ),
            // boxShadow: [new BoxShadow(blurRadius: 1.0)],
            borderRadius: BorderRadius.vertical(
              bottom: new Radius.elliptical(
                MediaQuery.of(context).size.width, 120)
            ),
          ),
        );
  }
Positioned menu(){
  return  Positioned(
    top: 25.0,
    child:Transform(
        transform: Matrix4.diagonal3Values(
          animation.menu.value, 
          animation.menu.value, 
          1.0),         
        child: IconButton(
            icon: Icon(
              CustomIcons.menu,
              color: Colors.white,
              size: 30.0,
              ),
            onPressed: (){
            // Button drawer                         
              _scaffoldKey.currentState.openDrawer();
            },
          )
        )
  );
}

  Positioned logo(Size size){
    return Positioned(
      top: 35.0,
      left: size.width / 2 - 50,
      child: Transform(
        transform: Matrix4.diagonal3Values(
          animation.logo.value, 
          animation.logo.value, 
          1.0),
        child: Image.asset(
              "assets/images/logo2.png",
              width: 63.0,
              height: 42.0,
              color: Colors.white,
            ),
      ),
    );
  }

  Positioned options(Size size){
    return Positioned(
      top: 25.0,
      left: size.width - 50,
      child: Transform(
        transform: Matrix4.diagonal3Values(
          animation.option.value, 
          animation.option.value, 
          1.0),
        child: IconButton(
                icon: Icon(
                  CustomIcons.options,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: (){
                },//TODO
              ),
      ),
    );
  }
}
class AppBarEnterAnimation {
  AppBarEnterAnimation(this.controller)
      : barHeight = Tween<double>(begin: 0, end: 120).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0, 0.3, curve: Curves.easeIn),
          ),
        ),
        logo = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.3, 0.6, curve: Curves.elasticOut),
          ),
        ),
        menu = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.6, 0.65, curve: Curves.easeIn),
          ),
        ),
        option = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.65, 0.8),
          ),
        );

  final AnimationController controller;
  final Animation<double> barHeight;
  final Animation<double> logo;
  final Animation<double> menu;
  final Animation<double> option;
}