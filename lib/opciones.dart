import 'package:flutter/material.dart';

class OpcionesPage extends StatelessWidget {
  const OpcionesPage({Key key}) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Opciones'),
        ),
        body: HomePage(),
      )
    ;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 500,
                  width: 300,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        color: Color(0xffDEDEDE),
                        width: 300,
                        height: 70,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Perfil',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10, left: 10, right: 10,),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Ve o modifica la informacion de tu perfil.',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Color(0xffDEDEDE),
                        width: 300,
                        height: 70,
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Cerrar sesion',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10, left: 10, right: 10,),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Cerrar sesion en esta aplicacion',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}