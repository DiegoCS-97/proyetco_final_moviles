import 'package:flutter/material.dart';
import 'documents/files_list.dart';
import 'scanner.dart';

class Welcome extends StatefulWidget {
  Welcome({Key key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool option;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Escaner"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "¡Bienvenido!",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w200,
                ),
              ),
              SizedBox(height: 50),
              Text("Para empezar elige una de las siguientes opciones",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  )),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EscanerPage(
                      option: false,
                    ),
                  ));
                },
                child: coolButton(
                    Colors.cyan[300], "Escaneo desde cámara", Icons.camera_alt),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => EscanerPage(
                      option: true,
                    ),
                  ));
                },
                child: coolButton(Colors.orange[300], "Escaneo desde galería",
                    Icons.photo_library),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Files(
                    ),
                  ));
                },
                child: coolButton(Colors.green[300], "Ver mis archivos",
                    Icons.picture_as_pdf),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget coolButton(Color color, String function, IconData icon) {
    return Container(
      decoration: new BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            function,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
