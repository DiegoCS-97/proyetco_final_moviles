import 'package:flutter/material.dart';
import 'package:proyecto/log_in.dart';
import 'package:proyecto/scanner.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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
                SizedBox(height: 16.0),
                Text(
                  ' ',
                  style: Theme.of(context).textTheme.headline,
                ),
              ],
            ),
            SizedBox(height: 12.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                ),
              ),
              
            SizedBox(height: 12.0),
               TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('Entrar'),
                  elevation: 8.0,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(3.0)),
                  ),
                  onPressed: () async {
                   Navigator.push(context,
              MaterialPageRoute(builder: (_) => EscanerPage()
              ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 12.0),
              Text("Olvidaste tu contrasena?"),
            SizedBox(height: 20.0),
              Text("No tienes cuenta?"),
            MaterialButton(
            child: Text(
              "Registrate",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LogIn()));
            })
          ],
        ),
      ),
    );
  }
}