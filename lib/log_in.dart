import 'package:flutter/material.dart';
import 'package:proyecto/sign_in.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mailController = TextEditingController();
  bool _passwordBlinded = true;
  bool accept = false;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset("",
           height: 150,
        ),
              ],
            ),
            SizedBox(height: 12.0),
            Text("Nombre Completo"),
            Container(
              child:TextField(
                controller: _usernameController,
              ),
            ),
               SizedBox(height: 12.0),
        Text("E-mail"),
        Container(
          child: TextField(
            controller: _mailController,
          ),
        ),
            SizedBox(height: 12.0),
            Text("Password"),
            Container(
               child: TextField(
            controller: _passwordController,
            obscureText: _passwordBlinded,
            decoration: InputDecoration(
                suffixIcon: Padding(
                    padding: EdgeInsets.only(top: 1.0),
                    child: IconButton(
                      icon: Icon(
                        _passwordBlinded
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordBlinded = !_passwordBlinded;
                        });
                      },
                    ))),
          ),
            ),
            Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                accept ? Icons.check_box : Icons.check_box_outline_blank
              ),
              onPressed: () {
                setState(() {
                  accept = !accept;
                });
              },
            ),
            Text(
              "ACEPTO LOS TERMINOS Y CONDICIONES DE USO",
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
         RaisedButton(
          child: Text('REGISTRARSE'),
          elevation: 8.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
          onPressed: () async {
           // Navigator.push(
             //   context,
              //  MaterialPageRoute(
                   // builder: (context) => Scanner()));
          },
        ),
            SizedBox(height: 15.0),
              Text("Ya tienes cuenta?", textAlign: TextAlign.center),
            MaterialButton(
            child: Text(
              "INGRESA",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            })
          ],
        ),
      ),
    );
  }
}